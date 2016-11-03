## Graph all sector exposures

#Directory:
filepath<-"S:\\Data\\Scout\\Risk Monitoring\\Projects\\2016\\161024 Internationals History\\R Codes and Data\\INTL country fund exposures 130331 to 160930.csv"

exposures<-read.csv(filepath,stringsAsFactors = FALSE, na.strings = "N/A")

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
                par(mfrow=c(2,3),mar=c(4,4,2,1))}
        JPlot(exposures$Dates,exposures[,i],paste(names(exposures[i]),"Fund Exposures"))
}
