#!/usr/bin/env python

# JHUTransform.py

import sys, os
from Transform import Transform
from JHUGraph import JHUGraph
from util import gen_graph_r
import numpy as np

sys.path.append(os.path.abspath("../"))

from ase.SRC.ase import ase
from lse.SRC.lse import lse
from ptr.SRC.ptr import ptr
from dimselect.SRC.dimselect import dimselect

class JHUTransform(Transform):

    def ase_transform(self, g, dim=2):
        """
        TODO: YP document
        """
        return np.array(ase(g, dim)[0]) # TODO: YP do we need more?

    def lse_transform(self, g, dim=2):
        """
        TODO: YP document
        """
        return np.array(ase(g, dim)[0]) # TODO: YP do we need more?

    def ptr_transform(self, g):
        """
        TODO: YP document
        """
        return np.array(ptr(g))

    def dimselect_transform(self, X):
        return np.array(dimselect(X))


def test():
    gpath, rig = gen_graph_r(n=50, p=.1)

    g = JHUGraph()
    g.read_graph(gpath)

    print("Summary: ")
    g.summary()
    t = JHUTransform()

    # ASE
    ASE = t.ase_transform(g, 2)
    print "ASE: ", ASE, "\n\n"

    # LSE
    LSE = t.lse_transform(g, 2)
    print "LSE: ", ASE, "\n\n"

    # PTR
    PTR = t.ptr_transform(g)
    print "PTR: ", PTR, "\n\n"

    # DIM
    DIM = t.dimselect_transform(g.get_adjacency_matrix())
    print "DIM: ", DIM, "\n\n"

test()
