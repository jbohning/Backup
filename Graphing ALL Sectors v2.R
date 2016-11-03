JPlot<-function(x,y,graphname,space=2){
        
        plot(x, y, xlim=range(x,na.rm=TRUE), 
             ylim = c(min(y,na.rm=TRUE),(max(y,na.rm=TRUE)+space)),pch=".:", 
             main=graphname,cex.main=.85, cex.sub=0.75, xlab="Dates", 
             ylab="Active Exposure (%)",type='l')
        
        abline(v=as.Date("12/31/2014",format="%m/%d/%Y"),lty=5,col=132)
        abline(v=as.Date("3/31/2014",format="%m/%d/%Y"),lty=5,col=50)
        legend("topleft",pch=c("-","-"),col=c(50,132),
               legend=c("Stack becomes co-PM","Stack becomes sole PM"), cex=0.7,
               bg="white")
        
}

#Directory:
filepath<-"S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\INTL Industry Bets_FUND ONLY_160927.csv"
filepathsector<-"S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\GEMLT Sector Mapping.csv"


INTL_ind_fund<-read.csv(filepath,skip=1,stringsAsFactors = FALSE)
sectormap<-read.csv(filepathsector,stringsAsFactors = FALSE)

INTL_ind_fund$Date<-as.Date(INTL_ind_fund$Date,format="%m/%d/%Y")
sectors<-c((unique(sectormap[,1])))

INTLSectorsONLY<-INTL_ind_fund[,sectors]
INTLSectorsONLY<-data.frame(INTL_ind_fund$Date,lapply(INTLSectorsONLY,
                                                      FUN=function(x) as.numeric(gsub("%","",x))))

names(INTLSectorsONLY)<-c("Date",sectors)

#Creates the vector for the if loop that determines if a new par command should
#happen
parcheck<-data.frame()
for (i in c(1:ncol(INTLSectorsONLY))){
        parcheck[i,1]<-6*i-4
}

for (i in c(2:ncol(INTLSectorsONLY))){
        if(i==parcheck){
                pdf(paper="USr",width=10,
                    file="S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\PDFs from R Code\\Sector Exposures 5.pdf")
                par(mfrow=c(2,3),mar=c(4,4,2,1))
        }
        
        JPlot(INTLSectorsONLY$Date,INTLSectorsONLY[,i],names(INTLSectorsONLY[i]),space=0.5)
        
}
dev.off()


