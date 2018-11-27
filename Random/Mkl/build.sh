#!/bin/bash -l
module purge
module load intel
module load mkl
icc -c -fPIC -Wall -Werror -march=native -O3 mkl_random.c -mkl
icc  -shared mkl_random.o  -o mkl_random.so -mkl


module load python-env/3.5.3 
module load mkl 

export LD_PRELOAD=/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_core.so:/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_sequential.so:/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.3.210/linux/mkl/lib/intel64_lin/libmkl_avx.so
export LD_LIBRARY_PATH="/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.0.109/linux/compiler/lib/intel64_lin/:$LD_LIBRARY_PATH"
