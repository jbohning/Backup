## Write a function called rankhospital that takes three arguments: 
## the 2-character abbreviated name of a state (state), an outcome (outcome), 
## and the ranking of a hospital in that state for that outcome (num).
## The function reads the outcome-of-care-measures.csv file and returns a 
## character vector with the name of the hospital that has the ranking specified
## by the num argument.

outcome<-read.csv("/Users/JessicaBohning/Documents/Data Science/Course 2- R Programming/Week 4 Assignment/data/outcome-of-care-measures.csv",
                  na.strings="Not Available",stringsAsFactors=FALSE)

rankhospital<-function(state_abbrev="MO", outcome_name="pneumonia", rank=5){
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
        
        ## Check that state and outcome are valid using "stop"
        if(state_abbrev %in% outcome$State==FALSE) stop("invalid state")
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        temp<-na.omit(outcome_data)
        hospitals=as.character(temp[,1])
        states=as.character(temp[,2])
        deaths=as.numeric(temp[,3])
        ##Note, you didn't have to do the above; you could have used "name()"
        ##and then called on them as temp$hospitals
        outcome_data2<-data.frame(hospitals, states, deaths)
        ordered_data<-outcome_data2[order(states,deaths,hospitals),]
        ordered_data_nostates<-subset(ordered_data,states==state_abbrev)
        
        if(rank=="best"){
                hosRow<-1
        }
        else if(rank=="worst"){
                hosRow<-length(ordered_data_nostates[,1])
        }
        else if(Mod(rank/rank)==1){
                hosRow<-rank
        }
        else{
                stop("invalid rank")
        }
                
        as.character(ordered_data_nostates[hosRow,1])
        
}