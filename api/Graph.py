#!/usr/bin/env python

# Graph.py
# Created on 2017-09-13.

import abc
from read_graph_r import read_gml
from ig_wrapper_r import ig_get_adjacency_matrix
from ig_wrapper_r import ig_get_num_vertices
from ig_wrapper_r import ig_get_num_edges
from ig_wrapper_r import ig_get_dangling_nodes
from ig_wrapper_r import ig_is_directed
from ig_wrapper_r import ig_is_weighted

import numpy as np

class Graph(object):
    adjacency_matrix = None # TODO: Make a dummy
    _num_vertices = None
    _num_edges = None
    _directed = None
    _weighted = None
    _dangling_nodes = None

    def __init__(self):
        pass

    @abc.abstractmethod
    def read_graph(self, fname, dtype="gml"):
        if dtype == "gml":
            self._object = read_gml(fname)
        else:
            raise NotImplementedError("Reading graphs of type '{}'".\
                    format(dtype)

        self._num_vertices = ig_get_num_vertices()
        self._num_edges = ig_get_num_edges()
        self._directed = ig_is_directed()
        self._weighted = ig_is_weighted()

    @abc.abstractmethod
    def compute_statistics(self):
        # TODO: Test
        self._dangling_nodes = np.array(ig_get_dangling_nodes(self._object))

    @abc.abstractmethod
    def get_adjacency_matrix(self):
        return ig_get_adjacency_matrix(self._object)

    @abc.abstractmethod
    def get_num_vertices(self):
        return self._num_vertices

    @abc.abstractmethod
    def get_num_edges(self):
        return self._num_edges

    @abc.abstractmethod
    def is_directed(self):
        return self._directed

    def is_weighted(self):
        return self._weighted

    @abc.abstractmethod
    def get_dangling_nodes(self):
        if (self._dangling_nodes is None):
            self.compute_statistics()
        return self._dangling_nodes
