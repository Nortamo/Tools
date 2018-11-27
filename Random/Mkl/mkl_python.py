import ctypes
import matplotlib.pyplot as plt

N =100000

lib_c = ctypes.CDLL('./mkl_random.so')

lib_c.c_randn.restype = ctypes.POINTER(ctypes.c_float*N)
lib_c.freeptr.argtype = ctypes.c_void_p
lib_c.freeptr.restype = None
darrayptr = lib_c.c_randn(N)
print("Converting")
floatlist = [x for x in darrayptr.contents]
lib_c.freeptr(darrayptr)



print("Done")


