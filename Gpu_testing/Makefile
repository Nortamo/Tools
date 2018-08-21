
all: transfer_test flops_test check_devices 
	
transfer_test: transfer.cu
	nvcc -o transfer_test -Xptxas -O3  transfer.cu


run_transfer: transfer_test
	srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof --print-gpu-trace ./transfer_test

run_flops: flops_test
	 srun -p gpu -t 00:01:00 --gres=gpu:p100:1 nvprof ./flops_test

flops_test: flops.cu
	nvcc -Xptxas -O3 -o flops_test flops.cu

check_devices: checkDevices.cu 
	nvcc checkDevices.cu 

kernel.ptx: flops.cu
	nvcc -Xptxas -O3  -ptx -o kernel.ptx  flops.cu

cuda_obj_dump:  flops_test
	cuobjdump  --dump-sass flops_test   > cuda_obj_dump

clean:
	rm -f kernel.ptx cuda_obj_dump flops_test transfer_test check_devices
