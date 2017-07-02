#read only required days of data into R using sqldf package  
library("sqldf")
  electricdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where (Date = '1/2/2007' or Date = '2/2/2007')", sep = ";", eol = "\n")
  closeAllConnections()

#create histogram - plot1
  png(file = "plot1.png")
  hist(electricdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()