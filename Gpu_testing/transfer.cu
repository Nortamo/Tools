#include <stdio.h>
#include <stdlib.h>


__global__
void add_one(int n, double *array,int updates_per_thread){
int i = blockDim.x * blockIdx.x + threadIdx.x;	



for( unsigned int j = i*updates_per_thread ; j < (i+1)*updates_per_thread; j++){

	if( j < n){
		array[j] += j;
	
	}
}

}
int main(void){
	
	double transfer_memory_size = 1e8;
	int num_elements = (transfer_memory_size/sizeof(double));
	double *host_array = (double*) malloc(sizeof(double)*num_elements); 
	double *device_array;
	cudaMalloc(&device_array,num_elements*sizeof(double));
	
	unsigned int i;
	for(  i = 0;  i < num_elements ; i++){
		host_array[i] = (double) i;
	}

	cudaMemcpy(device_array,host_array,num_elements*sizeof(double),cudaMemcpyHostToDevice);


	int gridsize = 5000;
	if(num_elements < gridsize*256){
		gridsize = (num_elements+255)/256;
	}
	



	int updates_per_thread = (num_elements+gridsize*256)/(gridsize*256);
	printf("Gridsize: %d\nNumber of elements: %d\nSpawned threads: %d\n", gridsize, num_elements,gridsize*256,updates_per_thread);
	add_one<<<gridsize,256>>>(num_elements,device_array,updates_per_thread);
	cudaMemcpy(host_array,device_array,num_elements*sizeof(double),cudaMemcpyDeviceToHost);


	time_t t;
	srand((unsigned) time(&t));
	int index = rand() % num_elements;
	printf("Picking random element:\n\tlocation: %d \n\tvalue: %f\n",index,host_array[index]);
	printf("Last element: %f\n", host_array[num_elements-1] );


	free(host_array);
	cudaFree(device_array);
}
