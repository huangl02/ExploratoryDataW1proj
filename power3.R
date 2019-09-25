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

windows(height = 7, width = 6)
plot(power2$time2, power2$Sub_metering_1,type="l", 
xlab="", ylab="Energy sub metering") 
lines(power2$time2, power2$Sub_metering_2,col="red")
lines(power2$time2, power2$Sub_metering_3,col="blue")

legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.copy(png, file="plot3.png")
dev.off()



