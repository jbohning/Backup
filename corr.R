corr<-function(directory,threshold=0){
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        
        files<-list.files(path=directory, full.names=TRUE)
        col2<-data.frame()
        corcol<-data.frame()
        output<-data.frame()
        k<-1
        
        for(i in 1:332){
                tempDF<-data.frame(read.csv(files[i]))
                col2[i,1]<- sum(complete.cases(tempDF[,2]))
                tempDF2<-na.omit(tempDF)
                sulfates=tempDF2[,2]
                nitrates=tempDF2[,3]
                corcol[i,1]<-cor(sulfates,nitrates)
                if(sum(complete.cases(tempDF[,2]))>threshold){
                        output[k,1]<-corcol[i,1]
                        k<-k+1
                }
                
        }
         
        output
}