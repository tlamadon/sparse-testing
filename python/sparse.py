import numpy as np
import pandas as pd
import time

from scipy.sparse import csc_matrix,coo_matrix
from scipy.sparse.linalg import spsolve
from scipy.sparse import csc_matrix, linalg as sla
import scipy.sparse.linalg as spla
import scipy
from scipy.sparse.linalg.dsolve import linsolve

import pypardiso

nn = 10000  # size of the matrix
nz = 3*nn  # number of non zero terms

i = np.random.randint(0,nn-1, nz)
j = np.random.randint(0,nn-1, nz)
x = np.random.normal(size=nz)
dd = pd.DataFrame({"i":i,"j":j,"x":x})
dd = pd.concat([dd,dd.rename(columns= {'i':'j','j':'i'})],sort=False).query('i!=j')
diag = pd.DataFrame( {'i':range(nn),'j':range(nn),'x':10})
dd = pd.concat([ dd,diag])

M = csc_matrix( (dd.x, (dd.i, dd.j)), shape=(nn, nn))
b = np.random.normal(size= nn)

#M = M.tocsr()
time_start = time.clock()
#lu = sla.splu(M)
#x = spla.spsolve(M,b,use_umfpack=False)
#x = lu.solve(b)
# x = spla.cg(M,b)[0]
# x = pypardiso.spsolve(M,b)
x = linsolve.spsolve(M, rhs)
time_elapsed = (time.clock() - time_start)
mse = np.power(M.dot(x) - b, 2.0).mean()
#mse= 0

print( " time = {} error = {}".format(time_elapsed, mse))

