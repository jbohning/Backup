# The U.S. Environmental Protection Agency (EPA) sets national ambient air
# quality standards for outdoor air pollution

# U.S. National Ambient Air Quality Standards
# For fine particle pollution (PM2.5), the "annual mean, averaged over 3 years"
# cannot exceed $12~\mu g/m^3$.

# Data on daily PM2.5 are available from the U.S. EPA web site

# Question: Are there any counties in the U.S. that exceed that national standard
# for fine particle pollution?

pollution<- read.csv("/Users/JessicaBohning/Documents/Data Science/Course 4- Exploratory Data Analysis/Week 1/avgpm25.csv",
                     colClasses=c("numeric","character","factor","numeric","numeric"))

#Make a boxplot of particle pollutions
boxplot(pollution$pm25,col="blue")

#Make a histogram
hist(pollution$pm25,col="green")
rug(pollution$pm25)
#Note: the rug adds a little set of lines at the bottom to show where all of the
#data is

#Can change the bar widths on histogram:
hist(pollution$pm25,col="green", breaks=100)
rug(pollution$pm25)

# Can add a line to the boxplot to show where the national average is
boxplot(pollution$pm25,col="blue")
abline(h=12)
# This makes it clear that over 75% of the data is below the 12 max

#Can add lines on histograms too (added a line for the 12 standard and a line
#for the median of the data)
hist(pollution$pm25,col="green")
abline(v=12,lwd=2)
abline(v=median(pollution$pm25),col="magenta",lwd=4)

#Barplots: plotting the number of counties in each region
barplot(table(pollution$region),col="wheat",
        main="Number of Countries in Each Region")

#Multiple Boxplots
boxplot(pm25~region,data=pollution,col="red")

#Multiple Historgrams
par(mfrow=c(2,1),mar=c(4,4,2,1))
hist(subset(pollution,region=="east")$pm25,col="green")
hist(subset(pollution,region=="west")$pm25,col="green")

#Scatterplot
with(pollution,plot(latitude,pm25))
abline(h=12,lwd=2,lty=2)

#Add color
with(pollution,plot(latitude,pm25,col=region))
abline(h=12,lwd=2,lty=2)

#Multiple Scatterplots
par(mfrow=c(1,2),mar=c(5,4,2,1))
with(subset(pollution,region=="west"),plot(latitude,pm25,main="West"))
with(subset(pollution,region=="east"),plot(latitude,pm25,main="East"))

#Lattice Plot
library(lattice)
state<-data.frame(state.x77,region=state.region)
xyplot(Life.Exp~Income | region, data=state,layout=c(4,1))

# Using GGPlot2
library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)

# Second boxplot example
library(datasets)
airquality<- transform(airquality, Month=factor(Month))
boxplot(Ozone~Month, airquality,xlab="month",ylab="Ozone (ppb)")

#Base Plot with Annotation
library(datasets)
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))

#Base Plot with Annotation
library(datasets)
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", 
                      type="n"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright",pch=1, col=c("blue","red"),legend=c("May","Other Months"))

#Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", 
                      pch=20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)

# Multiple Base Plots
par(mfrow=c(1,2))
with (airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R,Ozone, main = "Ozone and Solar Radiation")
})

#Multiple Base Plots with overarching title
par(mfrow=c(1,3), mar=c(4,4,2,1), oma=c(0, 0, 2, 0))
with(airquality,{
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R,Ozone, main = "Ozone and Solar Radiation")
        plot(Temp,Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Weather in New York City", outer=TRUE)
})


#To pull up the plot symbol code list, or see plotting demos
example(points)


 












