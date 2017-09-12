if(!require(gmmase)){
    require(devtools)
    devtools::install_github("youngser/gmmase")
    library(gmmase)
}
if(!require(igraph)){
    install.packages("igraph")
    library(igraph)
}

ptr.interface <- function(input)
{
    X <- as.matrix(read.table(input))
    g <- ptr(X)
    out <- as.matrix(g[])

    cat("The output file, a new n x n adjacency matrix, is saved in '../DATA/out.txt'.\n")
    write.table(out,"../DATA/out.txt", row.names=FALSE, col.names=FALSE)
}
