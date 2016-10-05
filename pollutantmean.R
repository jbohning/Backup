pollutantmean<-function(directory, pollutant="sulfate", id=1:332){
        ## 'directory' is a character vector of length 1 indicating the 
        ## location of the CSV file
        
        ## 'pollutant' is a cahracter vector of length 1 indicating the name
        ## of the pollutant for whcih we will calculate the mean;
        ## either "sulfate" or "nitrate"
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Does not round the result!
        
        ## The directory that I am using is:
        ## "/Users/JessicaBohning/Documents/Data Science/R Programming Course/Week 2 Assignment/specdata/specdata/001.csv"
        
        ##rbind()
        
        ##filenames<-list.files(path=directory)
        ##for (i in 1:length(filenames)) assign(filenames[i], read.csv(filenames[i]))
        
        files<-list.files(path=directory, full.names=TRUE)
        finalDF<-data.frame()
        for(i in id){
                tempDF<-data.frame(read.csv(files[i]))
                finalDF<-rbind(finalDF,tempDF)
               
        }
        ## nrow(finalDF)
        
        if(pollutant== "sulfate"){
                output<-colMeans(finalDF[2],na.rm=TRUE)}
        if(pollutant=="nitrate"){
                output<-colMeans(finalDF[3],na.rm=TRUE)
        }
        
        output        
}