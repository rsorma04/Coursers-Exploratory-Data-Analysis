SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Aggregate emmision by year.
balt_total <- subset(NEI, NEI$fips == 24510)
total <- data.frame(aggregate(as.numeric(balt_total$Emissions), by = list(balt_total$year), 
                              FUN = sum))
total$x <- round(total[, 2]/1000, 2)

png(filename='plot2.png')

ylim <- c(0, 1.1*max(total$x))

xx <- barplot(total$x, names = total$Group.1, 
              main = "Baltimore City -  PM2.5 Emissions by Year", xlab = "Year", 
              ylab = "PM2.5 In Kilotons",
              width = 0.85, ylim = ylim)
text(x = xx, y = total$x, label = total$x, pos = 3, cex = 1)


dev.off()