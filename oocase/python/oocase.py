#!/usr/bin/env python

# oocase.py
# Created by Disa Mhembere on 2017-09-12.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def oocase(datafn, dim=2):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input data in TODO: YP format

    **Optional Arguments:**

    dim:
        - The number of dimensions in which to embed the data
    """
    print("working with '{}', embedding into {} dimension(s) (2 is" +\
        "default).\n".format(datafn, dim))

    _oocase = robjects.r("""
    source("../SRC/oocase_interface.R")
    fn <- function(input, dmax) {
        oocase.interface(input, dmax)
    }
    """)

    _oocase(datafn, dim)

def main():
    parser = argparse.ArgumentParser(description="Python oocase wrapper")
    parser.add_argument("datafn", action="store", help="Text, human readable" +\
            "input file, which has to be n x 2 edgelist.")
    parser.add_argument("--dim", "-d", action="store", type=int, default=2,
            help="The number of dimensions in which to embed the data")
    args = parser.parse_args()

    oocase(args.datafn, args.dim)

if __name__ == "__main__":
    main()
