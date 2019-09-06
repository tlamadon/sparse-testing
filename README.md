# sparse-testing
We try a bunch of sparse linear solver on a randomly genearted sparse matrices. We have saved example matrices as matrix market format in the `mat` folder. The name `A_lnn_nz.mtx` correspond to a sparse square matrix of dimension `10^lnn` with `nz*10^lnn` non zero elements.

We then draw a random normal vector of the same size and solve the linear system. 



## preliminary benchmarks



| system | solver                     | lnn  | nnz  | precision | time  |
| ------ | :------------------------- | ---- | ---- | --------- | ----- |
| matlab | default                    | 5    | 3    |           | 0.28  |
|        |                            | 6    | 3    |           | 3.2   |
|        | bicg                       | 4    | 3    |           | 3.2   |
|        |                            | 5    | 3    |           | 37    |
| R      | Matrix package             | 5    | 3    | double    | 0.383 |
|        |                            | 6    | 3    | double    | 8.02  |
|        | Spam package               | 5    | 3    | double    | 1.5   |
|        |                            | 6    | 3    | double    | 9.9   |
| Python | scipy.sparse.linalg        | 4    | 3    | 64        | 37    |
|        | pypardiso.spsolve          | 4    | 3    | 64        | 28    |
|        | scipy.sparse.linalg.dsolve | 4    | 3    | double    | 30    |
| C++    | Eigen::SimplicialLDLT      | 6    | 3    | double    | 4     |
|        |                            | 4    | 3    | double    | 0.07  |
|        | Eigen::SparseLU            | 4    | 3    | double    | 0.9   |

 	



## Links

https://scipy-lectures.org/advanced/scipy_sparse/solvers.html

https://eigen.tuxfamily.org/dox/group__TopicSparseSystems.html

https://en.wikipedia.org/wiki/UMFPACK

https://scicomp.stackexchange.com/questions/1925/what-are-the-best-python-packages-interfaces-to-sparse-direct-solvers

https://docs.scipy.org/doc/scipy/reference/sparse.linalg.html

https://www.math.u-bordeaux.fr/~durufle/seldon/python.php

http://mumps.enseeiht.fr/index.php?page=faq

https://anaconda.org/conda-forge/mumps



[Sparse suite list of sparse matrices to test on](https://sparse.tamu.edu/)

[Suite sparse page](http://faculty.cse.tamu.edu/davis/suitesparse.html)







