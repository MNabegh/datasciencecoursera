#--------------------------------------------------------------------------------------------------------
# John Hopkins coursera data science specilization, Exploratory analysis course
# project 1.
#------------------------------------------------------------------------------------------------------------------

setwd("~/DataScience/datasciencecoursera/datasciencecoursera/Explrotary_analysis/Week_4/Project")
library(data.table)
library(dplyr)

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
total <- tapply(NEI$Emissions, NEI$year, sum)
barplot(total, xlab = "Year", ylab = "Total emissions in Tons", main = "Yearly PM2.5 emission")
dev.copy(png, file = 'plot1.png')
dev.off()