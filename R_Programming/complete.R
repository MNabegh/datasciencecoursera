complete <- function(directory, id = 1:332)
{
    files_full <- list.files(directory, full.names = T)
    tmp <- vector(length = length(id))
    for (i in 1:length(id))
    {
        file_data <- read.csv(files_full[[id[i]]])
        tmp[i] = sum(complete.cases(file_data))
    }
    data.frame(id = id, nobs = tmp) 
}