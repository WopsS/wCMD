GPP=g++ -m32

COMPILE_FLAGS = -c -O3 -w -fPIC -DLINUX -Wall -IwCMD/include/
LIBRARIES = -lm

compile:
	@mkdir -p bin
	@echo Compiling plugin ...
	@ $(GPP) $(COMPILE_FLAGS) -std=c++0x wCMD/*.cpp
	@echo Compiling AMX SDK ...
	@ $(GPP) $(COMPILE_FLAGS) wCMD/include/SDK/*.cpp
	
	@echo Linking wCMD ...
	@ $(GPP) -O2 -fshort-wchar -shared -o "bin/wCMD.so" *.o $(LIBRARIES)
	
	@ rm -f *.o
	@echo Done.

