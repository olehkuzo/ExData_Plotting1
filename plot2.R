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

par(mar=c(2,4,1,1))
plot(mysubset$DateTime, mysubset$Global_active_power, type = "l",xlab=NULL, ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off() ## close the PNG device


