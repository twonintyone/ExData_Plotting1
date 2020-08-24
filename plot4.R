library(lubridate)
library(dplyr)
library(data.table)
data <- fread("household_power_consumption.txt", header = TRUE, sep = ";")
data1 <- data
data1$Date <- dmy(data1$Date)
data1 <- data1 %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

data1$nTime <- paste(data1$Date, data1$Time)
data1$nTime <- ymd_hms(data1$nTime)
data1$Global_active_power <- as.numeric(data1$Global_active_power)
data1$Voltage <- as.numeric(data1$Voltage)
data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power)

par(mfrow = c(2,2), mar = c(4, 4, 2, 1))
with(data1, {
  plot(nTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  plot(nTime, Voltage, xlab = "datatime", ylab = "Voltage", type = "l")
})
with(data1, plot(nTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
lines(data1$nTime, data1$Sub_metering_1, type = "l")
lines(data1$nTime, data1$Sub_metering_2, col = "red", type = "l")
lines(data1$nTime, data1$Sub_metering_3, col = "blue", type = "l")
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       lwd = 2,
       cex = 0.8,
       bty = "n")
with(data1, plot(nTime, Global_reactive_power, xlab = "datetime", type = "l"))
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
