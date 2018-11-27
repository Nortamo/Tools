# Very short asm program to test cpu-architecture (Sandy-bridge VS Haswell)
# If run on Sandy-bridge it will crash with Illegal instruction (core dumped) 
# If run on Haswell it will print Hello World

all: hello_fort hello_asm
	
hello_fort: hello.F90
	gfortran -o hello_fort  hello.F90	
hello_asm: hello.o
	ld -o hello_asm hello.o
hello.o: hello.s	
	as -a --gstabs -o hello.o hello.s
clean:
	rm -f hello.o hello_asm hello_fort 
