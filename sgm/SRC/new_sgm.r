new_sgm<-function (A,B,seeds,hard,iteration){
  if(is.null(seeds)){
    m=0
    nv1<-nrow(A)
    nv2<-nrow(B)
    nv<-max(nv1,nv2)
    start<-matrix(1/nv,nv,nv)
    AA <- A
    BB <- B
  }else{
    nv1<-nrow(A)
    nv2<-nrow(B)
    nv<-max(nv1,nv2)
    
    s1<-seeds[,1]
    temp<-s1
    s1<-rep(FALSE,nv1)
    s1[temp]<- TRUE
    ns1 <- !s1
    
    s2<-seeds[,2]
    temp<-s2
    s2<-rep(FALSE,nv2)
    s2[temp]<- TRUE
    ns2 <- !s2
    
    A11<-A[s1,s1]
    A12<-A[s1,ns1]
    A22<-A[ns1,ns1]
    A21<-A[ns1,s1]
    
    AA<-rbind(cbind(A11,A12),cbind(A21,A22))
    
    B11<-B[s2,s2]
    B12<-B[s2,ns2]
    B22<-B[ns2,ns2]
    B21<-B[ns2,s2]
    
    BB<-rbind(cbind(B11,B12),cbind(B21,B22))
  
    if(hard==TRUE){
      m=length(temp)
      n<-nv-m
      start<-matrix(1/n,n,n)
    }else{
        m=0
        s<-length(temp)
        start<-rbind(cbind(diag(s),matrix(0,s,nv-s)),cbind(matrix(0,nv-s,s),matrix(1/(nv-s),nv-s,nv-s)))
    }
  }
  
  P<-sgm(AA,BB,m,start,pad=0,iteration)
  return(P)
}
