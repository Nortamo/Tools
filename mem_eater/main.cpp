
#include"memory_eater.hpp"

int main(){

	auto str = "10g";

	MemoryEater me(str);

	me.free_memory();

	return 0;


}
