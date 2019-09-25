NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

coal<-SCC[grep("[Cc]oal",SCC$EI.Sector),]
coalCode<-coal$SCC
coalpm<-subset(NEI, SCC %in% coalCode)

total<-with(coalpm, tapply(Emissions, year, sum, na.rm=TRUE))

plot(names(total), total, xlim=c(1999,2008), xlab="Year",
ylab="PM2.5 emissions from coal combustion (tons)", pch=19, cex=2, )
trendln<-lm(total~as.numeric(names(total)))
abline(trendln, lwd=2)

title(main="PM2.5 emissions from coal combustion
have decreased from 1999 to 2008 in the US")

dev.copy(png, file="plot4.png")
dev.off()