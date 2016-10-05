## Week 4 Assignment

## Get the two sets of data from the given files; Define Column Classes as
## Characters
hospital_data<-read.csv("/Users/JessicaBohning/Documents/Data Science/R Programming Course/Week 4 Assignment/data/hospital-data.csv",
                na.strings="Not Available",stringsAsFactors=FALSE)
outcome<-read.csv("/Users/JessicaBohning/Documents/Data Science/R Programming Course/Week 4 Assignment/data/outcome-of-care-measures.csv",
                na.strings="Not Available",stringsAsFactors=FALSE)



## Part 1: Plot the 30-day mortality rates for heart attack

outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])



## Part 2: Finding the best hospital in a state
## (Best based on death rate)

## Define a function called "best" that take two arguments: the 2-character 
## abbreviated name of a state and an outcome name.

## Hospitals that do not have data on a particular outcome should be excluded 
## from the set of hospitals when deciding the rankings.

## If there is a tie, then rankings should go alphbetically

best<-function(state_abbrev="MO",outcome_name="pneumonia"){
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
        
        ## Return hospital name in that state with lowest 30-day death rate
        ##use subset to just get the state: subset(outcome_data,state=entered state)
        
        temp<-na.omit(outcome_data)
        hospitals=as.character(temp[,1])
        states=as.character(temp[,2])
        deaths=as.numeric(temp[,3])
        outcome_data2<-data.frame(hospitals, states, deaths)
        ##outcome_data_nostates<-subset(temp,State==state_abbrev)
        ##ordered_data<-outcome_data_nostates[order(deaths),]
        ordered_data<-outcome_data2[order(states,deaths,hospitals),]
        ordered_data_nostates<-subset(ordered_data,states==state_abbrev)
        as.character(ordered_data_nostates[1,1])

}