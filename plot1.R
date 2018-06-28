#Downloading the data

filename<-"EPC.zip"
Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest<-"~/EPC Data"

if(!file.exists(filename)){
    download.file(Url,filename)
}
if(!file.exists("EPC Data")){
    unzip(filename,exdir = "EPC Data")
}

#Read file into R
mydata<-read.csv("EPC Data/household_power_consumption.txt",sep=";",stringsAsFactors = F)

#Change column classes, filter for only dates 2-1-2007 through 2-2-2007
library(lubridate)
mydata$Date<-dmy(mydata$Date)
library(dplyr)
mydata2<-filter(mydata, Date=="2007-02-01" | Date=="2007-02-02")
mydata2$Global_active_power<-as.numeric(mydata2$Global_active_power)
mydata2$Global_reactive_power<-as.numeric(mydata2$Global_reactive_power)
mydata2$Voltage<-as.numeric(mydata2$Voltage)
mydata2$Global_intensity<-as.numeric(mydata2$Global_intensity)
mydata2$Sub_metering_1<-as.numeric(mydata2$Sub_metering_1)
mydata2$Sub_metering_2<-as.numeric(mydata2$Sub_metering_2)
mydata2$Sub_metering_3<-as.numeric(mydata2$Sub_metering_3)


#Plot 1:
hist(mydata2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.copy(png,"plot1.png")
dev.off()
