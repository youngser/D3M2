#! /usr/bin/env python

# util.py
# Created on 2017-09-14.

def gen_graph_r(n=10, p=.2):
    from read_graph_r import read_gml
    import igraph
    return igraph.Graph.Erdos_Renyi(n, p)
    gpath = "/tmp/graph.gml"
    g.write_gml(gpath)

    return read_gml(gpath)
