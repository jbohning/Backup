##Data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

SourceData<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
DestinationPath<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 1/IdahoHousing.csv"

download.file(url=SourceData,destfile=DestinationPath,method="curl")
rawdata<-read.csv(DestinationPath,stringsAsFactors=FALSE)

library("data.table")
library("dplyr")

## Load the data into a data frame table
DTHousing<-tbl_df(rawdata)

##Filter by values greater than $1,000,000 (Column name is VAL)
filter(DTHousing,VAL>=24)


##Question 3 data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
SourceDataNG<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
DestinationPathNG<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 1/NaturalGas.xlsx"

## Read rows 18-23 and columns 7-15 into R and assign the result to a variable called dat
download.file(url=SourceDataNG,destfile=DestinationPathNG,method="curl")

library("XLConnect")
library("xlsx")
dat<-read.xlsx(file=DestinationPathNG,sheetName=1,rowIndex=18:23,colIndex=7:15)

##Question 4 data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
SourceDataRestaurants<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
DestinationPathRestaurants<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 1/Baltimore Restaurants.xml"

download.file(url=SourceDataRestaurants,destfile=DestinationPathRestaurants,method="curl")

library("XML")
Restaurants<-xmlTreeParse(DestinationPathRestaurants,useInternalNodes = TRUE)
rootNode<-xmlRoot(Restaurants)
names(rootNode)
## Get the names of the values used
names(rootNode[[1]][[1]])

##Create a variable with all the zipcodes
ResZipcode<-xpathSApply(rootNode,"//zipcode",xmlValue)

class(ResZipcode)
##It is a character class so we need to convert
ResZipcode<-as.data.table(ResZipcode)
filter(ResZipcode,ResZipcode==21231)

##Option 2:
ResZipcode<-xpathSApply(rootNode,"//zipcode",xmlValue)
table(ResZipcode==21231)

##Question 5 data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
SourceDataCommunities<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DestinationPathCommunities<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 1/Communities.csv"

download.file(url=SourceDataCommunities,destfile=DestinationPathCommunities,method="curl")

DT<-fread(input<-DestinationPathCommunities)

a<-system.time(mean(DT$pwgtp15,by=DT$SEX))
b<-system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
c<-system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
d<-system.time(rowMeans(DT)[DT$SEX==1], rowMeans(DT)[DT$SEX==2])
e<-system.time(tapply(DT$pwgtp15,DT$SEX,mean))
f<-system.time(DT[,mean(pwgtp15),by=SEX])

a, c, and d all have user times of zero