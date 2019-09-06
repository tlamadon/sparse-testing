% simple testing of sparse routing method
% see here https://math.nist.gov/MatrixMarket/mmio/matlab/mmiomatlab.html

A = mmread('../mats/mat_4_3.mtx');

% sparse solver - iterative
A = mmread('../mats/mat_4_3.mtx');
b = randn(size(A,1),1);
tic ;
x = bicg(A,b,1e-7,100000);
toc
mean((A*x-b).^2)

% sparse solver - iterative
A = mmread('../mats/mat_5_3.mtx');
b = randn(size(A,1),1);
tic ;
alpha = .1;
L1 = ichol(A, struct('type','ict','droptol',1e-3,'diagcomp',alpha));

x = pcg(A,b,1e-6,10000);
toc
mean((A*x-b).^2)


A = mmread('../mats/mat_4_3.mtx');

% sparse solver - direct?
A = mmread('../mats/mat_5_3.mtx');
b = randn(size(A,1),1);
x = A \ b;

% sparse solver - direct?
A = mmread('../mats/mat_6_3.mtx');
b = randn(1000000,1);
tic;
x = A \ b;
t = toc
t





