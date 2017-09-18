if(!require(gmmase)){
    require(devtools)
    devtools::install_github("youngser/gmmase")
    library(gmmase)
}

dimselect.interface <- function(X)
{
    out <- getElbows(X)
}
