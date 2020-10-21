EXEC=pi

FC=nvfortran

FOPT=-O2 -Minfo=accel

default: $(EXEC) 

$(EXEC): pi.cuf Makefile
	$(FC) $(FOPT) -o $(EXEC) pi.cuf

clean:
	rm -f *.o pi

.PHONY: default clean
