#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def dimselect(datafn):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input data in TODO: YP format
    """
    print("working with: {}".format(datafn))

    get_elbows = robjects.r("""
    source("/home/user/D3M/dimselect/SRC/getElbows.R")
    fn <- function (input) {
        X <- scan(input)
        out <- getElbows(X)
        cat("The first three selected dimensions are = ", out, "\n")

        cat("The output file is saved in './DATA/out.txt'.\n")
        write(out,"/home/user/D3M/DATA/out.txt", ncol=1)
    }
    """)

    get_elbows(datafn)

def main():
    parser = argparse.ArgumentParser(description="Python dimselect wrapper")
    parser.add_argument("datafn", action="store", help="Text readable data" +\
            "newline separeated")
    args = parser.parse_args()

    dimselect(args.datafn)

if __name__ == "__main__":
    main()
