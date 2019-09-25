library(dplyr)
library(lubridate)

power<-read.table("household_power_consumption.txt",
sep=";", colClasses=("Date"="character"),
skip=30000, 
nrow=40000,
col.names=colnames(read.table("household_power_consumption.txt", 
sep=";", nrow=1,header=TRUE)))

power1<-power[grep("[12]/2/2007", power$Date),]

power1[,3:9]<-sapply(power1[,3:9], as.numeric)

power2<-power1 %>% mutate(date2=as.POSIXct(strptime(Date, "%d/%m/%Y")))
power2<-power2 %>% mutate(time2=as.POSIXct(paste(date2, 
Time,format="%Y-%m-%d %H:%M:%S")))


with(power2, plot(time2, Global_active_power,type="l", 
xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png, file="plot2.png")
dev.off()




