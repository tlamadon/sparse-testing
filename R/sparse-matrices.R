# ---- create some sparse matrices in Matrix Market Format -----
library(Matrix)
library(data.table)

make.sparse.mat <- function(nn,nz.fact = 3) {
  nz = 3*nn
  i <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  j <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  x <- rnorm(nz+2)
  dd = rbind(data.table(i=i,j=j,x=x),data.table(i=j,j=i,x=x)) # create symetric matrix
  dd = rbind(dd[i!=j], data.table(i=1:nn,j=1:nn,x=rnorm(nn)))
  A <- sparseMatrix(dd$i, dd$j, x = dd$x)
  return(A)
}

make.sparse.mat.asframe <- function(nn,nz.fact = 3) {
  nz = 3*nn
  i <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  j <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  x <- rnorm(nz+2)
  dd = rbind(data.table(i=i,j=j,x=x),data.table(i=j,j=i,x=x)) # create symetric matrix
  dd = rbind(dd[i!=j], data.table(i=1:nn,j=1:nn,x=rnorm(nn)))
  return(dd)
}

for (i in 3:6) {
  A = make.sparse.mat(10^i)
  writeMM(A, file=sprintf("~/git/sparse-testing/mats/mat_%i_3.mtx",i))
}

A_2_3 = make.sparse.mat(100)
A_3_3 = make.sparse.mat(1000)
writeMM(A_4_3, file="~/git/sparse-testing/mats/mat_4_3.mtx")
A_5_3 = make.sparse.mat(10000)
writeMM(A_5_3, file="~/git/sparse-testing/mats/mat_5_3.mtx")
A_6_3 = make.sparse.mat(100000)
writeMM(A_6_3, file="~/git/sparse-testing/mats/mat_6_3.mtx")
A_7_3 = make.sparse.mat(1000000)
writeMM(A_7_3, file="~/git/sparse-testing/mats/mat_7_3.mtx")


### ---  some simple solvers --------

ff <- function(lnn) {
  nn = 10^lnn
  dd = make.sparse.mat.asframe(nn)
  A <- sparseMatrix(dd$i, dd$j, x = dd$x)
  b = 1 - (runif(nn)>0.5)*2
  s = system.time( { x0 = Matrix::solve(A,b,sparse=TRUE,tol=1e-7) })
  mse = mean( ( (A %*% x0) - b )^2)
  return(list(nn=nn,lnn=log(nn)/log(10),mse=mse,time=s[1],name="r_matrix"))
}

rr = data.frame()

ff(4)
ff(5)
ff(6)




sparse_solver <- function(nn) {
  nz = 3*nn
  i <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  j <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
  x <- rnorm(nz+2)
  dd = rbind(data.table(i=i,j=j,x=x),data.table(i=j,j=i,x=x)) # create symetric matrix
  dd = rbind(dd[i!=j], data.table(i=1:nn,j=1:nn,x=rnorm(nn)))
  A <- sparseMatrix(dd$i, dd$j, x = dd$x)
  b = 1 - (runif(nn)>0.5)*2
  s = system.time( { x0 = Matrix::solve(A,b,sparse=TRUE,tol=1e-7) })
  mse = mean( ( (A %*% x0) - b )^2)
  print(sprintf("size=%i time=%4.4f mse=%4.4e \n", nn, s[1] , mse))
  return(list(size=nn,time=s[1],mse=mse))
}

r1 = sparse_solver(1000)
r2 = sparse_solver(10000)
r3 = sparse_solver(100000)
r4 = sparse_solver(1000000)

s = system.time()


#### --- SPAM package ------
library(spam)
library(spam64)

nn = 1000000
nz = 3*nn
i <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
j <- sort( c(sample.int(nn,nz,replace=T) ,1 ,nn) );
x <- rnorm(nz+2)
dd = rbind(data.table(i=i,j=j,x=x),data.table(i=j,j=i,x=x)) # create symetric matrix
dd = dd[, list(x=x[1]),list(i,j)]
dd = rbind(dd[i!=j], data.table(i=1:nn,j=1:nn,x=10))
A <- spam(0, nrow = nn, ncol = nn)
A[cbind(dd$i, dd$j)] <- dd$x

b = 1 - (runif(nn)>0.5)*2
system.time( { x0 = spam::solve(A,b,sparse=TRUE)})
mse = mean( ( (A %*% x0) - b )^2)


#R = Matrix::lu(A)

# try to solve the linear system directly
b = 1 - (runif(nn)>0.5)*2
x0 = Matrix::solve(A,b,sparse=TRUE,tol=1e-7)
#x0 = solve(A,b,sparse=TRUE,tol=1e-7)
mean( ( (A %*% x0) - b )^2)

library(Rlinsolve)
x = lsolve.cgs(A,b,maxiter=5000)
mean( ( (A %*% x$x) - b )^2)



