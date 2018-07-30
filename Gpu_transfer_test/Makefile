
all:  


transfer: transfer_test
	nvcc -o transfer_test -Xptxas -O3  transfer.cu


run: transfer
	srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof --print-gpu-trace ./transfer_test


