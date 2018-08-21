#include <stdio.h> 

int main() {
  int nDevices;
  cudaGetDeviceCount(&nDevices);
  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("Device Number: %d\n", i);
    printf("  Device name: %s\n", prop.name);
    printf("  Memory Clock Rate (KHz): %d\n",
           prop.memoryClockRate);
    printf("  Memory Bus Width (bits): %d\n",
           prop.memoryBusWidth);
    printf("  Peak Memory Bandwidth (GB/s): %f\n",
           2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6);
    printf("  pciBusID %d\n",prop.pciBusID);
    printf("  pciDeviceID %d\n",prop.pciDeviceID);
    printf("  Compute Capability: %d.%d\n",prop.major,prop.minor);
    printf("  totalGlobalMem:%zu\n",prop.totalGlobalMem);
    printf("  warpSize:%d\n",prop.warpSize);
    printf("  regsPerBlock:%d\n",prop.regsPerBlock);
    printf("  sharedMemPerBlock:%d\n",prop.sharedMemPerBlock);
  
  	printf("\n");
  }
}



