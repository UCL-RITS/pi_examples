EXEC=pi

FC=ifort

FOPT=-O2 -xHost

$(EXEC): pi.f90
	$(FC) $(FOPT) -o $(EXEC) pi.f90


clean:
	rm -f *.o $(EXEC)

.PHONY: clean

