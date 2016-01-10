library(data.table)
library(grDevices)
raw <- fread("household_power_consumption.txt", header = TRUE, colClasses = "character")
raw <- raw[, Date:=as.Date(strptime(Date,"%d/%m/%Y"))]
power <- subset(raw, Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))

power <- as.data.frame(power)
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Date_time <- paste(power$Date, power$Time)
power$Date_time <- as.POSIXlt(power$Date_time)

png("plot2.png")
with(power, plot(Date_time, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(power, lines(Date_time, Global_active_power))
dev.off()