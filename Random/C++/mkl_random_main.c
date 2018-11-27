#include <mkl.h>
#include <time.h>
#include <stdlib.h>



float * c_randn(int N) {
	srand(time(NULL));
	VSLStreamStatePtr stream1;
	vslNewStream(&stream1, VSL_BRNG_MCG31, rand());
	float* a = (float *)malloc(sizeof(float)*N);
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_BOXMULLER,stream1,N,a,0,1);
	return a;
}




int main(){
	int num = 1000000;
	float * array = c_randn(num);
	int i=0;
//	for(i=0; i < num; i++){
//	printf("%f\n",array[i]);
//	}
	printf("%f\n",array[4]);
	free(array);
}


