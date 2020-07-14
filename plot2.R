## read the data
data_full <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

## convert the date variable to Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## subset the data
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert dates and times
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

## plot 2
attach(data)
plot(data$Global_active_power ~ data$datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## saving to file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()

