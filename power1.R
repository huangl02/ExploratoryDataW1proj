library(dplyr)
library(lubridate)

power<-read.table("household_power_consumption.txt",
sep=";", colClasses=("Date"="character"),
skip=30000, 
nrow=40000,
col.names=colnames(read.table("household_power_consumption.txt", 
sep=";", nrow=1,header=TRUE)))

power1<-power[grep("[12]/2/2007", power$Date),]

#can also use subset
#power1<-subset(power, power$Date=="1/2/2007" | power$Date=="2/2/2007")

power1[,3:9]<-sapply(power1[,3:9], as.numeric)



hist(power1$Global_active_power, col="red", 
xlab="Global Active Power (kilowatts)",main="Global Active Power") #plot1
dev.copy(png,file="plot1.png")
dev.off()





