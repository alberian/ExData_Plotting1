library(data.table)
library(grDevices)
raw <- fread("household_power_consumption.txt", header = TRUE, colClasses = "character")
raw <- raw[, Date:=as.Date(strptime(Date,"%d/%m/%Y"))]
power <- subset(raw, Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))

power <- as.data.frame(power)
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Date_time <- paste(power$Date, power$Time)
power$Date_time <- as.POSIXlt(power$Date_time)

png("plot4.png")
par(mfrow = c(2,2))

with(power, plot(Date_time, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(power, lines(Date_time, Global_active_power))

with(power, plot(Date_time, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(power, lines(Date_time, Voltage))

with(power, plot(Date_time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy/ sub metering"))
with(power, lines(Date_time, Sub_metering_1))
with(power, lines(Date_time, Sub_metering_2, col = "red"))
with(power, lines(Date_time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 2, col = c("black", "red", "blue"), cex = 0.75)

with(power, plot(Date_time, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
with(power, lines(Date_time, Global_reactive_power))

dev.off()