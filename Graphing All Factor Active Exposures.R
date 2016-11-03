## Graph all sector exposures

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
filepath<-"S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\All Active Exposures 130331 to 160930.csv"

exposures<-read.csv(filepath,stringsAsFactors = FALSE, na.strings = "N/A")

if(names(exposures)[1]!="Dates"){
        stop("first column has incorrect variable name")
}

exposures$Dates<-as.Date(exposures$Dates,format="%Y/%m/%d")
nodatestemp<-exposures[,2:(ncol(exposures))]

exposures<-data.frame(exposures$Dates,lapply(nodatestemp,
                                             FUN=function(x) as.numeric(gsub("%","",x))))

names(exposures)<-c("Dates",names(nodatestemp))

#Creates the vector for the if loop that determines if a new par command should
#happen
parcheck<-data.frame()
for (i in c(1:ncol(exposures))){
        parcheck[i,1]<-6*i-4
}


for (i in c(2:ncol(exposures))){
        if(i==parcheck){
                pdf(paper="USr",width=10,
                    file="S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\PDFs from R Code\\Active Exposures 5.pdf")
                par(mfrow=c(2,3),mar=c(4,4,2,1))
        }
        
        JPlot(exposures$Dates,exposures[,i],names(exposures[i]),space=0.5)
        
}
dev.off()