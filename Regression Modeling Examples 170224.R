#Poisson Distribution
par(mfrow = c(1, 3))
plot(0 : 10, dpois(0 : 10, lambda = 2), type = "h", frame = FALSE)
plot(0 : 20, dpois(0 : 20, lambda = 10), type = "h", frame = FALSE)
plot(0 : 200, dpois(0 : 200, lambda = 100), type = "h", frame = FALSE) 

#Showing that the mean and variance are equal
x <- 0 : 10000; lambda = 3
mu <- sum(x * dpois(x, lambda = lambda))
sigmasq <- sum((x - mu)^2 * dpois(x, lambda = lambda))
c(mu, sigmasq)

#Website hit count modeling
setwd("S://Data//Scout//Bohning//Data Science")
download.file("https://dl.dropboxusercontent.com/u/7710864/data/gaData.rda",destfile="gaData.rda",method="curl")
load("gaData.rda")
gaData$julian <- julian(gaData$date)
head(gaData)
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
lm1 <- lm(gaData$visits ~ gaData$julian)
abline(lm1,col="red",lwd=3)
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
glm1 <- glm(gaData$visits ~ gaData$julian,family="poisson")
abline(lm1,col="red",lwd=3); lines(gaData$julian,glm1$fitted,col="blue",lwd=3)
plot(glm1$fitted,glm1$residuals,pch=19,col="grey",ylab="Residuals",xlab="Fitted")

#Model Agnostic Standard Errors
library(sandwich)
confint.agnostic <- function (object, parm, level = 0.95, ...)
{
        cf <- coef(object); pnames <- names(cf)
        if (missing(parm))
                parm <- pnames
        else if (is.numeric(parm))
                parm <- pnames[parm]
        a <- (1 - level)/2; a <- c(a, 1 - a)
        pct <- stats:::format.perc(a, 3)
        fac <- qnorm(a)
        ci <- array(NA, dim = c(length(parm), 2L), dimnames = list(parm,
                                                                   pct))
        ses <- sqrt(diag(sandwich::vcovHC(object)))[parm]
        ci[] <- cf[parm] + ses %o% fac
        ci
}


#Estimating Confidence Intervals
confint(glm1)
confint.agnostic(glm1)

#Fitting rates in R
glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),glm2$fitted,col="blue",pch=19,xlab="Date",ylab="Fitted Counts")
points(julian(gaData$date),glm1$fitted,col="red",pch=19)

glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),gaData$simplystats/(gaData$visits+1),col="grey",xlab="Date",
     ylab="Fitted Rates",pch=19)
lines(julian(gaData$date),glm2$fitted/(gaData$visits+1),col="blue",lwd=3)


#Simulated Example of sine. This is just stupid. 
n <- 500; x <- seq(0, 4 * pi, length = n); y <- sin(x) + rnorm(n, sd = .3)
knots <- seq(0, 8 * pi, length = 20); 
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
#My way of doing it:
fit2<-lm(y~I(sin(x)))
x2<-rnorm(1:1000,mean=6,sd=3)
y2<-fit2$coefficients[1]+fit2$coefficients[2]*sin(x2)
plot(x,y)
points(x2,y2)


#My own example of fitting polynomial data i.e. just add I() on any non "x" term
x<-rnorm(1:50,mean=0,sd=5)
y<-x^2+rnorm(1:50)


#Harmonics using linear models (like literally music note stuff)
#I have no clue what point this is trying to make... so... yeah...
notes4 <- c(261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25)
t <- seq(0, 2, by = .001); n <- length(t)
c4 <- sin(2 * pi * notes4[1] * t); e4 <- sin(2 * pi * notes4[3] * t); 
g4 <- sin(2 * pi * notes4[5] * t)
chord <- c4 + e4 + g4 + rnorm(n, 0, 0.3) #A c major chord
x <- sapply(notes4, function(freq) sin(2 * pi * freq * t))
fit <- lm(chord ~ x - 1)
plot(fit$coefficients,type="l",col="red",lwd=4)
#(How you would really do it)
a <- fft(chord); plot(Re(a)^2, type = "l")






plot(x,y)
lm(y~I(x^2)+x)