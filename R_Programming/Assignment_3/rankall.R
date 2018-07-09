rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcome_of_care_measures_data_frame <- 
        read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    ## List valid outcomes
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check outcome input validty
    if(is.null(outcome) || !is.element(outcome, valid_outcomes))
    {
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank
    hospitals <- sapply(unique(outcome_of_care_measures_data_frame$State), rankhospital, outcome, num)
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    data_frame <- data.frame(hospital = hospitals, state = unique(outcome_of_care_measures_data_frame$State))
    data_frame[order(data_frame$state),]
}