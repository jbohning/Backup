## rankall takes two arguments: an outcome name (outcome) and a hospital
##rank- ing (num)

outcome<-read.csv("/Users/JessicaBohning/Documents/Data Science/R Programming Course/Week 4 Assignment/data/outcome-of-care-measures.csv",
                  na.strings="Not Available",stringsAsFactors=FALSE)

rankall<-function(outcome_name="heart attack", rank="best"){
        
        ## Read outcome data
        if(outcome_name=="heart attack"){
                outcome_data<-outcome[,c(2,7,11)]  
        }
        
        else if(outcome_name=="heart failure"){
                outcome_data<-outcome[,c(2,7,17)]
        }
        else if(outcome_name=="pneumonia"){
                outcome_data<-outcome[,c(2,7,23)]
        }
        else{stop("invalid outcome")}
        
        ## Check that outcome is valid using "stop"
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        temp<-na.omit(outcome_data)
        names(temp)<-c("hospitals","states","deaths")
        ordered_data<-temp[order(temp$states,temp$deaths,temp$hospitals),]
        Split_Data<-split(ordered_data,ordered_data$states)
        
        if(rank=="best"){
                sapplied_data<-sapply(Split_Data,function(elem)elem[1,])
                transposed_data<-t(sapplied_data)
                output<-transposed_data[,1:2]
                
        }
        else if(rank=="worst"){
                ordered_data<-temp[order(temp$states,temp$deaths,temp$hospitals,
                                         decreasing=TRUE),]
                Split_Data<-split(ordered_data,ordered_data$states)
                sapplied_data<-sapply(Split_Data,function(elem)elem[1,])
                transposed_data<-t(sapplied_data)
                output<-transposed_data[,1:2]
        }
        else if(Mod(rank/rank)==1){
                sapplied_data<-sapply(Split_Data,function(elem)elem[rank,])
                transposed_data<-t(sapplied_data)
                output<-transposed_data[,1:2]
        }
        else{
                stop("invalid rank")
        }
        output
}