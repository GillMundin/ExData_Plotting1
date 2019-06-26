## Set working directory
setwd("~/R/Coursera/Data analysis/Week1Assignment/ExData_Plotting1")

## Define file location

locat <- "./household_power_consumption.txt"


## Read in column names from txt file
colNames <- names(read.table(locat, 
                             nrow = 1, 
                             header = TRUE, 
                             sep=";"))

## When using grep, [...] allows you to match any characters in a list
## using ^ allows you to match any characters NOT in a list

df <- read.table(locat, 
                 na.strings = "?", 
                 sep = ";", 
                 header = F, 
                 col.names = colNames, 
                 skip = grep("^[1,2]/2/2007", readLines(locat))-1, 
                 nrow = 2880)

## Convert date column to class = Date, and add a DateTime column, class = POSIXlt

library(lubridate)

df$Date <- dmy(df$Date)

df$DateTime <- strptime(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")

## Plot 1

## Create PNG plot device with 480x480 dimensions

png("./plot1.png", 
    width = 480,
    height = 480,
    units = "px")

hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()