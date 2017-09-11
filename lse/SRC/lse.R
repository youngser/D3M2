args <- commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
    stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args)==1) {
    ## default embedding dimension
    input <- args[1]
    dim <- 2
} else {
    input <- args[1]
    dim <- args[2]
}

cat("working with ", input, ", embedding into ", dim, "dimension (2 is default).\n")

X <- as.matrix(read.table(input))
#dim(X)
if (nrow(X) == ncol(X)) {
    # pass to rank
    tmp <- X[X!=0]
    nnz <- length(tmp)
    rk <- rank(tmp) / nnz
    X[X!=0] <- rk * 2 / nnz

    # form igraph object: directed, weighted, hollow 
    suppressMessages(require(igraph))
    g <- graph_from_adjacency_matrix(X,weighted=TRUE,mode="directed",diag=FALSE)
} else {
    stop("The input matrix must be a square matrix!")
}

#summary(g)

# embedding into "dim"
embed <- embed_laplacian_matrix(g, dim)

cat("The output files are saved in 'DATA/out_vectors.txt', 'DATA/in_vectors.txt', and 'DATA/eigenvalues'.\n")
#write.table(embed$X,"../DATA/out_vectors.txt", col.names=F, row.names=F)
#write.table(embed$Y,"..//DATA/in_vectors.txt", col.names=F, row.names=F)
#write(embed$D,"..//DATA/eigenvalues.txt", ncol=1)
write.table(embed$X,"~/D3M/DATA/out_vectors.txt", col.names=F, row.names=F)
write.table(embed$Y,"~/D3M/DATA/in_vectors.txt", col.names=F, row.names=F)
write(embed$D,"~/D3M/DATA/eigenvalues.txt", ncol=1)
