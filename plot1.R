# Code for plot1.R
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

# Plot 1:

hh$Global_active_power<-as.numeric(as.character(hh$Global_active_power))
par(mfrow=c(1,1), mar = c(5.1, 4.1, 4.1, 2.1))

plot1<-hist(hh$Global_active_power,col="red",
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
plot1

# Create png
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()