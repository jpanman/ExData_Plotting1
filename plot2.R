# Code for plot2.R
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

# Creates plot2.R

plot(hh$stamp, hh$Global_active_power,
     type = "l",  #line type
     col="black", # black line
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     main= NA )

# Create png file in directory

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()