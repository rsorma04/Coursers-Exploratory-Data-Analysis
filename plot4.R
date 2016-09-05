elect_data <- read.table("household_power_consumption.txt", sep = ";", header = T)
elect_data_sub <- subset(elect_data, elect_data$Date == "1/2/2007" | 
                           elect_data$Date == "2/2/2007")
head(elect_data_sub)

# Check the classes of all data elements.
sapply(elect_data_sub, class)

# Everything besides Sub_metering_3 is a factor.  For data/time need to convert to data/time.
# For measures they will be converted to numeric.
date_time <- strptime(paste(elect_data_sub$Date, elect_data_sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
global_active_power <- as.numeric(elect_data_sub$Global_active_power)
global_reactive_power <- as.numeric(elect_data_sub$Global_reactive_power)
voltage <- as.numeric(elect_data_sub$Voltage)
global_intesity <- as.numeric(elect_data_sub$Global_intensity)
sub_metering_1 <- as.numeric(elect_data_sub$Sub_metering_1)
sub_metering_2 <- as.numeric(elect_data_sub$Sub_metering_2)
sub_metering_3 <- as.numeric(elect_data_sub$Sub_metering_3)

png("plot4.png", width=480, height=480)




dev.off()