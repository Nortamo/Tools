
#include"memory_eater.hpp"

int main(){

	auto str = "10g";

	auto md = new MemoryEater(str);

	delete md;

	return 0;


}
