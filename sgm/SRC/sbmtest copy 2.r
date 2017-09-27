require(igraph)
require(VN)

test.HGP <- function()
{    
    B <- matrix(c(0.7,0.2,0.1,0.2,0.5,0.3,0.1,0.3,0.6),nrow=3,ncol=3)
    n <- 150
    size <- rep(n/3,3)

    set.seed(123)
    M <- sbm.game(n,pref.matrix = B,block.sizes=size)

    A <- as.matrix(get.adjacency(M))
    (reordr <- sample(n,n,replace=FALSE))
    B <- A[reordr,reordr]
    perm <- diag(n)
    perm <- perm[reordr,]
    Aperm <- perm %*% A %*% t(perm)
    all(Aperm==B) # true, so perm is the true permutation matrix

    obj <- function(x,y,P){
        dif <- norm(x - P %*% y %*% t(P))
        return(dif)
    }

    (objtrue <- obj(B,A,perm))


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

    (objs0 <- obj(B,A,P))

    plot(raster(B))
    plot(raster(P %*% A %*% t(P)))

    plot(raster(A))
    plot(raster(t(P) %*% B %*% P))

    c(objtrue, objs0)

    ## compare order1 and reordr
    length(which((reordr-order1)==0))
    all(P == perm)


##########################################################

    ## With 5 seeds

    set.seed(567)

    m <- 5
    S1 <- sample(1:n,m)
    Sp <- reordr[S1]
    S <- cbind(Sp,S1)

    s <- nrow(S)
    if(is.null(s)){
        s <- 0
    }
    M <- rsp(n-s,gam)

    game5 <- sgm.unpaired(B,A,start=M,S,pad=0,iteration=niter)
    P <- game5$P
    order5 <- game5$corr

    notseedsa <- setdiff(1:nrow(A),S1)
    notseedsb <- setdiff(1:nrow(B),Sp)
    inda <- c(S1,notseedsa)
    indb <- c(Sp,notseedsb)

    ## obj is B - PAP'

    permseed5 <- perm[indb,inda]

    ## For checking purposes:
    Anew <- A[inda,inda]
    Bnew <- B[indb,indb]
    Sorder <- cbind(1:5,1:5)
    game5seedsfirst <- sgm.unpaired(Bnew,Anew,start=M,Sorder,pad=0,iteration=niter)
    (objs5seedsfirst <- obj(Bnew,Anew,game5seedsfirst$P))


    (objtrue5s <- obj(Bnew,Anew,permseed5))
    (objs5 <- obj(Bnew,Anew,P))


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

    all(begin[S1,Sp]==perm[S1,Sp])


    set.seed(987)
    game5soft <- sgm(B,A,start=begin,NULL,pad=0,iteration=niter)
    P5soft <- game5soft$P
    order5soft <- game5soft$corr


    obj5soft <- obj(B,A,P5soft)

    plot(raster(B))
    plot(raster(P5soft %*% A %*% t(P5soft)))

    plot(raster(A))
    plot(raster(t(P5soft) %*% B %*% P5soft))

    c(objtrue, obj5soft)

                                        # compare order1 and reordr
    length(which((reordr-order5soft)==0))
    all(P5soft == perm)
}

test.YP <- function()
{
    obj <- function(x,y,P){
        dif <- norm(x - P %*% y %*% t(P))
        return(dif)
    }
    
    set.seed(123)
    n <- 30
    m <- 10
    g1 <- erdos.renyi.game(n, .1)
#    (randperm <- c(1:m, m+sample(n-m)))
    (randperm <- c(sample(n-m), (n-m+1):n))
    g2 <- sample_correlated_gnp(g1, corr=1, p=g1$p, perm=randperm)
#    g2 <- permute.vertices(g1, randperm)
    
    A  <- as.matrix(get.adjacency(g1))
    B  <- as.matrix(get.adjacency(g2))

    ## igraph
    s <- 0
    P  <-match_vertices (B, A, m=s, start=diag(1/(n-s),n-s,n-s), 20)
    obj(B,A,P$P) # 46
    (matched <- sum(P$corr[,2]==match(1:n,randperm))); matched / n * 100

    # soft
    P2  <-sgm2 (B, A, S=NULL, start=diag(1/(n-s),n-s,n-s), 20)
    obj(B,A,P2$P) # 46
    (matched <- sum(P2$corr==match(1:n,randperm))); matched / n * 100

    ## hard
    (pair <- cbind(1:m, randperm[1:m]))
    P3  <-sgm2 (B, A, S=pair, start=diag(1/(n-m),n-m,n-m), 20)
    obj(B,A,P3$P) # 62
    (matched <- sum(P3$corr==match(1:n,randperm)[-c(1:m)])+m); matched / n * 100

    ## VL's soft
    P4 <- sgm (B,A,pair,hard=FALSE,20)
    obj(B,A,P4$P) # 64
    (matched <- sum(P4$corr==match(1:n,randperm))); matched / n * 100

    ## VL's hard
    P5 <- sgm (B,A,pair,hard=TRUE,20)
    obj(B,A,P5$P) # 62
    (matched <- sum(P5$corr==match(1:n,randperm)[-c(1:m)])+m); matched / n * 100
    
}






