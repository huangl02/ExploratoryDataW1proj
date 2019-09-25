NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

total<-with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))
#Instead of use tappy, can also use aggreate function as below
#agg<-aggregate(Emissions~year, NEI, sum) 

plot(names(total), total, xlim=c(1999,2008), xlab="Year", 
ylab="Total Emissions from PM2.5 (ton)", pch=19, cex=2, )
trendln<-lm(total~as.numeric(names(total)))
abline(trendln, lwd=2)

title(main="Total emissions from pm2.5 \n have decreased from 1999 to 2008 
in the US")

dev.copy(png, file="plot1.png")
dev.off()