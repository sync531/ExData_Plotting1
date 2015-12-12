setwd("C:/Users/S.Y CHOI/Desktop") # I want PNG files to be saved on my Desktop
library(dplyr) # I used dplyr package's filter function to subset raws based on date

# Setting locale to en_US for proper labels of date and time
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale("LC_TIME", "English") # Without these two lines of code, the date label gets printed in my local language which is not English

rawdata <- read.table("C:/Users/S.Y CHOI/Desktop/R/wd/expproject1/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
rawdata$Date <- as.Date(rawdata$Date, "%d/%m/%Y")

data <- rawdata %>% filter(Date >= "2007-02-01", Date <= "2007-02-02") # Subset relevant rows
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S") # Add datetime variable for later use
rm(rawdata) # Remove the original dataset as it is no longer needed

# # PLOT 1 -------------------------------------------------------------------

png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", cex.axis = .5, cex.lab = .8, cex.main = .8)

dev.off()

# # Reset Settings -----------------------------------------------------------
Sys.setlocale(category = "LC_TIME", locale = locale_original)