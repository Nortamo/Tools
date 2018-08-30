icc -c -fPIC -Wall -Werror -march=native -O3 mkl_random.c -mkl
icc -shared mkl_random.o  -o mkl_random.so -mkl
export LD_PRELOAD=/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_core.so:/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_sequential.so:/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_avx.so
	1) StdEnv   2) intel/16.0.3   3) mkl/11.3.3
