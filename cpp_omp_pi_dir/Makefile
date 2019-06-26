EXEC=calculate_pi

$(EXEC): calculate_pi.o
	$(CXX) $(CXXFLAGS) -fopenmp -o $(EXEC) calculate_pi.o

calculate_pi.o: calculate_pi.cpp timer.hpp 
	$(CXX) $(CXXFLAGS) -fopenmp -c calculate_pi.cpp -o $@

clean:
	-rm -f $(EXEC) calculate_pi.o

