
import ctypes
import numpy as np
from numpy.ctypeslib import ndpointer

lib_c = ctypes.CDLL('./mkl_random.so')
lib_c.c_randn_numpy.argtypes=[ctypes.c_int,ctypes.POINTER(ctypes.c_float)]
lib_c.c_randn_numpy.restype = None
lib_c.freeptr.argtype = ctypes.c_void_p
lib_c.freeptr.restype = None


def my_randn(N):
    ct = ctypes.c_float*N
    arrp= ct()
    lib_c.c_randn_numpy(N,arrp)
    return np.ctypeslib.as_array(arrp,shape=(N,))



