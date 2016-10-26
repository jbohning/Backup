#Basics for R

#Install Swirl and run it

#install.packages("swirl")
library(swirl)
#install_from_swirl("R Programming")
#install_from_swirl("Getting and Cleaning Data")
#install_from_swirl("Exploratory Data Analysis")


#Import Data
variable<-read.csv("/Users/JessicaBohning/Documents/Data Science/example.csv",
         na.strings="Not Available",stringsAsFactors=FALSE)


## Clear all variables
rm(list=ls())


##Error Help
##When I create a data frame like this:
x<-rnorm(10)
y<-rnorm(10)
z<-sample(LETTERS,10)
zyx<-data.frame(z,y,x)

##Why does it output more than just the first row, first column when I type
##the following (does this for any value in row 1)

zyx[1,1]

##