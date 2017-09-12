#!/usr/bin/env python

# lse.py
# Created by Disa Mhembere on 2017-09-12.
# Email: disa@jhu.edu
# Copyright (c) 2017. All rights reserved.

import argparse
import rpy2.robjects as robjects

def lse(datafn, dim=2):
    """
    Perform Laplacian Spectral Embedding on a matrix
    TODO: YP description

    **Positional Arguments:**

    datafn:
        - The path to the input data in TODO: YP format

    **Optional Arguments:**

    dim:
        - The number of dimensions in which to embed the data
    """
    print("working with '{}', embedding into {} dimension(s) (2 is" +\
        "default).\n".format(datafn, dim))

    _lse = robjects.r("""
    fn <- function(input, dim) {
	X <- as.matrix(read.table(input))
	if (nrow(X) == ncol(X)) {
	    # pass to rank
	    tmp <- X[X!=0]
	    nnz <- length(tmp)
	    rk <- rank(tmp) / nnz
	    X[X!=0] <- rk * 2 / nnz

	    # form igraph object: directed, weighted, hollow
	    suppressMessages(require(igraph))
	    g <- graph_from_adjacency_matrix(X,weighted=TRUE,mode="directed",diag=FALSE)
	} else {
	    stop("The input matrix must be a square matrix!")
	}

	# embedding into "dim"
	embed <- embed_laplacian_matrix(g, dim)

	cat("The output files are saved in 'DATA/out_vectors.txt',
		'DATA/in_vectors.txt', and 'DATA/eigenvalues'.\n")
	write.table(embed$X,"~/D3M/DATA/out_vectors.txt", col.names=F, row.names=F)
	write.table(embed$Y,"~/D3M/DATA/in_vectors.txt", col.names=F, row.names=F)
	write(embed$D,"~/D3M/DATA/eigenvalues.txt", ncol=1)
    }
    """)

    _lse(datafn, dim)

def main():
    parser = argparse.ArgumentParser(description="Python LSE wrapper")
    parser.add_argument("datafn", action="store", help="Text, human readable" +\
            "space separated vector data, newline separeated")
    parser.add_argument("--dim", "-d", action="store", type=int, default=2,
            help="The number of dimensions in which to embed the data")
    args = parser.parse_args()

    lse(args.datafn, args.dim)

if __name__ == "__main__":
    main()
