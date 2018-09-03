#load library
library(data.table)

#generate subset 
writeLines(grep("^[1,2]/2/2007", readLines(file("household_power_consumption.txt")), value = TRUE), con = file("household_power_consumption_subset.txt"))
# load subset into data frame
df_power_comp <- fread("household_power_consumption_subset.txt", sep = ";", na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Convert Datetime column
vDatetime <- paste(df_power_comp$Date, df_power_comp$Time)
vDatetime <- strptime(vDatetime, "%d/%m/%Y %H:%M:%S")

#Add datetime column to dataframe
df_power_comp$Datetime <- as.POSIXct(vDatetime)

# open png device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# plotting graphic 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(df_power_comp, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})
# close device
dev.off()