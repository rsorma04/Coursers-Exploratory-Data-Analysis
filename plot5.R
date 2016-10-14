setwd("C:/Users/rocco.sorma/Desktop/R_PROGRAMMING/EXPLORATORY_DATA_ANALYSIS/PROJECT")

library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

veh_scc <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
veh_scc <- SCC[veh_scc,]$SCC

balt_nei_veh <- NEI[NEI$SCC %in% veh_scc,]
balt_nei_veh <- balt_nei_veh[balt_nei_veh$fips == "24510",]


balt_veh_total <- data.frame(aggregate(as.numeric(balt_nei_veh$Emissions), by = list(balt_nei_veh$year), FUN = sum))
balt_veh_total$x <- round(balt_veh_total[, 2], 0)

png(filename='plot5.png')

qplot(data=balt_veh_total, x=balt_veh_total$Group.1,
      y=balt_veh_total$x, geom= "line") + geom_line(size=1, color="red") +
  geom_text(label=balt_veh_total$x, size=3, hjust=1.5, vjust=1) +
  ggtitle("Emissions from Vehciles In Baltimore (1999-2008)") + 
  xlab("Year") + ylab("PM2.5 Emissions in Tons") +
  geom_point(size = 2)

dev.off()