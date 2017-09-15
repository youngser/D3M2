if(!require(igraph)){
    install.packages("igraph")
    suppressMessages(require(igraph))
}

ase.interface <- function(g, dim)
{

    ## embedding into "dim"
    embed <- embed_adjacency_matrix(g, dim)

    return(embed)
}
