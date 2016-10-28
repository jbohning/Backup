## A Function for my Plotting Parameters
JPlot<-function(x,y,graphname,space=2){

        plot(x, y, xlim=range(x,na.rm=TRUE), 
             ylim = c(min(y,na.rm=TRUE),(max(y,na.rm=TRUE)+space)),pch=".:", main=graphname,
             cex.main=.85, cex.sub=0.75, xlab="Dates", ylab="Cumulative Return (%)")
        
        lines(x, y,type="l")
        abline(v=as.Date("12/31/2014",format="%m/%d/%Y"),lty=5,col=132)
        abline(v=as.Date("3/31/2014",format="%m/%d/%Y"),lty=5,col=50)
        legend("topleft",pch=c("-","-"),col=c(50,132),
               legend=c("Stack becomes co-PM","Stack becomes sole PM"), cex=0.7,
               bg="white")

}

par(mfrow=c(2,3),mar=c(4,4,2,1))
dates<-INTLSectorsONLY$Date
JPlot(dates,INTLSectorsONLY[,2],names(INTLSectorsONLY[2]))
JPlot(dates,INTLSectorsONLY[,3],names(INTLSectorsONLY[3]))
JPlot(dates,INTLSectorsONLY[,4],names(INTLSectorsONLY[4]))
JPlot(dates,INTLSectorsONLY[,5],names(INTLSectorsONLY[5]))
JPlot(dates,INTLSectorsONLY[,6],names(INTLSectorsONLY[6]))
JPlot(dates,INTLSectorsONLY[,7],names(INTLSectorsONLY[7]))

par(mfrow=c(2,2),mar=c(4,4,2,1))
JPlot(dates,INTLSectorsONLY[,8],names(INTLSectorsONLY[8]))
JPlot(dates,INTLSectorsONLY[,9],names(INTLSectorsONLY[9]))
JPlot(dates,INTLSectorsONLY[,10],names(INTLSectorsONLY[10]))
JPlot(dates,INTLSectorsONLY[,11],names(INTLSectorsONLY[11]))