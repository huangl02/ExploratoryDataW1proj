NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

#subset data from Baltimore City (flip=24510)
balpm<-subset(NEI, fips=="24510")

#sum all the emissions from each year
total<-with(balpm, tapply(Emissions, year, sum, na.rm=TRUE))

plot(names(total), total, xlim=c(1999,2008), xlab="Year", 
ylab="Total Emissions from PM2.5 (ton)", pch=19, cex=2, )
trendln<-lm(total~as.numeric(names(total))) #add linear regression line
abline(trendln, lwd=2)

title(main="Total emissions from pm2.5 \n have decreased from 1999 to 2008 
in Baltimore City")

dev.copy(png, file="plot2.png")
dev.off()