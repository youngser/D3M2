if(!require(gmmase)){
    require(devtools)
    devtools::install_github("youngser/gmmase")
    library(gmmase)
}
if(!require(igraph)){
    install.packages("igraph")
    library(igraph)
}

sgc.interface <- function(input)
{
    X <- as.matrix(read.table(input))
    if (ncol(X)==2) {
        g <- graph.edgelist(X)
    } else {
        g <- graph.adjacency(X)
    }
    
    Yhat <- gmmase(g)$Y

    cat("The output file, a vector of clustering labels, is saved in '../DATA/out.txt'.\n")
    write(Yhat,"../DATA/out.txt", ncol=1)
}
