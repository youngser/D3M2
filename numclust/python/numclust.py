#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def numclust(datafn):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input data in TODO: YP format
    """
    print("working with: {}".format(datafn))

    _numclust = robjects.r("""
    source("../SRC/numclust.interface.R")
    fn <- function(input) {
        numclust.interface(input)
    }
    """)

    _numclust(datafn)


def test():
    numclust("../DATA/input.txt")

if __name__ == "__main__":
    test()
