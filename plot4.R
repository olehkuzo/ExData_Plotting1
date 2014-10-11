temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
con <- unz(temp, "household_power_consumption.txt")
data <- read.table(con, header=TRUE, sep=";", quote = "\"", fileEncoding="UTF-8", fill=TRUE, na.strings = c("?"))
unlink(temp)

summary(data)
# 2,075,259 rows and 9 columns
typeof(data$Time[1])
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#typeof(data$DateTime[1])
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
mysubset<-data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

par(mfrow = c(2, 2), mar=c(4,4,2,2))
with (mysubset, {
  plot(mysubset$DateTime, mysubset$Global_active_power, type = "l",xlab="", ylab="Global Active Power")
  
  plot(mysubset$DateTime, mysubset$Voltage, type = "l",xlab="datetime", ylab="Voltage")
  
  plot(mysubset$DateTime, mysubset$Sub_metering_1, type = "l",xlab="", ylab="Energy sub metering")
  lines(mysubset$DateTime, mysubset$Sub_metering_2, type='l', col="red")
  lines(mysubset$DateTime, mysubset$Sub_metering_3, type='l', col="blue")
  legend("topright", legend=c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "), lwd=2,  col = c("black", "red", "blue"),bty = "n", cex=0.6, pt.cex = 1)
  
  plot(mysubset$DateTime, mysubset$Global_reactive_power, type = "l",xlab="datetime", ylab="Global_reactive_power")
})

dev.copy(png, file = "plot4.png", width = 480, height = 480) 
dev.off() ## close the PNG device


