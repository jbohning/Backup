#Regression Modeling using Galton's parent/child height data

#install.packages("UsingR")
library(UsingR)
library(reshape)
library(ggplot2)
data("galton")

#Data exploration on the two population's data
long<-melt(galton)
g<-ggplot(long,aes(x=value,fill=variable))
g<-g+geom_histogram(colour="black",binwidth = 1)
g<-g+facet_grid(.~variable)
g

#Finding the Center of Mass for the Data
library(manipulate)
myHist<-function(mu){
        mse<-mean((galton$child-mu)^2)
        g<-ggplot(galton,aes(x=child))+
                geom_histogram(fill="salmon",color="black",binwidth=1)+
                geom_vline(xintercept = mu,size=3)+
                ggtitle(paste("mu = ",mu, ", MSE=", round(mse,2), sep=""))
        g
}
manipulate(myHist(mu),mu=slider(62,74,step=0.5))

#Notice that at mu=8, the MSE (or mean square error) is the smallest


#Another exploratory graph (a very flawed graph)
ggplot(galton, aes(x=parent, y=child))+geom_point()

#A better example of the same plot (which changes the size of points depending
#on how many data points fall on that spot)
freqData <- as.data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")
plot(as.numeric(as.vector(freqData$parent)), 
     as.numeric(as.vector(freqData$child)),
     pch = 21, col = "black", bg = "lightblue",
     cex = .15 * freqData$freq, 
     xlab = "Parent Height (inches)", ylab = "Child Height (inches)")


#Finding a line of best fit (forces the line of best fit to go through the origin)
myPlot <- function(beta){
        y <- galton$child - mean(galton$child)
        x <- galton$parent - mean(galton$parent)
        freqData <- as.data.frame(table(x, y))
        names(freqData) <- c("child", "parent", "freq")
        plot(
                as.numeric(as.vector(freqData$parent)), 
                as.numeric(as.vector(freqData$child)),
                pch = 21, col = "black", bg = "lightblue",
                cex = .15 * freqData$freq, 
                xlab = "parent", 
                ylab = "child"
        )
        abline(0, beta, lwd = 3)
        points(0, 0, cex = 2, pch = 19)
        mse <- mean( (y - beta * x)^2 )
        title(paste("beta = ", beta, "mse = ", round(mse, 3)))
}
manipulate(myPlot(beta), beta = slider(0.6, 1.2, step = 0.02))

#How to find the actual slope line:
lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data = galton)
#output: slope is 0.6463


#Linear Least Squares Coding Example
x<-galton$parent        
y<-galton$child
beta1 <- cor(y, x) *  sd(x) / sd(y)
beta0 <- mean(x) - beta1 * mean(y)
rbind(c(beta0, beta1), coef(lm(x ~ y)))





















