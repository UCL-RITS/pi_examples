CXX=nvc++
CXXFLAGS=-std=c++11 -O2 -acc -gpu=cc80 -Minfo=accel
EXEC=calculate_pi

$(EXEC): calculate_pi.o
	$(CXX) $(CXXFLAGS) -o $(EXEC) calculate_pi.o

calculate_pi.o: calculate_pi.cpp 
	$(CXX) $(CXXFLAGS) -c calculate_pi.cpp -o $@

clean:
	-rm -f $(EXEC) calculate_pi.o

