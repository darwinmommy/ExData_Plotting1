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


#Plot 2:
#Create a line chart for Global active power, start with x-axis blank and reformat ticks and labels
plot(mydata2$Global_active_power, type="o",
     pch=".", ylab="Global Active Power (kilowatts)",xaxt="n", xlab="")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"))
#Save the plot as a png file
dev.copy(png,"plot2.png")
dev.off()
