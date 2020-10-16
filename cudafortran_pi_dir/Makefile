EXEC=pi

FC=nvfortran

FOPT=-O2 -Minfo=accel

default: $(EXEC) pi_big pi_host

$(EXEC): pi.cuf Makefile
	$(FC) $(FOPT) -o $(EXEC) pi.f90

clean:
	rm -f *.o pi

.PHONY: default clean
