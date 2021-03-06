#------------------------------------------------------------------------------------------------------------------
# John Hopkins coursera data science specilization, Exploratory analysis course
# project 1.
#------------------------------------------------------------------------------------------------------------------

setwd("~/DataScience/datasciencecoursera/Explrotary_analysis/Week_1/Project")
library(data.table)
library(dplyr)

#------------------------------------------------------------------------------------------------------------------
# 1. Download and unzip the file
#------------------------------------------------------------------------------------------------------------------

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile = "Electric power consumption.zip"

if (!file.exists(destFile))
    download.file(fileUrl, destfile = destFile, mode = "wb")

folderName = "household_power_consumption.txt"

if(!file.exists(folderName))
    unzip(destFile)

rm(destFile, folderName, fileUrl)

#------------------------------------------------------------------------------------------------------------------
# 2. Reading data into R and Cleaning it
#------------------------------------------------------------------------------------------------------------------
data = data.table::fread("household_power_consumption.txt", sep = ';', na.strings = "?")
data[, 'Date'] = as.Date(data[[1]], format = "%d/%m/%Y")
data = filter(data, Date <= as.Date("2007-02-02") & Date >= as.Date("2007-02-01"))
data[, 'Time'] = paste(data[[1]], data[[2]], sep = " ")
data = data %>% rename(timestamp = Time) %>% select(-c(Date)) %>%
    mutate(timestamp = as.POSIXct(timestamp),
           day_of_the_week = weekdays.POSIXt(timestamp)) 


#------------------------------------------------------------------------------------------------------------------
# 3. Plotting
#------------------------------------------------------------------------------------------------------------------

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)",
     col = 'red', main = "Global Active Power")

dev.copy(png, file = 'plot1.png')
dev.off()