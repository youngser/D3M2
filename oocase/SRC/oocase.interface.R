source("fm.spectral.embedding.R")

oocase.interface <- function(input, dmax=2) {
    fg <- fg.load.graph(input, directed=FALSE)
    fg

    cc <- fg.clusters(fg, mode="weak")
    tcc <- fm.table(cc)
    max.idx <- which(as.vector(tcc@Freq == max(tcc@Freq)))
    lccV <- which(as.vector(cc == tcc@val[max.idx]))

    lcc <- fg.fetch.subgraph(fg, vertices=lccV, compress=TRUE)
    lcc

    m <- fg.get.sparse.matrix(lcc)
    res <- fm.spectral.embedding(m, dmax, which="Aug", tol=1e-8)
    res$values

    cat("The output files are saved in 'DATA/out_vectors.txt' and 'DATA/out_values.txt'.\n")
    write.table(as.matrix(res$vectors),"/home/user/D3M/DATA/out_vectors.txt", col.names=F, row.names=F)
    write(as.vector(res$values),"/home/user/D3M/DATA/eigenvalues.txt", ncol=1)
}

