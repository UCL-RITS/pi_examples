EXEC=pi

FC=ifort

# Note: if you put this up to -O3 you may get completely nonsensical time results
# Not sure why, might be an underflow problem?
FOPT=-O2 -xHost

$(EXEC): openmp_pi.f90
	$(FC) $(FOPT) -o $(EXEC) -fopenmp openmp_pi.f90


clean:
	rm -f *.o $(EXEC)

.PHONY: clean

