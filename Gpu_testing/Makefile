
all: transfer_test
	
transfer_test: transfer.cu
	nvcc -o transfer_test -Xptxas -O3  transfer.cu


run: transfer_test
	srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof --print-gpu-trace ./transfer_test


