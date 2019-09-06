# sparse-testing
We try a bunch of sparse linear solver on a randomly genearted sparse matrices. We have saved example matrices as matrix market format in the `mat` folder. The name `A_lnn_nz.mtx` correspond to a sparse square matrix of dimension `10^lnn` with `nz*10^lnn` non zero elements.

We then draw a random normal vector of the same size and solve the linear system. 



## temporary benchmarks



| system | solver              | lnn  | nnz  | precision | time  |
| ------ | :------------------ | ---- | ---- | --------- | ----- |
| matlab | default             | 5    | 3    |           | 0.28  |
|        |                     | 6    | 3    |           | 3.2   |
|        | bicg                | 4    | 3    |           | 3.2   |
|        |                     | 5    | 3    |           | 37    |
| R      | Matrix package      | 5    | 3    | double    | 0.383 |
|        |                     | 6    | 3    | double    | 8.02  |
|        | Spam package        | 5    | 3    | double    | 1.5   |
|        |                     | 6    | 3    | double    | 9.9   |
| Python | scipy.sparse.linalg | 4    | 3    | 64        | 37    |
|        | pypardiso.spsolve   | 4    | 3    | 64        | 28    |









