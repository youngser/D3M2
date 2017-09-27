# JHU D3M TA1 Primitives

This repository contains JHU's TA1 primitives which can be run in a
single docker container.  All codes are written in R (> 3.0) and Python (>= 3.5).

It is composed with followings:

- A wrapper of R interface for `igraph` in Python
- Wrappers of the R primitives in Python
- A fully functional Python3 compatible interface for all primitives
- A Docker file that can run all primitives


# Docker

- To build: `docker build -t d3m .`
- To run: `docker run -i -t d3m`
- To test: 
  * `cd D3M/api`
  * `python3 test_Graph.py`
  * `python3 test_JHUTransform.py`
