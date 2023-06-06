CC = g++
TARGET = -target ipu2
POPC_FLAGS = -O3

all: pi

codelets.gp: codelets.cpp
	popc $(POPC_FLAGS) $^ -c -o codelets.o

codelets.ll: codelets.cpp
	popc $(POPC_FLAGS) --emit-llvm $(TARGET) $^ -o $@

codelets.S: codelets.cpp
	popc $(POPC_FLAGS) -S $(TARGET) $^ -o $@

pi: pi.cpp
	$(CC) -O3 -Wall --std=c++11 $< -o $@ -lpoplar

clean:
	rm -f codelets.gp codelets.ll codelets.S pi
