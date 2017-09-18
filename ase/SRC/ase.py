#!/usr/bin/env python

# ase.py
# Created by Disa Mhembere on 2017-09-12.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import rpy2.robjects as robjects
import os

def ase(g, dim):
    """
    Perform Adjacency Spectral Embedding on a graph
    TODO: YP description

    **Positional Arguments:**

    g:
        - Graph in JHUGraph format

    **Optional Arguments:**

    dim:
        - The number of dimensions in which to embed the data
    """

    path = os.path.join(os.path.abspath(os.path.dirname(__file__)),
            "ase.interface.R")
    cmd = """
    source("%s")
    fn <- function(g, dim) {
        ase.interface(g, dim)
    }
    """ % path

    return robjects.r(cmd)(g._object, dim)
