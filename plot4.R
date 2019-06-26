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

## Plot 4


## Create PNG plot device with 480x480 dimensions

png("./plot4.png",
    width = 480,
    height = 480,
    units = "px")

## set parameters for 2 x 2 layout
par(mfrow = c(2, 2))


## Populate 2 x 2 layout by row

## subplot 1

plot(df$DateTime, df$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

## subplot 2

plot(df$DateTime, df$Voltage,
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")

## subplot 3

plot(df$DateTime, df$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")

points(df$DateTime, df$Sub_metering_2, 
       type = "l", 
       col = "red")

points(df$DateTime, 
       df$Sub_metering_3, 
       type = "l", 
       col = "blue")

## Create vectors for legend

legtxt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legcol <- c("black", "red", "blue")
leglty <- c(1, 1, 1)

legend("topright", 
       legend = legtxt, 
       col = legcol, 
       lty = leglty,
       bty = "n")


## Subplot 4

plot(df$DateTime, df$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")


dev.off()
