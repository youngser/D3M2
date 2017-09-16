#!/usr/bin/env python

# gclust.py
# Copyright (c) 2017. All rights reserved.

import os
import numpy as np
import rpy2.robjects as robjects
import rpy2.robjects.numpy2ri
rpy2.robjects.numpy2ri.activate()

def gclust(X, dim=2):
    """
    TODO: YP description

    **Positional Arguments:**

    X:
        - A matrix

    **Optional Arguments:**

    dim:
        - The number of clusters in which to assign the data
    """

    path = os.path.join(os.path.abspath(os.path.dirname(__file__)),
            "gclust.interface.R")
    cmd = """
    source("%s")
    fn <- function(X, dim) {
        gclust.interface(X, dim)
    }
    """ % path
    return robjects.r(cmd)(X, dim)
