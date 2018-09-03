#load library
library(data.table)

#generate subset 
writeLines(grep("^[1,2]/2/2007", readLines(file("household_power_consumption.txt")), value = TRUE), con = file("household_power_consumption_subset.txt"))
# load subset into data frame
df_power_comp <- fread("household_power_consumption_subset.txt", sep = ";", na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# plot the histogram (graphic 1)
hist(df_power_comp$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# close device
dev.off()