#include <Eigen/Sparse>
#include <vector>
#include <iostream>
#include <time.h>   	// for clock_t, clock(), CLOCKS_PER_SEC
#include <unsupported/Eigen/SparseExtra>
#include <Eigen/SparseCholesky>
#include<Eigen/IterativeLinearSolvers>

using namespace Eigen;
using namespace std;

typedef SparseMatrix<double> SpMat; // declares a column-major sparse matrix type of double

int main() {
    typedef SparseMatrix<double,ColMajor>SMatrixXf;
    SMatrixXf A;

    SimplicialLDLT <SMatrixXf> solver;
    //BiCGSTAB  <SMatrixXf> solver;
    //SparseLU <SparseMatrix<double> > solver;

    // load matrix using Matrix Market format
    //loadMarket(A, "../mats/bcspwr06/bcspwr06.mtx");
    loadMarket(A, "../mats/mat_4_3.mtx");
    SparseMatrix<double, ColMajor> temp; 
    temp = A;
    A = temp.selfadjointView<Lower>();

    std::cout << "number of rows:" << A.rows() << " cols:" << A.cols() << "." << std::endl;

    VectorXd b(A.cols()); // creates a vector dymanic size, double            
    b.setRandom();
    std::cout << "norm of b:" << b.norm() << std::endl;

	// to store execution time of code
	double time_spent = 0.0;
	clock_t begin = clock();

    solver.compute(A);
    if(solver.info()!=Success) {
        std::cout << "decomposition failed" << solver.info() << std::endl;
        return -1;
    }
    VectorXd x = solver.solve(b); 

	clock_t end = clock();
    time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
    std::cout << "time spent:" << time_spent << std::endl;
    std::cout << "squarred norm of x:" << x.squaredNorm() << std::endl;

    // Solving:
    // SimplicialCholesky<SMatrixXf> chol(A);  // performs a Cholesky factorization of A
    // VectorXd x = chol.solve(b);         // use the factorization to solve for the given right hand side

    // Compute Mean Squre Error
    VectorXd err = A * x - b ;
    std::cout << "squarred norm of residuals:" << err.norm()/b.norm() << std::endl;
}