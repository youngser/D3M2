source("nonpar.interface.R")

args <- commandArgs(trailingOnly=TRUE)
if (length(args)<2) {
    stop("At least two argument must be supplied (input_file1 & input_file2, numeric matrices, and an optional sigma with 0.5 as default.\n", call.=FALSE)
} else if (length(args)==2) {
    input1 <- args[1]
    input2 <- args[2]
    sigma <- 0.5
} else if (length(args)==3) {
    input1 <- args[1]
    input2 <- args[2]
    sigma <- args[3]
}

cat("working with ", input1, " and ", input2, "\n")

nonpar.interface(input1, input2, sigma)
