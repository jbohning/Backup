complete<- function(directory,id=1:332){
        ## 'dicrectory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1 117
        ## 2 1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        files<-list.files(path=directory, full.names=TRUE)
        col2<-data.frame()
        len<-c(1:length(id))
        for(i in len){
                j<-id[i]
                tempDF<-data.frame(read.csv(files[j]))
                tempDF2<-na.omit(tempDF)
                col2[i,1]<- sum(complete.cases(tempDF[,2]))
                
        }
        ##col2
        ##nrow(finalDF)
        col1<-data.frame(id)
        output<-data.frame(col1,col2)
        colnames(output)<-c("id","nobs")
        
        output
}