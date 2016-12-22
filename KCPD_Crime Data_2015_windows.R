#data location:
#https://data.kcmo.org/Crime/KCPD-Crime-Data-2015/kbzx-7ehe/data

library(maps)
library(plotrix)

#filepath<-"/Users/JessicaBohning/Documents/Data Science/Projects/KC Crime Data/KCPD_Crime_Data_2015.csv"

#crimedata2015<-read.csv(filepath,na.strings = "NA")
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


#omit nas
crimedata2015<-na.omit(crimedata2015)

#Separate data of victim and suspect
crimedata2015_sus<-crimedata2015[crimedata2015$Involvement=="SUS",]
crimedata2015_vic<-crimedata2015[crimedata2015$Involvement=="VIC",]

#Boxplots of Victim and Suspect by Ages
boxplot(crimedata2015_sus$Age,crimedata2015_vic$Age,outline=FALSE)

#Subsetting the location for DUIs

#How to get longitude and latitude
geocode("8319 NW 74th street, kansas city, MO 64152")
#OUTPUT: lon = -94.67809; lat=39.22883
subset(crimedata2015_sus,crimedata2015_sus$Description=="Driving Under Influe",select=c(Description,Location.1))


test_home<-get_map(location="8319 NW 74th street, kansas city, MO 64152")
lon=-94.67809
lat=39.22883
violent_crimes=17
test_home_map<-ggmap(test_home, base_layer = ggplot(aes(x=lon,y=lat),data=violent_crimes))

#Gettings a map:
ggmap(get_map(location="8319 NW 74th street, kansas city, MO 64152"))

DUI_ALL<-subset(crimedata2015_sus,
                crimedata2015_sus$Description=="Driving Under Influe",
                select=c(Description,Location.1))
#NOTE: Not all locations have the longitude and latitude

DUI_lat<-c(39.053635,39.110828,39.084583,39.175199,39.164735,39.069121,
           39.007141,38.987189,39.068644,39.007141,38.987189,39.084583,
           39.290892,39.007141,39.001683,39.216554,39.052416,39.252248,
           39.007141)
DUI_lon<-c(-94.595998,-94.578557,-94.575809,-94.493739,-94.527373,-94.585387,
           -94.559903,-94.557459,-94.570144,-94.559903,-94.557459,-94.575809,
           -94.473276,-94.559903,-94.557492,-94.493769,-94.597479,-94.655483,
           -94.559903)

#http://www.molecularecologist.com/2012/09/making-maps-with-r/
library(mapproj)        
map(database = "state",ylim=c(38,40),xlim=c(-94,-95),col="grey80",fill=TRUE,
    projection="gilbert")
coord<-mapproject(DUI_lon,DUI_lat,proj="gilbert")
points(coord,pch=20,cex=1.2,col="red")

library(RgoogleMaps)

terrmap<-GetMap(center = c(mean(DUI_lat),mean(DUI_lon)),zoom=10,
                maptype="roadmap",
                destfile = "C://Users//jxs056//Desktop//maptest.png")
#Note: a larger zoom will zoom in more

DUI_ALL<-data.frame(DUI_lon,DUI_lat)
DUI_ALL$size<-"small"
DUI_ALL$col<-"red"
DUI_ALL$char<-""
mymarkers<-cbind.data.frame(DUI_ALL$DUI_lat,DUI_ALL$DUI_lon,DUI_ALL$size,DUI_ALL$col,DUI_ALL$char)
names(mymarkers)<-c("lat","lon","size","col","char")
terrain_close<-GetMap.bbox(lonR = range(DUI_lon),latR = range(DUI_lat),
                           center=c(mean(DUI_lat),mean(DUI_lon)),
                           destfile = "C://Users//jxs056//Desktop//maptest.png",
                           markers=mymarkers,zoom=9,maptype="roadmap")








