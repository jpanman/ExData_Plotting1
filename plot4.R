# Code for plot4.R
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

# Plot 4:

#specify number of rows and columns
par(mfrow=c(2,2), mar=c(4, 4, 2, 2))

# top left chart is new:
hh$Global_active_power<-as.numeric(as.character(hh$Global_active_power))
plot(hh$stamp,hh$Global_active_power,
     ylab = "Global Active Power",
     type = "l",
     xlab = NA)

# top right chart is a new chart:
hh$Voltage<-as.numeric(as.character(hh$Voltage))
plot(hh$stamp,hh$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     col = "black")

# bottom left chart is plot3.R:
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
       lty = c(1,1,1),
       bty = "n")

# bottom right chart is new:
hh$Global_reactive_power<-as.numeric(as.character(hh$Global_reactive_power))
plot(hh$stamp,hh$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactve_power",
     col = "black",
     type = "l")

# Create png file in directory

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
