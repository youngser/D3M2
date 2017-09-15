#!/usr/bin/env python

# dimselect.py
# Created by Disa Mhembere on 2017-09-11.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def vnsgm(datafn1,datafn2,numseeds):
    """
    TODO: YP description

    **Positional Arguments:**

    datafn1:
        - The first input graph object - in TODO: YP format
    datafn2:
        - The second input graph object - in TODO: YP format

    numseeds:
        - the number of seeds, assumed to be the first "seeds" vertices
          in both graphs with identity correspondence
    """

    print("matching '{}' and '{}' to minimize the number of adjacency" +\
      "disagreements using '{}' seeds.\n".format(datafn1, datafn2, numseeds))

    _vnsgm = robjects.r("""
    source("../SRC/vnsgm.interface.R")
    fn <- function(g1, g2, s) {
        vnsgm.interface(g1, g2, s)
    }
    """)

    _vnsgm(datafn1, datafn2, numseeds)


def test():
    vnsgm("../DATA/input1.txt","../DATA/input2.txt", 0)

if __name__ == "__main__":
    test()
