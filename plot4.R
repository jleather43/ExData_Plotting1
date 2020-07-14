## read the data
data_full <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

## convert the date variable to Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## subset the data
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert dates and times
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

## plot 4
par(mfrow = c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, { 
plot(Global_active_power ~ datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(Voltage ~ datetime, type="l", xlab="datetime", ylab="Voltage (volt)")
plot(Sub_metering_1~datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~datetime,col='Red')
lines(Sub_metering_3~datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Global_reactive_power ~ datetime, type="l", xlab="datetime", ylab="Global_reactive_power")
})

## saving to file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
