corr <- function(directory, threshold = 0)
{
    files_full <- list.files(directory, full.names = T)
    complete_cases <- complete(directory)
    ids <- complete_cases[which(threshold < complete_cases[,"nobs"]),]
    tmp <- vector(length = dim(ids)[1])
    
    if(length(tmp) != 0)
    {
        for (i in seq(dim(ids)[1]))
        {
            file_data <- read.csv(files_full[ids[i,"id"]])
            file_data <- file_data[complete.cases(file_data),]
            tmp[i] = cor(file_data[,"sulfate"], file_data[,"nitrate"])
        }
    }
    
    tmp 
}