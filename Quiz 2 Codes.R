## QUESTION 1
## Creating an API for Github to figure out the time that the
## instructor's repo was created

##install.packages("httpuv")
library(httpuv)
library(httr)
library(jsonlite)

## Find OAuth settings for github:
## http://developer.github.com/v3/oauth/

oauth_endpoints("github")

##My application is at: https://github.com/settings/applications/419577

myapp<-oauth_app("DataScienceCourse_Quiz2App",key="cc6fe2bc94d3510e3a5a",
                 secret="6528374b1cb51a180f437b9be05bc95eb7f16d8c")

## Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

## Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

##OR:
##req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
##stop_for_status(req)
##content(req)



## Trying to figure out all of the names of repos so I can figure out what time
## the datasharing repo was created (I have to know what number in the list it
## is)
Q1data<-content(req)
c<-data.frame()
for(i in 1:30){
        c[i,1]<-Q1data[[i]]$name
        }

## We find out that the datasharing repo is number 10

list(Q1data[[10]]$name,Q1data[[10]]$created_at)

## ANSWER: 2013-11-07T13:25:07Z"




## QUESTION 2
## The sqldf package allows for execution of SQL commands on R data frames. 
## We will use the sqldf package to practice the queries we might send with the
## dbSendQuery command in RMySQL.
## Download the American Community Survey data and load it into an R object
## called "acs"
## Which of the following commands will select only the data for the probability
## weights pwgtp1 with ages less than 50?


## install.packages("sqldf")
library("sqldf")


## data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

dataURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DestinationPath<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 2/AmericanCommunitySurvey.csv"

download.file(url=dataURL,destfile=DestinationPath,method="curl")

acs<-read.csv(DestinationPath,stringsAsFactors=FALSE)

## WRONG: sqldf("select * from acs where AGEP < 50")
## Selects other weights than pwgtp1
## ?? sqldf("select pwgtp1 from acs")
## Selects only pwgtp1, but I don't think it is also ages less than 50
## WRONG: sqldf("select * from acs")
## Selects more than just pwgtp1
## CORRECT: sqldf("select pwgtp1 from acs where AGEP < 50")





## QUESTION 3:
## Using the same data frame you created in the previous problem, what is the
## equivalent function to unique(acs$AGEP)

answer<-unique(acs$AGEP)
a<-sqldf("select distinct pwgtp1 from acs")
b<-sqldf("select AGEP where unique from acs")
## ERROR: Error in sqliteSendQuery(con, statement, bind.data) : error in statement: near "unique": syntax error
c<-sqldf("select distinct AGEP from acs")
d<-sqldf("select unique AGEP from acs")
## ERROR: Error in sqliteSendQuery(con, statement, bind.data) : error in statement: near "unique": syntax error

answer==a
##outputs are falses
answer==c
##outputs are trues




##QUESTION 4
## How many characters are in the 10th, 20th, 30th and 100th lines of HTML from
## this page: http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)

library("httr")

## Open a Connection to website
connection<-url("http://biostat.jhsph.edu/~jleek/contact.html")

## Read lines and save them
htmlcodeQ4<-readLines(connection)

## Close connection
close(connection)

nchar(htmlcodeQ4[10])
##[1] 45
nchar(htmlcodeQ4[20])
##[1] 31
nchar(htmlcodeQ4[30])
##[1] 7
nchar(htmlcodeQ4[100])
##[1] 25



## QUESTION 5
## Read this data set into R and report the sum of the numbers in the fourth of
## the nine columns.
## https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
## Original source of the data:
## http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
## (Hint this is a fixed width file format)

dataURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
DestinationPath<-"/Users/JessicaBohning/Documents/Data Science/Course 3- Getting and Cleaning Data/Week 2/Quiz4Question5Data.for"

download.file(url=dataURL,destfile=DestinationPath,method="curl")

Q2Q5data<-read.fwf(DestinationPath,stringsAsFactors=FALSE,
                   widths=c(14,5,9,4,9,4,9,5,5),skip=4)
##FYI, figuring out the widths of the columns in the file was a BUTT. I used
## readLines(DestinationPath,10) to get an idea of what the first ten lines were
## and then I copied and pasted the columns into nchar() to get an idea of the
## number of characters in each column (ex: nchar("03JAN1990     "))
## That even sucked, so I just played around with the widths until things looked
## right :-/

## Also, if you want to get an idea of the first ten lines of what is in the
## file type: readLines(DestinationPath,10)

names(Q2Q5data)
sum(Q2Q5data$V4)

## Output: 32426.7







