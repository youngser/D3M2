require(igraph)
require(VN)
## source("multiStart.r")
## source("rsp.r")
## source("sgm.r")
## source("localnbd.r")

B <- matrix(c(0.7,0.2,0.1,0.2,0.5,0.3,0.1,0.3,0.6),nrow=3,ncol=3)
n <- 150
size <- rep(50,3)

set.seed(123)
M <- sbm.game(n,pref.matrix = B,block.sizes=size)

A <- as.matrix(get.adjacency(M))
reordr <- sample(n,n,replace=FALSE)
B <- A[reordr,reordr]
perm <- diag(n)
perm <- perm[reordr,]
Aperm <- perm %*% A %*% t(perm)
all(Aperm==B) # true, so perm is the true permutation matrix

obj <- function(x,y,P){
    dif <- norm(x - P %*% y %*% t(P))
    return(dif)
}

objtrue <- obj(B,A,perm)

gam <- .1
niter <- 30

g1 <- graph_from_adjacency_matrix(A, mode="undirected")
g2 <- graph_from_adjacency_matrix(B, mode="undirected")

## With 5 seeds

set.seed(567)

m <- 5
S1 <- sample(1:n,m)
Sp <- reordr[S1]
S <- cbind(Sp,S1)

x <- sample(setdiff(1:n,Sp),1)

h <- 2
ell <- 2
R <- 20
g <- 0.1

game5 <- vnsgm(x,S,g2,g1,h,ell,R,g)

str(game5)


