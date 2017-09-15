#!/usr/bin/env python

# JHUGraph.py
# Created on 2017-09-13.

from Graph import Graph
from read_graph_r import read_graph
from ig_wrapper_r import ig_get_adjacency_matrix
from ig_wrapper_r import ig_get_num_vertices
from ig_wrapper_r import ig_get_num_edges
from ig_wrapper_r import ig_get_dangling_nodes
from ig_wrapper_r import ig_is_directed
from ig_wrapper_r import ig_is_weighted
from ig_wrapper_r import ig_summary

import numpy as np

class JHUGraph(Graph):

    def read_graph(self, fname, dtype="gml", separator="\t"):
        if dtype == "gml":
            self._object = read_graph(fname, "gml")
        elif dtype.startswith("edge"):
            self._object = read_graph(fname, "edge")
        else:
            raise NotImplementedError("Reading graphs of type '{}'".\
                    format(dtype))

        self._num_vertices = ig_get_num_vertices(self._object)
        self._num_edges = ig_get_num_edges(self._object)
        self._directed = ig_is_directed(self._object)
        self._weighted = ig_is_weighted(self._object)

    def compute_statistics(self):
        self._dangling_nodes = ig_get_dangling_nodes(self._object)

    def get_adjacency_matrix(self):
        return ig_get_adjacency_matrix(self._object)

    def summary(self):
        ig_summary(self._object)
