source("getElbows.R")

dimselect.interface <- function(input)
{
    cat("working with ", input, "\n")
    X <- scan(input)
    out <- getElbows(X)
    cat("The first three selected dimensions are = ", out, "\n")

    cat("The output file is saved in '../DATA/out.txt'.\n")
    write(out,"../DATA/out.txt", ncol=1)
}    
