% simple testing of sparse routing method
% see here https://math.nist.gov/MatrixMarket/mmio/matlab/mmiomatlab.html

A = mmread('../mats/mat_4_3.mtx');

% sparse solver - iterative
A = mmread('../mats/mat_5_3.mtx');
b = randn(size(A,1),1);
tic ;
x = bicg(A,b,1e-7,10000);
toc

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





