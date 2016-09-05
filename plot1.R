elect_data <- read.table("household_power_consumption.txt", sep = ";", header = T)
elect_data_sub <- subset(elect_data, elect_data$Date == "1/2/2007" | 
                           elect_data$Date == "2/2/2007")
head(elect_data_sub)

# Check the class of Global Active Power.
class(elect_data_sub$Global_active_power)

# Change data type to numeric.
global_active_power <- as.numeric(elect_data_sub$Global_active_power)

png("plot1.png", width=480, height=480)

hist(global_active_power, col = 'red', main = "Global Active Power",
     xlab = "Global Active Power (killowatts)")

dev.off()