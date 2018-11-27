#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <random>
#include <chrono>

int main(){
	
unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();   
  
   /* Intializes random number generator */
   std::default_random_engine generator(seed); 
   std::normal_distribution<float> distribution(0,1.0);

	int N = 1000000;


	float* b = (float *) malloc(sizeof(float)*N);
	for(int i= 0; i < N;i++){
		b[i] = distribution(generator);
	}


	
	std::cout << b[6] << std::endl; 
	free(b);
}
