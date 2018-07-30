
all: transfer_test flops_test
	
transfer_test: transfer.cu
	nvcc -o transfer_test -Xptxas -O3  transfer.cu


run_transfer: transfer_test
	srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof --print-gpu-trace ./transfer_test

run_flops: flops_test
	 srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof ./flops_test

flops_test: flops.cu
	nvcc -Xptxas -O3 -o flops_test flops.cu

debug_ptx: flops.cu
	nvcc -Xptxas -O3  -ptx -o kernel.ptx  flops.cu

debug_binary: flops.cu
	cuobjdump  --dump-sass flops.cu   > cuda_obj_dump.out

clean:
	rm -f kernel.ptx cuda_obj_dump flops_test transfer_test
