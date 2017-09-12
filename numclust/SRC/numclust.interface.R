numclust.interface <- function(input)
{
    X <- scan(input)
    out <- which.max(X)

    cat("The output file is saved in '../DATA/out.txt'.\n")
    write(out,"../DATA/out.txt", ncol=1)
}
