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
from sgm.SRC.sgm import sgm
from gclust.SRC.gclust import gclust
from oocase.SRC.oocase import oocase # FIXME: Expects a FlashGraph object

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
        """
        TODO: YP document
        """
        return np.array(dimselect(X))

    def sgm_transform(self, g1, g2, numseeds):
        """
        TODO: YP document
        """
        return np.array(sgm(g1, g2, numseeds))

    def gclust_transform(self, X, dim=2):
        """
        TODO: YP document
        """
        return gclust(X, dim)[0]

    def oocase_transform(self, g, dim):
        """
        TODO: YP document
        """
        return oocase(g, dim)


def test():
    gpath, rig = gen_graph_r(n=50, p=.1)

    g = JHUGraph()
    g.read_graph(gpath)

    print("Summary: ")
    g.summary()
    t = JHUTransform()

    # ASE
    ASE = t.ase_transform(g, 4)
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

    # SGM
    gpath, rig2 = gen_graph_r(n=50, p=.1)
    g2 = JHUGraph()
    g2.read_graph(gpath)

    SGM = t.sgm_transform(g, g2, 3)
    print "SGM: ", SGM, "\n\n"

    # GCLUST
    GCLUST = t.gclust_transform(ASE, 2)
    print "GCLUST: ", GCLUST, "\n\n"

test()
