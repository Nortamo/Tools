#include<stdlib.h>
#include<stdio.h>
#include<iostream>
#include<string>
#include<cstring>
#include<unistd.h>
#include<vector>

float parse_input( std::string input ){
	int len = input.length();
	float factor;
	float value;
	try{
		if(isdigit( input[len-1])){
			std::cout << "No prefix, assuming bytes" << std::endl;
			factor=1;
			value = std::stof(input.substr(0,len));
		}
		else{
			switch ( std::tolower(input[len-1])){
				case 'k':
					factor = 1e3;
					break;
				case 'm':
					factor = 1e6;
				      	break;
				case 'g':
					factor = 1e9;
				      	break;
				case 't':
					factor= 1e12;
					break;
				default:
				      std::cout << "Unrecoginzed prefix" << std::endl; 
			}
			
			value = std::stof(input.substr(0,len-1));
		}
	
		return factor*value;
	} catch(...){
		std::cout << "Error: argument is not a valid number\n";
		exit (EXIT_FAILURE);
	}

}




int main(int argc, char *argv[]) {
	std::cout << "Program to test memory allocation and restrictions\nAllocates memory in 1GB chunks\n---------------------------------\n"<< std::endl;
	
	
	float total_memory;
	
	switch (argc){
		case 1:
			std::cout << "Wrong number of arguments. Needed 1, got 0" << std::endl;
			return EXIT_FAILURE; 
		case 2:
			total_memory=parse_input(std::string(argv[1]))/sizeof(int);
			break;
		default:
			std::cout << "Wrong number of arguments. Needed 1 got" << argc-1 << std::endl;
			return EXIT_FAILURE; 

	}	

	std::cout << "Using a minimum of " << total_memory*4 << " bytes" << std::endl; 
	

	
 
	
	
	
	int block_size=1e9/(sizeof(int));

	float num_full_blocks = total_memory/block_size;

	int partial_block_memory =  (int)(total_memory - num_full_blocks*block_size);

	float allocated_memory =0;


    int **arr = (int **)malloc((num_full_blocks+1) * sizeof(int *));
    if(arr == NULL){
    	std::cout << "Failed allocating main array" <<std::cout;
    	return EXIT_FAILURE;
    }

	std::vector<int> memory_ok;
    arr[0] = (int *)malloc(sizeof(int)*partial_block_memory); 
    
    if(arr[0]!= NULL )
    {	
	memset(arr[0],7,sizeof(int)*partial_block_memory);
    	allocated_memory+=sizeof(int)*partial_block_memory;
    	this.allocated.push_back(0);
    }
    
    for (int i=1; i<num_full_blocks+1; i++){
         arr[i] = (int *)calloc(block_size,sizeof(int));
    if(arr[i] != NULL){
	 memset(arr[i],5,block_size*sizeof(int));
	this.allocated.push_back(i);
	allocated_memory+=sizeof(int)*block_size;
	 }
    }



	for(int i=0 ; i< num_full_blocks+1; i++){
	arr[i][0]=arr[0][0];
	}

	std::cout << "Allocated " << allocated_memory << "Bytes of memory." << std::endl;
	sleep(5);

    for(auto it = memory_ok.begin(); it != memory_ok.end(); it++){
    
         free(arr[*it]);    
    }


	free(arr);





	return EXIT_SUCCESS;
}
