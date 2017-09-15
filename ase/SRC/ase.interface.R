if(!require(igraph)){
    install.packages("igraph")
    suppressMessages(require(igraph))
}

ase.interface <- function(g, dim)
{

    ## embedding into "dim"
    X <- embed_adjacency_matrix(g, dim)$X

<<<<<<< HEAD
    return(X)

    ## cat("The output files are saved in '../DATA/out_vectors.txt', '../DATA/in_vectors.txt', and '../DATA/eigenvalues'.\n")
    ## write.table(embed$X,"../DATA/out_vectors.txt", col.names=F, row.names=F)
    ## write.table(embed$Y,"../DATA/in_vectors.txt", col.names=F, row.names=F)
    ## write(embed$D,"../DATA/eigenvalues.txt", ncol=1)
=======
    return(embed)
>>>>>>> 1b71ad8f3654e88dc01899e5512c60931e610146
}
