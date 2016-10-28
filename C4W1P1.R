# Course 4 Week 1 Project
# data: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# INSERT CODE HERE
# Quick check on if my computer can handle this


# Load the data into the variable called "powerdata" and skip the header row
filepath<-"C:\\Users\\jxs056\\Desktop\\exdata%2Fdata%2Fhousehold_power_consumption\\household_power_consumption.txt"
powerdata<-read.table(filepath,sep=";",skip=1)

# Set the names of "powerdata"
names(powerdata)<-c("Date","Time","Global_active_power","Global_reactive_power",
                    "Volatage","Global_intensity","Sub_metering_1",
                    "Sub_metering_2","Sub_metering_3")

# Set the class of date column (only date column before subsetting)
powerdata$Date<-as.POSIXct(powerdata$Date,format="%d/%m/%Y")

#Subset "powerdata" to only the dates required for the analysis
powerdata<-subset(powerdata,
                         Date == as.POSIXct("2007/02/01",format="%Y/%m/%d")|
                                 Date==as.POSIXct("2007/02/02",format="%Y/%m/%d"))

# Set the class of the rest of the columns
powerdata$Time <- as.POSIXct(powerdata$Time,format="%H:%M:%S")
powerdata$Global_active_power<- as.numeric(as.character(powerdata$Global_active_power))
powerdata$Global_reactive_power<-as.numeric(as.character(powerdata$Global_reactive_power))
powerdata$Volatage<-as.numeric(as.character(powerdata$Volatage))
powerdata$Global_intensity<-as.numeric(as.character(powerdata$Global_intensity))
powerdata$Sub_metering_1<-as.numeric(as.character(powerdata$Sub_metering_1))
powerdata$Sub_metering_2<-as.numeric(as.character(powerdata$Sub_metering_2))
powerdata$Sub_metering_3<-as.numeric(as.character(powerdata$Sub_metering_3))

#Create Date_Time Column

library(dplyr)
powerdata<-mutate(powerdata,powerdata$Date_Time=powerdata$Date+powerdata$Time)
        
# INSERT SEPARATE CODE FILE HERE

#Plot 1

#Tell R how to save the plot
png("C:\\Users\\jxs056\\Desktop\\Plot 1.png",width=480,height=480)

#Create the actual plot
hist(powerdata$Global_active_power,col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", main="Global Active Power")

#Close ong
dev.off()










