#read only required days of data into R using sqldf package  
library("sqldf")
  electricdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where (Date = '1/2/2007' or Date = '2/2/2007')", sep = ";", eol = "\n")
  closeAllConnections()

#convert date and time
  library(lubridate)
  electricdata$datetime <- parse_date_time(paste(electricdata$Date, electricdata$Time, sep = " "), orders="dmy HMS")

#create charts - plot4
  png(file = "plot4.png")
  par(mfrow = (c(2,2)))
    #first (top left)
    plot(electricdata$datetime, electricdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

    #second (top right)
    plot(electricdata$datetime, electricdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
    
    #third (bottom left)
    plot(electricdata$datetime, electricdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(electricdata$datetime, electricdata$Sub_metering_2, type = "l", col = "red")
    lines(electricdata$datetime, electricdata$Sub_metering_3, type = "l", col = "blue")
    legend("topright", inset = .009, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1, box.lty = "blank")
    
    #fourth
    plot(electricdata$datetime, electricdata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", yaxt = "n")
    axis(2, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), labels = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
  dev.off()