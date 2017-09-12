if(!require(gmmase)){
    require(devtools)
    devtools::install_github("youngser/gmmase")
    library(gmmase)
}

nonpar.interface <- function(input1, input2, sigma=0.5)
{
    Xhat1 <- as.matrix(read.table(input1))
    Xhat2 <- as.matrix(read.table(input2))

    out <- nonpar(Xhat1,Xhat2,sigma)

    cat("The output file is saved in '../DATA/out.txt'.\n")
    write(out,"../DATA/out.txt", ncol=1)
}
