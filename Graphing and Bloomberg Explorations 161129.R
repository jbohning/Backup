# Playing around with graphs

library(Rblpapi)
library(ggplot2)
library(RColorBrewer)
library(reshape)

#Open Bloomberg Connection:
blpConnect()

#Grab the last price for Mid Cap's top 10 positiongs (over T1Y)
MCTop10<-c("CFG US EQUITY","ATO US EQUITY","CSC US EQUITY","THO US EQUITY",
           "EPR US EQUITY","ABMD US EQUITY","NVDA US EQUITY","LAMR US EQUITY",
           "EW US EQUITY","SNH US EQUITY")

temp<-bdh(MCTop10[1], "PX_LAST", start.date=Sys.Date()-365)
stockprice<-data.frame(1:nrow(temp))

for (i in 1:length(MCTop10)){
        stockprice<-cbind(stockprice,
                          bdh(MCTop10[i], "PX_LAST", start.date=Sys.Date()-365))
}

stockprice<-stockprice[,-1]
stockprice<-stockprice[,-c(3,5,7,9,11,13,15,17,19)]
names_stockprice<-c("Dates",MCTop10)
names(stockprice)<-names_stockprice


#Simple, one ticker plotted
ggplot(stockprice,aes(x=Dates,y=stockprice$`CFG US EQUITY`))+geom_line()

#Plotting all at once_ BASIC
ggplot(stockprice,aes(x=Dates,y=value,color=variable)) +
        ylim(limits = range(stockprice[2:11]))+
        geom_line(aes(y=stockprice[2],col=MCTop10[1])) +
        geom_line(aes(y=stockprice[3],col=MCTop10[2])) +
        geom_line(aes(y=stockprice[4],col=MCTop10[3])) +
        geom_line(aes(y=stockprice[5],col=MCTop10[4])) +
        geom_line(aes(y=stockprice[6],col=MCTop10[5])) +
        geom_line(aes(y=stockprice[7],col=MCTop10[6])) +
        geom_line(aes(y=stockprice[8],col=MCTop10[7])) +
        geom_line(aes(y=stockprice[9],col=MCTop10[8])) +
        geom_line(aes(y=stockprice[10],col=MCTop10[9])) +
        geom_line(aes(y=stockprice[11],col=MCTop10[10]))

#Plotting all at once_FANCY
source("S://Data//Scout//Bohning//Data Science//RiskDiligence Color Pallete 161129.R")
ggplot(stockprice,aes(x=Dates,y=value,color=variable)) +
        scale_y_continuous(limits = range(stockprice[2:11]),breaks=seq(0,150,10))+
        scale_color_manual(values=USSLOW_ELEVEN_STYLES)+
        labs(y="Closing Price")+
        geom_line(aes(y=stockprice[2],col=MCTop10[1]),size=1.5) +
        geom_line(aes(y=stockprice[3],col=MCTop10[2]),size=1.5) +
        geom_line(aes(y=stockprice[4],col=MCTop10[3]),size=1.5) +
        geom_line(aes(y=stockprice[5],col=MCTop10[4]),size=1.5) +
        geom_line(aes(y=stockprice[6],col=MCTop10[5]),size=1.5) +
        geom_line(aes(y=stockprice[7],col=MCTop10[6]),size=1.5) +
        geom_line(aes(y=stockprice[8],col=MCTop10[7]),size=1.5) +
        geom_line(aes(y=stockprice[9],col=MCTop10[8]),size=1.5) +
        geom_line(aes(y=stockprice[10],col=MCTop10[9]),size=1.5) +
        geom_line(aes(y=stockprice[11],col=MCTop10[10]),size=1.5)

#Plotting: All lines at once
stockpricemelted<-melt(stockprice,id="Dates")
ggplot(stockpricemelted,aes(x=Dates,y=value,color=variable)) +
        scale_y_continuous(limits = range(stockpricemelted[3]),breaks=seq(0,150,10))+
        scale_color_manual(values=USSLOW_ELEVEN_STYLES)+
        labs(y="Closing Price")+geom_line(size=1.5)

#Same plot, different facets
ggplot(stockpricemelted,aes(x=Dates,y=value,color=variable)) +
        facet_wrap(~variable,ncol=3)+
        scale_y_continuous(limits = range(stockpricemelted[3]),breaks=seq(0,150,10))+
        scale_color_manual(values=USSLOW_ELEVEN_STYLES)+
        labs(y="Closing Price")+geom_line(size=1.5)




# NEW EXAMPLE (trying to do a lineup plot)
test20150101<-bds("INDU INDEX","INDX_MWEIGHT",overrides = c("START_DT"="20150101", "END_DT"="20150101"))
test20160101<-bds("INDU INDEX","INDX_MWEIGHT",overrides = c("START_DT"="20160101", "END_DT"="20160101"))
test20150101<-cbind(test20150101,"January 1, 2015")
test20160101<-cbind(test20160101,"January 1, 2016")
names(test20150101)<-c("Tickers","Weight","Date")
names(test20160101)<-c("Tickers","Weight","Date")
weights<-rbind(test20150101,test20160101)

ggplot(weights,aes(x=weights$Date,y=weights$Weight))+geom_point()
