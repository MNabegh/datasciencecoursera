best <- function(state, outcome) 
{
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
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
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
    ## Get the lowest death rate
    lowest_death_rate <- min(reduced_data_frame[,2], na.rm = T)
    ## Get the indices of hospitals with the lowest death rate
    indices_of_hospitals_with_lowest_death_rate <- 
        which(reduced_data_frame[,2] == lowest_death_rate)
    ## Get the names of the hospitals
    hospitals_with_lowest_rates <- reduced_data_frame[indices_of_hospitals_with_lowest_death_rate
                                                      , 1]
    sort(hospitals_with_lowest_rates)[1]
}