EXEC=calculate_pi

$(EXEC): calculate_pi.o
	$(CXX) -o $(EXEC) calculate_pi.o

calculate_pi.o: calculate_pi.cpp timer.hpp 
	$(CXX) -c calculate_pi.cpp -o $@

clean:
	-rm -f $(EXEC) calculate_pi.o

