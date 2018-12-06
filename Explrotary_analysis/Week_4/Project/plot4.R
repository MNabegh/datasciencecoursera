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
coal_matches <- grep(SCC$Short.Name, pattern = "coal", ignore.case = T)
coal_sources <- SCC$SCC[coal_matches]
coal_data <- NEI %>% filter(SCC %in% coal_sources)
coal_data <- coal_data %>% group_by(year) %>% summarize(total = sum(Emissions)) 

#------------------------------------------------------------------------------------------------------------------
# 3. Plotting
#------------------------------------------------------------------------------------------------------------------
png("plot4.png", width=640, height=480)

plot <- coal_data %>% ggplot(aes(x = year, y = total))
print(plot + geom_col(fill = brewer.pal(4, "Set1")) + ggtitle("Yearly total emissions from Coal Sources")+
    ylab("Total PM2.5 Emissions in tons") + xlab("Year")  +
    scale_x_continuous( breaks = seq(1999, 2008, by = 3), labels = seq(1999, 2008, by = 3)))

dev.off()