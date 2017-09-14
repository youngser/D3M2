#! /usr/bin/env python

# util.py
# Created on 2017-09-14.

def gen_graph_r(n=10, p=.2):
    from read_graph_r import read_graph
    import igraph
    g = igraph.Graph.Erdos_Renyi(n, p)
    gpath = "/tmp/graph.gml"
    g.write_gml(gpath)

    ig = read_graph(gpath, "gml")
    return (gpath, ig)
