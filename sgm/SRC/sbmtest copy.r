require(igraph)
require(VN)
#source("sgm2.r")

test.HGP <- function()
{    
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

    ## With 0 seeds

    S <- NULL 
    s <- nrow(S)
    if(is.null(s)){
        s <- 0
    }
    M <- rsp(n-s,gam)
    bcs <- diag(n)
    bcs[(s+1):n,(s+1):n] <- M

    game1 <- sgm.unpaired(B,A,start=bcs,S,pad=0,iteration=niter)
    P <- game1$P
    order1 <- game1$corr

    objs0 <- obj(B,A,P)

    plot(raster(B))
    plot(raster(P %*% A %*% t(P)))

    plot(raster(A))
    plot(raster(t(P) %*% B %*% P))

    c(objtrue, objs0)

                                        # compare order1 and reordr
    length(which((reordr-order1)==0))
    all(P == perm)


##########################################################

    ## With 5 seeds

    set.seed(567)

    m <- 5
    S1 <- sample(1:n,m)
    Sp <- reordr[S1]
    S <- cbind(S1,Sp)

    s <- nrow(S)
    if(is.null(s)){
        s <- 0
    }
    M <- rsp(n-s,gam)
    bcs <- diag(n)
    bcs[(s+1):n,(s+1):n] <- M

    game5 <- sgm.unpaired(B,A,start=M,S,pad=0,iteration=niter)
    P <- game5$P
    order5 <- game5$corr

    notseedsa <- setdiff(1:nrow(A),S[,1])
    notseedsb <- setdiff(1:nrow(B),S[,2])
    inda <- c(S1,notseedsa)
    indb <- c(Sp,notseedsb)

                                        # obj is B - PAP'

    permseed5 <- perm[ind2,ind1]
    (objtrue5s <- obj(Bnew,Anew,permseed5))

    ## For checking purposes:
    Anew <- A[inda,inda]
    Bnew <- B[indb,indb]
    Sorder <- cbind(1:5,1:5)
    game5seedsfirst <- sgm(Bnew,Anew,start=M,Sorder,pad=0,iteration=niter)

    (objs5 <- obj(Bnew,Anew,P))

    (objs5seedsfirst <- obj(Bnew,Anew,game5seedsfirst$P))

    c(objtrue5s, objs5)

    all(permseed5 == P)


    plot(raster(Bnew))
    plot(raster(P %*% Anew %*% t(P)))

    plot(raster(Anew))
    plot(raster(t(P) %*% Bnew %*% P))

    ## Same 5 seeds, but soft-seeding

    begin <- matrix(0,n,n)
    begin[notseedsa,notseedsb] <- M
    begin[S1,Sp] <- diag(s)


    set.seed(987)
    game1 <- sgm(A,B,start=begin,NULL,pad=0,iteration=niter)
    P <- game1$P
    order1 <- game1$corr
}

test.YP <- function()
{
    set.seed(123)
    n <- 10
    m <- 3

    g1 <- erdos.renyi.game(n, .3)
    A <- as.matrix(g1[])

    S1 <- 1:m
    Sp <- sample(1:n,m)
    (S <- cbind(Sp,S1))

    (reord <- c(Sp, setdiff(1:n, Sp)))
    B <- A[reord,reord]

    M <- rsp(n-m,0.1)
    bcs <- diag(n)
    (bcs[(m+1):n,(m+1):n] <- M)

    niter <- 30
    game5 <- sgm.unpaired(B,A,start=M,S,pad=0,iteration=niter)
    game5
    
}




