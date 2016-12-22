#Happy Numbers


for (i in 1:10){
        j<-as.character(i)
        ivector<-NULL
        for(k in 1:20){
                ichar<-as.character(j)
                ivector<-as.numeric(unlist(strsplit(ichar,"")))
                j<-sum(ivector^2)
                if(j==1){
                        print(paste(i," is a happy number"))
                        break
                }
                k<-k+1
                
        }
        if(j!=1){
        print(paste(i," is NOT a happy number"))
        }
}

happynumbers<-data.frame(NULL)
nothappies<-data.frame(NULL)
for (i in 1:10){
        j<-as.character(i)
        ivector<-NULL
        for(k in 1:20){
                ichar<-as.character(j)
                ivector<-as.numeric(unlist(strsplit(ichar,"")))
                j<-sum(ivector^2)
                if(j==1){
                        happynumbers<-rbind(happynumbers,i)
                        break
                }
                k<-k+1
                
        }
        if(j!=1){
                nothappies<-rbind(nothappies,i)
        }
}
happynumbers
a<-cbind(happynumbers,"happy")
names(a)<-c("number","state")
b<-cbind(nothappies,"un-happy")
names(b)<-c("number","state")
allnumbers<-rbind(a,b)


#Graph Option: ggplot(happynumbers,aes(x=1:length(happynumbers$X1L),y=happynumbers$X1L))+geom_point()
#Option2:
ggplot(allnumbers,aes(x=1:nrow(allnumbers),y=allnumbers$number,
                      color=allnumbers$state))+
        geom_point()




