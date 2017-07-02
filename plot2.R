#read only required days of data into R using sqldf package  
library("sqldf")
  electricdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where (Date = '1/2/2007' or Date = '2/2/2007')", sep = ";", eol = "\n")
  closeAllConnections()

#convert date and time
  library(lubridate)
  electricdata$datetime <- parse_date_time(paste(electricdata$Date, electricdata$Time, sep = " "), orders="dmy HMS")

#create line chart - plot2
  png(file = "plot2.png")
  plot(electricdata$datetime, electricdata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
  lines(electricdata$datetime, electricdata$Global_active_power, type = "l")
  dev.off()