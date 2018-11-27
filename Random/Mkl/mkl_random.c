#include <mkl.h>
#include <time.h>
#include <stdlib.h>

void freeptr(void *ptr)
{
    free(ptr);
}



float * c_randn(int N) {
	srand(time(NULL));
	VSLStreamStatePtr stream1;
	vslNewStream(&stream1, VSL_BRNG_MCG31, rand());
	float* a = (float *)malloc(sizeof(float)*N);
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_BOXMULLER,stream1,N,a,0,1);
	return a;
}

void c_randn_numpy(int N,float * a){
	srand(time(NULL));
	VSLStreamStatePtr stream1;
	vslNewStream(&stream1, VSL_BRNG_MCG31, rand());
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_BOXMULLER,stream1,N,a,0,1);
}


