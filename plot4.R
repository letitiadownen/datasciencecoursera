## input zip data to R 

zipurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"## input zip data to R 


##unzip files
library(data.table)
library(lubridate)
library(dplyr)
temp <- tempfile()


download.file(zipurl, temp)
unzip(temp,exdir="./course4_proj1")
rm(temp)

#read file into R and set column names to lower case
data<-read.table("./course4_proj1/household_power_consumption.txt",na.strings = "?",header=TRUE,sep = ";")
colnames(data)<-tolower(names(data))

#subset the dates of interest
desdata<-subset(data,date %in% c("1/2/2007","2/2/2007"))

#load png device, create histogram, close

png(file="./course4_proj1/plot4.png",width = 480,height = 480)

datetime<-strptime(paste(desdata$date,desdata$time,sep=" "),"%d/%m/%Y %H:%M:%S")
globalactivepower<-as.numeric(desdata$global_active_power)

par(mfrow=c(2,2))

with(desdata{
plot(datetime,globalactivepower,xlab="",ylab="Global Active Power(Kilowatts)",type="l")

plot(datetime,desdata$voltage,type="l",ylab="Voltage")

plot(datetime,desdata$sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
points(datetime,desdata$sub_metering_2,type="l",col="red")
points(datetime,desdata$sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))


plot(datetime,desdata$global_reactive_power,type="l",ylab="Global_reactive_power")

})
dev.off()
