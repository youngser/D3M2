#!/usr/bin/env python

# sgm.py
# Copyright (c) 2017. All rights reserved.

import os
import rpy2.robjects as robjects

def sgm(g1, g2, seeds):
    """
    TODO: YP description

    **Positional Arguments:**

    g1:
        - The first input graph object - in JHUGraph format
    g2:
        - The second input graph object - in JHUGraph format

    **Optional Arguments:**

    seeds:
        - The matrix of seed indices. The first column corresponds to seed index
          for graph 1 and second column corresponds to seed index for
          graph 2, where each row corresponds to a seed pair.
          If empty, assumes no seeds are used.
    """

    path = os.path.join(os.path.abspath(os.path.dirname(__file__)),
            "sgm.interface.R")

    cmd = """
    source("%s")
    fn <- function(g1, g2, S) {
        sgm.interface(g1, g2, S)
    }
    """ % path

    return robjects.r(cmd)(g1._object, g2._object, seeds)
