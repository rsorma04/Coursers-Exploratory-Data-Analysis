library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Aggregate emmision by year.
balt_total <- subset(NEI, NEI$fips == 24510)
total <- data.frame(aggregate(as.numeric(balt_total$Emissions), by = list(balt_total$year,
                                                                          balt_total$type), 
                              FUN = sum))
total$x <- round(total[, 3]/1000, 2)

png(filename='plot3.png', width=800, height=500, units='px')

ggplot(data = total, aes(x = factor(Group.1), y = x, fill=Group.2)) + 
  geom_bar(stat = 'identity') +
  scale_fill_brewer(palette="Set1") +
  facet_grid(facets = ~Group.2) + ylab("PM2.5 Emmissions in Kilotons") +
  xlab("Year") + ggtitle("PM2.5 Emmissions by Type - Baltimore Maryland 1999-2008")


dev.off()
