
import ctypes
import numpy as np
from numpy.ctypeslib import ndpointer

N =10000000

lib_c = ctypes.CDLL('./mkl_random.so')


ct = ctypes.c_float*N
arrp= ct()


lib_c.c_randn_numpy.argtypes=[ctypes.c_int,ctypes.POINTER(ctypes.c_float)]
lib_c.c_randn_numpy.restype = None

lib_c.freeptr.argtype = ctypes.c_void_p
lib_c.freeptr.restype = None


lib_c.c_randn_numpy(N,arrp)
a =np.ctypeslib.as_array(arrp,shape=(N,))


#for i in a:
#    print(i)


print(a[4])

print("done")
