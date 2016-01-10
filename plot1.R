library(data.table)
library(grDevices)
raw <- fread("household_power_consumption.txt", header = TRUE, colClasses = "character")
raw <- raw[, Date:=as.Date(strptime(Date,"%d/%m/%Y"))]
power <- subset(raw, Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))
power$Global_active_power <- as.numeric(power$Global_active_power)
png("plot1.png")
with(power, hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
dev.off()