#read only required days of data into R using sqldf package  
  library("sqldf")
  electricdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where (Date = '1/2/2007' or Date = '2/2/2007')", sep = ";", eol = "\n")
  closeAllConnections()

#convert date and time
  library(lubridate)
  electricdata$datetime <- parse_date_time(paste(electricdata$Date, electricdata$Time, sep = " "), orders="dmy HMS")

#create line chart - plot3
  png(file = "plot3.png")
  plot(electricdata$datetime, electricdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(electricdata$datetime, electricdata$Sub_metering_1, type = "l")
  lines(electricdata$datetime, electricdata$Sub_metering_2, type = "l", col = "red")
  lines(electricdata$datetime, electricdata$Sub_metering_3, type = "l", col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1)
  dev.off()