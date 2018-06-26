#include"memory_eater.hpp"


float MemoryEater::parse(std::string input){

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




MemoryEater::MemoryEater(std::string m_input){
	total_memory = parse(m_input)/sizeof(int);
	allocate_memory();
	this->freed=false;

}
MemoryEater::~MemoryEater(){
	if(!freed){
	free_memory();
	freed=true;
	}

}

void MemoryEater::allocate_memory(){


	std::cout << "Using a minimum of " << this->total_memory*4 << " bytes" << std::endl; 	

	int block_size=1e9/(sizeof(int));

	float num_full_blocks = total_memory/block_size;

	int partial_block_memory =  (int)(this->total_memory - num_full_blocks*block_size);

	this->allocated_memory =0;


	this->arr = (int **)malloc((num_full_blocks+1) * sizeof(int *));
	if(arr == NULL){
		std::cout << "Failed allocating main array" <<std::endl;
	}


	if(partial_block_memory == 0){
		arr[0] = (int *)malloc(sizeof(int)*partial_block_memory); 


		if(arr[0]!= NULL )
		{	
			memset(arr[0],7,sizeof(int)*partial_block_memory);
			this->allocated_memory+=sizeof(int)*partial_block_memory;
			this->allocated.push_back(0);
		}
	}


	for (int i=1; i<num_full_blocks+1; i++){
		arr[i] = (int *)calloc(block_size,sizeof(int));
		if(arr[i] != NULL){
			memset(arr[i],5,block_size*sizeof(int));
			this->allocated.push_back(i);
			this->allocated_memory+=sizeof(int)*block_size;
		}
	}



	for(int i=0 ; i< num_full_blocks+1; i++){
		arr[i][0]=arr[0][0];
	}

	std::cout << "Allocated " <<this->allocated_memory << "Bytes of memory." << std::endl;

}

void MemoryEater::free_memory(){

	for(auto it = this->allocated.begin(); it != this->allocated.end(); it++){
		free(arr[*it]);    
	}


	free(arr);
	this->freed=true;



}

