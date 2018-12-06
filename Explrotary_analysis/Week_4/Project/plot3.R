#--------------------------------------------------------------------------------------------------------
# John Hopkins coursera data science specilization, Exploratory analysis course
# project 1.
#------------------------------------------------------------------------------------------------------------------

setwd("~/DataScience/datasciencecoursera/datasciencecoursera/Explrotary_analysis/Week_4/Project")
library(data.table)
library(dplyr)
library(ggplot2)
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
# 2. Reading data into R and Cleaning it
#------------------------------------------------------------------------------------------------------------------"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#------------------------------------------------------------------------------------------------------------------
# 3. Plotting
#------------------------------------------------------------------------------------------------------------------
png("plot3.png", width=640, height=480)
NEI %>% filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarize(total = sum(Emissions)) %>%
    ggplot(aes(x= factor(year), y = total, fill = type))+
    geom_bar(stat="identity") + facet_grid(.~type) +
    xlab("Year") + ylab("Total Emissions in tons") + ggtitle("Yearly total emissions by type")
dev.off()