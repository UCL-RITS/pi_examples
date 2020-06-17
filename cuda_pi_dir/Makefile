EXEC=calculate_pi

$(EXEC): calculate_pi.cu timer.hpp
	nvcc $(CXXFLAGS) -o $(EXEC) calculate_pi.cu

clean:
	rm -f $(EXEC) 

