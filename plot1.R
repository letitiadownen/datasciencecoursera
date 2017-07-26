## input zip data to R 

zipurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"## input zip data to R 


##unzip files
library(data.table)
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

png(file="./course4_proj1/plot1.png",width = 480,height = 480)
hist(desdata$global_active_power,col ="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")
dev.off()
