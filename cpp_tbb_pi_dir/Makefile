EXEC=calculate_pi

$(EXEC): calculate_pi.o
	$(CXX) $(CXXFLAGS) -L$(TBBROOT)/lib/intel64/gcc4.8 -std=c++14 -tbb -o $(EXEC) calculate_pi.o

calculate_pi.o: calculate_pi.cpp timer.hpp 
	$(CXX) $(CXXFLAGS) -std=c++14 -tbb -c calculate_pi.cpp -o $@

clean:
	-rm -f $(EXEC) calculate_pi.o

