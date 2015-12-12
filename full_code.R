setwd("C:/Users/S.Y CHOI/Desktop") # I want PNG files to be saved on my Desktop

# # Prelim: Read & Subset dataset -------------------------------------------
library(dplyr) # I used dplyr package's filter function to subset raws based on date
reset <- par("mar") # Save the original margin setting

# Setting locale to en_US for proper labels of date and time
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale("LC_TIME", "English") # Without these two lines of code, the date label gets printed in my local language which is not English

rawdata <- read.table("C:/Users/S.Y CHOI/Desktop/R/wd/expproject1/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
rawdata$Date <- as.Date(rawdata$Date, "%d/%m/%Y")

data <- rawdata %>% filter(Date >= "2007-02-01", Date <= "2007-02-02") # Subset relevant rows
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S") # Add datetime variable for later use
rm(rawdata) # Remove the original dataset as it is no longer needed

# # PLOT 1 ------------------------------------------------------------------
png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", cex.axis = .5, cex.lab = .8, cex.main = .8)

dev.off()
# # PLOT 2 ------------------------------------------------------------------
png("plot2.png", width = 480, height = 480)

plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", cex.axis = .6, cex.lab = .8)

dev.off()
# # PLOT 3 ------------------------------------------------------------------
png("plot3.png", width = 480, height = 480)

plot(data$datetime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex.axis = .6, cex.lab = .8)
points(data$datetime, data$Sub_metering_1, type = "l")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .8)

dev.off()
# # PLOT 4 ------------------------------------------------------------------
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(4.1, 4.1, 1.1, 2.1))

# Top-left Plot
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", cex.axis = 1, cex.lab = .8)

# Top-right Plot
plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", cex.axis = 1, cex.lab = .8)

# Bottom-left Plot
plot(data$datetime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex.axis = 1, cex.lab = .8)
points(data$datetime, data$Sub_metering_1, type = "l")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .7, bty = "n")

# Bottom-right Plot
plot(data$datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", cex.axis = 1, cex.lab = .8)

dev.off()
# # Reset Settings -----------------------------------------------------------
par(mfrow = c(1, 1), mar = reset)
Sys.setlocale(category = "LC_TIME", locale = locale_original)
