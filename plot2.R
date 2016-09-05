elect_data <- read.table("household_power_consumption.txt", sep = ";", header = T)
elect_data_sub <- subset(elect_data, elect_data$Date == "1/2/2007" | 
                           elect_data$Date == "2/2/2007")

# Check the class of Global Active Power.
class(elect_data_sub$Global_active_power)

# Change data type to numeric.
date_time <- strptime(paste(elect_data_sub$Date, elect_data_sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
global_active_power <- as.numeric(elect_data_sub$Global_active_power)

date_time

png("plot2.png", width=480, height=480)

plot(date_time, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
