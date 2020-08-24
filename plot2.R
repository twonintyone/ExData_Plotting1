library(lubridate)
library(dplyr)
library(data.table)
data <- fread("household_power_consumption.txt", header = TRUE, sep = ";")
data1 <- data
data1$Date <- dmy(data1$Date)
data1 <- data1 %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

## PNG2
data1$nTime <- paste(data1$Date, data1$Time)
data1$nTime <- ymd_hms(data1$nTime)
with(data1, plot(nTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
lines(data1$nTime, data1$Global_active_power)
dev.copy(png, file = "plot2.png")
dev.off()