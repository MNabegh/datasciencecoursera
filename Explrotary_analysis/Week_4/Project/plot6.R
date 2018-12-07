#--------------------------------------------------------------------------------------------------------
# John Hopkins coursera data science specilization, Exploratory analysis course
# project 2.
#------------------------------------------------------------------------------------------------------------------

setwd("~/DataScience/datasciencecoursera/datasciencecoursera/Explrotary_analysis/Week_4/Project")
library(data.table)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
#------------------------------------------------------------------------------------------------------------------
# 1. Download and unzip the file
#------------------------------------------------------------------------------------------------------------------

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destFile = "exdata%2Fdata%2FNEI_data.zip"

if (!file.exists(destFile))
    download.file(fileUrl, destfile = destFile, mode = "auto")

folderName = "FNEI_data"

if(!file.exists(folderName))
    unzip(destFile)

rm(destFile, folderName, fileUrl)

#------------------------------------------------------------------------------------------------------------------
# 2. Reading data into R 
#------------------------------------------------------------------------------------------------------------------"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#------------------------------------------------------------------------------------------------------------------
# 3. Cleaning Data
#------------------------------------------------------------------------------------------------------------------"
motor_veichles_matches <- grep( SCC$EI.Sector, pattern = "Mobile.*Vehicles", ignore.case = T)
motor_veichles_sources <- unique(SCC$SCC[motor_veichles_matches])
motor_veichles_data <- NEI %>% filter(SCC %in% motor_veichles_sources & fips %in% c("24510", "06037"))
motor_veichles_data <- motor_veichles_data %>% group_by(year, fips) %>% summarize(total = sum(Emissions)) %>%
    mutate(County = ifelse(fips == "24510", yes = "Baltimore City", no = "Los Angeles County")) 

#------------------------------------------------------------------------------------------------------------------
# 3. Plotting
#------------------------------------------------------------------------------------------------------------------
png("plot6.png", width=640, height=480)

plot <- motor_veichles_data %>% ggplot(aes(x = year, y = total, color = County))
print(plot + geom_line() + ggtitle("Yearly total emissions from Motor Veichles Sources")+
          ylab(expression("Total PM"[2.5]*" Emissions in tons"))+ xlab("Year")  +
          scale_x_continuous( breaks = seq(1999, 2008, by = 3), labels = seq(1999, 2008, by = 3)))

dev.off()
rm(list = ls())