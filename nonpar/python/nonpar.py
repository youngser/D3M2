#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def nonpar(datafn1,datafn2,bandwidth=0.5):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn1:
        - The path to the first input data; an n x d matrix - in TODO: YP format
    datafn2:
        - The path to the second input data; an n x d matrix - in TODO: YP format

    **Optional Arguments:**

    bandwidth:
        - a bandwidth for the Gaussian kernel
    """

    print("testing if '{}' and '{}' are from the same distribution or" +\
    "not using a kernel-based test statistic and bandwidth {} (0.5 is" +\
    "default).\n".format(datafn1, datafn2, bandwidth))

    _nonpar = robjects.r("""
    source("../SRC/nonpar.interface.R")
    fn <- function(input1, input2, sigma) {
        nonpar.interface(input1, input2, sigma)
    }
    """)

    _nonpar(datafn1, datafn2, bandwidth)


def test():
    nonpar("../DATA/in_vectors.txt","../DATA/out_vectors.txt")

if __name__ == "__main__":
    test()
