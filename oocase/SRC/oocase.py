#!/usr/bin/env python

# oocase.py
# Created by Disa Mhembere on 2017-09-12.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import os
import rpy2.robjects as robjects

def oocase(g, dim=2):
    """
    TODO: YP description

    **Positional Arguments:**

    g:
        - A graph

    **Optional Arguments:**

    dim:
        - The number of dimensions in which to embed the data
    """

    path = os.path.join(os.path.abspath(os.path.dirname(__file__)),
            "oocase.interface.R")

    cmd = """
    source("%s")
    fn <- function(g, dim) {
        oocase.interface(g, dmax)
    }
    """ % path

    return robjects.r(cmd)(g._object, dim)
