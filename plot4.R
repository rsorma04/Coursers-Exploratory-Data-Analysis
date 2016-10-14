setwd("C:/Users/rocco.sorma/Desktop/R_PROGRAMMING/EXPLORATORY_DATA_ANALYSIS/PROJECT")

library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

coal_comb <- SCC[grepl("Coal", SCC$Short.Name),]
# Implicitly subsets to those records w/coal coal in the SCC$Short.Name
nei_coal_comb <- NEI[NEI$SCC %in% coal_comb$SCC,]

nei_coal_comb_total <- data.frame(aggregate(as.numeric(nei_coal_comb$Emissions), by = list(nei_coal_comb$year), FUN = sum))
nei_coal_comb_total$x <- round(nei_coal_comb_total[, 2]/1000, 0)

png(filename='plot4.png')

qplot(data=nei_coal_comb_total, x=nei_coal_comb_total$Group.1,
      y=nei_coal_comb_total$x, geom= "line") + geom_line(size=1, color="red") +
      geom_text(label=nei_coal_comb_total$x, size=3, hjust=1.5, vjust=1) +
      ggtitle("Total PM2.5 Emissions From Carbon Cumbustion (199-2008)") + 
              xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
      geom_point(size = 2)

dev.off()