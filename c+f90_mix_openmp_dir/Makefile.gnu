CC=gcc
FC=gfortran

COPT=-O3 
FOPT=-O3 -fopenmp

openmp_pi: openmp_pi.o pi_mytime.o
	$(FC) -o openmp_pi $(FOPT) openmp_pi.o pi_mytime.o

openmp_pi.o: openmp_pi.f90
	$(FC) $(FOPT) -c openmp_pi.f90

pi_mytime.o: pi_mytime.c
	$(CC) $(COPT) -c pi_mytime.c

clean:
	rm -f *.o openmp_pi
