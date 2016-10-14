setwd("C:/Users/rocco.sorma/Desktop/R_PROGRAMMING/EXPLORATORY_DATA_ANALYSIS/PROJECT")

library(ggplot2)
library(grid)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

balt_la_veh_scc <- grepl("vehcile", SCC$SCC.Level.Two, ignore.case = TRUE)
balt_la_veh_scc <- SCC[veh_scc,]$SCC

balt_la_nei_veh <- NEI[NEI$SCC %in% veh_scc,]
balt_la_nei_veh.1 <- subset(balt_la_nei_veh, balt_la_nei_veh$fips == "24510")
balt_la_nei_veh.2 <- subset(balt_la_nei_veh, balt_la_nei_veh$fips == "06037")

balt_la_veh_total.1 <- data.frame(aggregate(as.numeric(balt_la_nei_veh.1$Emissions), by = list(balt_la_nei_veh.1$year), FUN = sum))
balt_la_veh_total.1$x <- round(balt_la_veh_total.1[, 2], 0)

balt_la_veh_total.2 <- data.frame(aggregate(as.numeric(balt_la_nei_veh.2$Emissions), by = list(balt_la_nei_veh.2$year), FUN = sum))
balt_la_veh_total.2$x <- round(balt_la_veh_total.2[, 2], 0)

png(filename='plot6.png')

qplot1.y = qplot(x = balt_la_veh_total.1$Group.1, y = balt_la_veh_total.1$x) +
           geom_bar(stat = "identity", fill = "green", width = 1.5) +
           ggtitle("Emissions from Vehciles In Baltimore (1999-2008)") +
           xlab("Year") + ylab("PM2.5 Emissions in Tons") +
           geom_text(label=balt_la_veh_total.1$x, size=4, hjust=1.5, vjust=.25)
qplot2.y = qplot(x = balt_la_veh_total.2$Group.1, y = balt_la_veh_total.2$x) +
           geom_bar(stat = "identity", fill="yellow", width = 1.5) +
           ggtitle("Emissions from Vehciles In Los Angeles (1999-2008)") +
           xlab("Year") + ylab("PM2.5 Emissions in Tons") +
           geom_text(label=balt_la_veh_total.2$x, size=4, hjust=1.5, vjust=1)

grid.newpage()
grid.draw(rbind(ggplotGrob(qplot1.y), ggplotGrob(qplot2.y), size = "last"))

dev.off()