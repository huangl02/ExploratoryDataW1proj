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

par(mfrow=c(2,2))

with(power2, plot(time2, Global_active_power,type="l",xlab="", ylab="Global Active Power"))
with(power2, plot(time2, Voltage, type="l", xlab="datetime", ylab="Voltage"))

plot(power2$time2, power2$Sub_metering_1,type="l", 
xlab="", ylab="Energy sub metering") 
lines(power2$time2, power2$Sub_metering_2,col="red")
lines(power2$time2, power2$Sub_metering_3,col="blue")
legend(1170360557,40, lty=c(1,1,1), col=c("black","red","blue"), 
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")

with(power2, plot(time2, Global_reactive_power, type="l", xlab="datetime"))

dev.copy(png, file="plot4.png")
dev.off()

#use size below to find the postion of the legend
#size<-legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
#+ legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")


