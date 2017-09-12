if(!require(mclust)){
    install.packages("mclust")
    library(mclust)
}

gclust.interface <- function(input, K=2) {
    X <- as.matrix(read.table(input))
    Khat <- Mclust(X, 1:K)$G
    cat("The optimal number of cluster is ", Khat, "\n")

    cat("The output file is saved in '../DATA/out.txt'.\n")
    write(Khat,"../DATA/out.txt", ncol=1)
}
