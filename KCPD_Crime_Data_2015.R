library(maps)
#data location:
#https://data.kcmo.org/Crime/KCPD-Crime-Data-2015/kbzx-7ehe/data

filepath<-"/Users/JessicaBohning/Documents/Data Science/Projects/KC Crime Data/KCPD_Crime_Data_2015.csv"

crimedata2015<-read.csv(filepath,na.strings = "NA")
backupdata<-crimedata2015

#Combine reported date and time into on POSIXct column
datetimepaste<-paste(crimedata2015$Reported_Date,crimedata2015$Reported.Time)
datetimepaste<-gsub("12:00:00 AM ","",datetimepaste)
crimedata2015$Reported_DateTime<-as.POSIXct(datetimepaste,format="%m/%d/%Y %H:%M")

#Set the rest of the column classes
crimedata2015$Report_No<-as.numeric(as.character(crimedata2015$Report_No))
crimedata2015$Offense<-as.numeric(as.character(crimedata2015$Offense))
#crimedata2015$IBRS<-as.character(crimedata2015$IBRS)
#crimedata2015$Description<-as.character(crimedata2015$Description)
#crimedata2015$Address<-as.character(crimedata2015$Address)
#crimedata2015$City<-as.character(crimedata2015$City)
crimedata2015$Zip.Code<-as.numeric(as.character(crimedata2015$Zip.Code))
#crimedata2015$Rep_Dist<-as.character(crimedata2015$Rep_Dist)
#crimedata2015$Involvement<-as.character(crimedata2015$Involvement)
#crimedata2015$Race<-as.character(crimedata2015$Race)
#crimedata2015$Sex<-as.character(crimedata2015$Sex)
crimedata2015$Age<-as.numeric(as.character(crimedata2015$Age))
#crimedata2015$Location.1<-as.character(crimedata2015$Location.1)
#crimedata2015$Firearm.Used.Flag<-as.character(crimedata2015$Firearm.Used.Flag)

#Keep only relevant data
crimedata2015<-crimedata2015[,c(25,1,8:10,12:14,19:24)]


#Plotting by gender
barplot(prop.table(table(crimedata2015$Sex)))
#OR
barpot(table(crimedata2015$Sex))



