NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

#get all the codes for motor vehicle sources
mobile<-SCC[grep("Vehicle", SCC$SCC.Level.Two),]
vehCode<-mobile$SCC

#subset NEI to get only data from Baltimore and LA with SCC codes 
#that represent moter vehicle
twoCity<-subset(NEI, fips=="24510"|fips=="06037")
twoCityVeh<-subset(twoCity, SCC %in% vehCode)

#calculate the sum of pm2.5 by year and by city
pm25<-with(twoCityVeh, tapply(Emissions, list(year, fips), sum))

#change column names to the city/county names
colnames(pm25)<-c("Baltimore City", "Los Angeles County")

par(mfrow=c(1,2))

plot(row.names(pm25), pm25[,2],pch=19, cex=2, xlab="year", 
ylab="PM2.5 emissions (tons) from motor vehicle sources",
main="PM2.5 emissions from motor 
vehicles has a decreasing trend from 
1999 to 2008 in Baltimore City")
modelbal<-lm(pm25[,2]~as.numeric(row.names(pm25)))
abline(modelbal, lwd=2)

plot(row.names(pm25), pm25[,1], pch=19, cex=2, xlab="year", 
ylab="PM2.5 emissions (tons) from motor vehicle sources",
main="PM2.5 emissions from motor 
vehicles has an increasing trend from 
1999 to 2008 in Los Angeles County")
modelLA<-lm(pm25[,1]~as.numeric(row.names(pm25)))
abline(modelLA,lwd=2)

dev.copy(png, file="plot6.png", width = 800, height = 600)
dev.off()