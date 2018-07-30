#include <stdio.h>
#include <stdlib.h>
#include <curand.h>
#include <curand_kernel.h>



#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}


__global__ void setup_kernel(curandState *state){

		  int idx = threadIdx.x+blockDim.x*blockIdx.x;
	  curand_init(1234, idx, 0, &state[idx]); 
}

__global__ void generate_random(curandState *my_curandstate,float* res,int elems_per_thread){
		  int idx = elems_per_thread*(threadIdx.x+blockDim.x*blockIdx.x);

		for(int j =0; j< elems_per_thread ; j++){
		res[idx+j]=curand_uniform(my_curandstate+idx);
		}
}



// multiply accumulate in b;
__global__
void myVeryChrunchyFunction(float* a,float* b, int elems_per_thread){
int i = elems_per_thread*(blockDim.x * blockIdx.x + threadIdx.x);	

	for(int j = 0; j<elems_per_thread; j++){
	int idx = i+j;
		b[idx]=a[idx]*b[idx];
	}

}


int main(void){

	int num_blocks =14;
	int num_threads_per_block=256;
	int elems_per_thread = 360;
	int num_elements = num_blocks*num_threads_per_block*elems_per_thread;

	float *host_array_b =(float *) malloc(num_elements*sizeof(float));
	float *device_array_a;
	float *device_array_b;
	
gpuErrchk(cudaMalloc(&device_array_a,num_elements*sizeof(float)));
gpuErrchk(cudaMalloc(&device_array_b,num_elements*sizeof(float)));
	   curandState *d_state;
gpuErrchk(cudaMalloc(&d_state, sizeof(curandState)*num_blocks*num_threads_per_block));
	
	

	setup_kernel<<<num_blocks,num_threads_per_block>>>(d_state);
	generate_random<<<num_blocks,num_threads_per_block>>>(d_state,device_array_a,elems_per_thread);
	generate_random<<<num_blocks,num_threads_per_block>>>(d_state,device_array_b,elems_per_thread);
	myVeryChrunchyFunction<<<num_blocks,num_threads_per_block>>>(device_array_a,device_array_b,elems_per_thread);
	
	cudaMemcpy(host_array_b,device_array_b,num_elements*sizeof(float),cudaMemcpyDeviceToHost);


	time_t t;
	srand((unsigned) time(&t));
	int index = rand() % num_elements;
	printf("Picking random element:\n\tlocation: %d \n\tvalue: %f\n",index,host_array_b[index]);

	cudaFree(device_array_a);
	free(host_array_b);
	cudaFree(device_array_b);
	cudaFree(d_state);

	return 0;

}

