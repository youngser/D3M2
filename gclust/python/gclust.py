#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def gclust(datafn,dim=2):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input data in TODO: YP format

    **Optional Arguments:**

    dim:
        - The number of clusters in which to assign the data
    """

    print("working with '{}', embedding into {} dimension(s) (2 is" +\
        "default).\n".format(datafn, dim))

    _gclust = robjects.r("""
    source("../SRC/gclust.interface.R")
    fn <- function(input, K) {
        gclust.interface(input, K)
    }
    """)

    _gclust(datafn, dim)


def test():
    gclust("../DATA/in_vectors.txt")

if __name__ == "__main__":
    test()
