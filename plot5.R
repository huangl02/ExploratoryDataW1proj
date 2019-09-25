NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

mobile<-SCC[grep("Vehicle", SCC$SCC.Level.Two),]
vehCode<-mobile$SCC

balVeh<-subset(NEI, fips=="24510" & SCC %in% vehCode)

pm25<-with(balVeh, tapply(Emissions, year, sum))

plot(names(pm25), pm25, pch=19, cex=2, ylim=c(0, 500), xlab="year", 
ylab="PM2.5 emissions (tons) from motor vehicle sources",
main="PM2.5 from motor vehicles have decreased 
from 1999 to 2008 in Baltimore City")
model<-lm(pm25~as.numeric(names(pm25)))
abline(model,lwd=2)

dev.copy(png, file="plot5.png")
dev.off()