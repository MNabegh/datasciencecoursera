pollutantmean <- function(directory, pollutant, id=1:332)
{
    files_full <- list.files(directory, full.names = T)
    tmp <- vector(mode = "list", length = length(id))
    for (i in id)
    {
        tmp[[i]] = read.csv(files_full[[i]])
    }
    
    data <- do.call(rbind, tmp)
    mean(data[,pollutant], na.rm = T)
}