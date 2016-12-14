# Code for plot3.R
# The code assummes that the household power consumption
# file is unzipped and saved in the working directory.

library(dplyr)

# Set wd to appropriate folder
setwd("~/Documents/Coursera/GettingData/ExData_Plotting1")

household<-read.table("./household_power_consumption.txt",sep=';',header=TRUE)
hh<-household

# Adjust dates
hh$Date<-as.Date(hh$Date,"%d/%m/%Y")

# Filter two days necessary and combine
hh1<-filter(hh, Date =="2007-02-02")
hh2<-filter(hh,Date =="2007-02-01")
hh<-rbind(hh2,hh1)
rm(hh1)
rm(hh2)

#Create time 'stamp' value which combines dates and times
hh$stamp<-with(hh,paste(Date,Time))
hh$stamp<-strptime(hh$stamp,"%Y-%m-%d %H:%M:%S")

# Creates plot3.R

hh$Sub_metering_1<-as.numeric(hh$Sub_metering_1)
hh$Sub_metering_2<-as.numeric(as.character(hh$Sub_metering_2))

plot(hh$stamp,hh$Sub_metering_1,
     type = "l",
     col="black",
     ylab = "Energy sub metering",
     xlab = NA,
     main= NA)
lines(hh$stamp,hh$Sub_metering_2,     
      type = "l",
      col="red")
lines(hh$stamp,hh$Sub_metering_3,     
      type = "l",
      col="blue")

legtext<-c("Sub_metering_1","Sub_metering_3","Sub_metering_3")

legend("topright",
       legend=legtext,
       col=c("black","red","blue"),
       lty = c(1,1,1))

# Create png file in directory

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()