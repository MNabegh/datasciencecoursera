rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    outcome_of_care_measures_data_frame <- 
        read.csv("outcome-of-care-measures.csv",
                 na.strings = "Not Available", stringsAsFactors = FALSE)
    ## Check that state and outcome are valid
    ## List valid states and outcomes
    valid_states <- unique(outcome_of_care_measures_data_frame$State)
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check state input validty
    if(is.null(state) || !is.element(state, valid_states))
    {
        stop("invalid state")
    }
    
    ## Check outcome input validty
    if(is.null(outcome) || !is.element(outcome, valid_outcomes))
    {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    ## Set the proper index of death rate in the data frame according to the outcome variable
    if(outcome == "heart attack")
        death_rate_index <- 11
    else if(outcome == "heart failure")
        death_rate_index <- 17
    else 
        death_rate_index <- 23
    
    ## Reduce data frame to relevant data only
    reduced_data_frame <- outcome_of_care_measures_data_frame[
        which(outcome_of_care_measures_data_frame$State == state), c(2, death_rate_index)]
    
    reduced_data_frame <- na.omit(reduced_data_frame)
    
    ## Set desired hospital rank
    if(is.character(num))
    {
        if(num == "best")
            hospital_rank <- 1
        else
            hospital_rank <- nrow(reduced_data_frame)
    }
    else
        hospital_rank <- num
    
    ## Check that hospital rank is within valid range
    if(hospital_rank > nrow(reduced_data_frame))
        return(NA)
    
    ## Order hospitals
    reduced_data_frame <- reduced_data_frame[order(reduced_data_frame[,2],
                                                   reduced_data_frame$Hospital.Name),]
    reduced_data_frame[hospital_rank, 1]
}