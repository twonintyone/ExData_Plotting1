library(lubridate)
library(dplyr)
library(data.table)
data <- fread("household_power_consumption.txt", header = TRUE, sep = ";")
data1 <- data
data1$Date <- dmy(data1$Date)
data1 <- data1 %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# PNG1
data1$Global_active_power <- as.numeric(data1$Global_active_power)
hist(data1$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()