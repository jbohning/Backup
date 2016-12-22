#Tables
source("Chest Pain Avgs.R")
source("Heart Failures.R")

library(tables)

#Find the counties where you pay the most for Heart Failure
hfnaomit<-na.omit(heartfailure_countyAVGS)
hfunique<-data.frame(unique(hfnaomit$subregion))
names(hfunique)<-"subregion"
hfunique<-join(hfunique,hfnaomit,by="subregion",type="left",match="first")
hfsort<-hfunique[order(-hfunique$Covered.Charges.mean),]

#Find the counties where you pay the most for Chest Pain
cpnaomit<-na.omit(chestpain_countyAVGS)
cpunique<-data.frame(unique(cpnaomit$subregion))
names(cpunique)<-"subregion"
cpunique<-join(cpunique,cpnaomit,by="subregion",type="left",match="first")
cpsort<-cpunique[order(-cpunique$Covered.Charges.mean),]

#MAKING A TABLE OF THE 10 MOST EXPENSIVE COUNTIES
#Skipping for later
hftop10<-hfsort[1:10,]
hfbottom10<-tail(hfsort,10)

#Graphs:
hfgraphdata<-na.omit(heartfailuredata)
ggplot(hfgraphdata,aes(factor(State),Total.Discharges))+
        geom_bar(stat="identity")+
        theme(axis.text.x=element_text(vjust=0,size=12,angle=90))+
        labs(x=NULL)+ labs(y=NULL)+
        labs(title="Total Heart Failure Patients (Discharged)")+
        geom_hline(yintercept=(sum(heartfailuredata$Total.Discharges)/length(unique(heartfailuredata$State))),
                     col="brown1")