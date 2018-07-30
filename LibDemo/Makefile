LIBFILE=foo
LIBO=$(LIBFILE).o
LIBSO=lib$(LIBFILE).so
LIBSRC=$(LIBFILE).cpp
EXE=hello
MAIN=main.cpp
GCC = icpc 


all: $(EXE)






$(EXE): $(MAIN) $(LIBSO) 
	#g++ -Wall -o $(EXE) $(MAIN) -L/$(PWD) -lfoo
	# USE RPATH
	$(GCC) -Wall -o $(EXE) $(MAIN) -Wl,-rpath=$(PWD) -L/$(PWD) -lfoo
	# USE RUNPATH
	#g++ -Wall -o $(EXE) $(MAIN) -Wl,-rpath=$(PWD), --enable-new-dtags -L/$(PWD) -lfoo
$(LIBSO): $(LIBO)
	$(GCC) -shared -o $(LIBSO) $(LIBO) -lstdc++ 

$(LIBO): $(LIBSRC)
	$(GCC) -c -Wall -Werror -fpic $(LIBSRC)

.PHONY: clean

clean:
	rm $(LIBO) $(LIBSO) $(EXE)

