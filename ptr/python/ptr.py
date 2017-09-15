#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def ptr(datafn):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input graph in 'igraph' format or n x 2 edge
          list or n x n adjacency matrix -- TODO: YP format
    """
    print("working with: {}".format(datafn))

    _ptr = robjects.r("""
    source("../SRC/ptr.interface.R")
    fn <- function(input) {
        ptr.interface(input)
    }
    """)

    _ptr(datafn)


def test():
    ptr("../DATA/input.txt")

if __name__ == "__main__":
    test()
