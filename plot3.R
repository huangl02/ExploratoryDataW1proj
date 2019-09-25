NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

library(ggplot2)

#subset data from Baltimore City (flip=24510)
balpm<-subset(NEI, fips=="24510")

g<-ggplot(balpm, aes(year, Emissions))
g+geom_point()+facet_grid(.~type)+
geom_smooth(method="lm", se=FALSE)+
coord_cartesian(ylim=c(-10,400))+labs(y="PM2.5 Emission (tons) in Baltimore City")+
ggtitle("From 1999 to 2008 NONPOINT and POINT have seen decreases \nNON-ROAD has seen slight decrease
ON-ROAD has not changed")+ 
theme(plot.title = element_text(hjust = 0.5))

dev.copy(png, file="plot3.png")
dev.off()