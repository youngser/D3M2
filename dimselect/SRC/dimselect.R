source("/home/user/D3M/dimselect/SRC/getElbows.R")
args <- commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
    stop("At least one argument must be supplied (input file, a numeric vector.\n", call.=FALSE)
} else if (length(args)==1) {
    input <- args[1]
}

cat("working with ", input, "\n")
X <- scan(input)
out <- getElbows(X)
cat("The first three selected dimensions are = ", out, "\n")

cat("The output file is saved in './DATA/out.txt'.\n")
write(out,"/home/user/D3M/DATA/out.txt", ncol=1)
