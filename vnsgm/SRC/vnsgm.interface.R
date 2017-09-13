if(!require(VN)) {
    install.packages("http://www.cis.jhu.edu/~parky/D3M/VN_0.3.0.tar.gz",type="source")
    library(VN)
}
if(!require(igraph)) {
    install.packages("igraph")
    library(igraph)
}

vnsgm.interface <- function(input1, input2, s)
{
    X <- as.matrix(read.table(input1))
    if (ncol(X)==2) {
        g1 <- graph.edgelist(X)
    } else {
        g1 <- graph.adjacency(X)
    }
    X <- as.matrix(read.table(input2))
    if (ncol(X)==2) {
        g2 <- graph.edgelist(X)
    } else {
        g2 <- graph.adjacency(X)
    }

    W <- intersect(V(g1),V(g2)) # shared vertices
    x <- sample(W,1)
    W <- setdiff(W,x) # exclude x from W
    maxseed <- min(length(W),s)
    S <- sort(sample(W,maxseed))

    R <- 100
    gamma <- 1
    h <- ell <- 1
    out <- vnsgm(x,S,g1,g2,h,ell,R,gamma,sim=FALSE,plotF=FALSE)$P
    
    cat("The output file is saved in '../DATA/out.txt'.\n")
    write.table(out,"../DATA/out.txt", row.names=F, col.names=F)
}
