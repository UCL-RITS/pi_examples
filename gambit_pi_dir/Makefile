COMPILER=gsc
CC=gcc

COPTS=-O3

all: pi pi_nopts

pi: pi.c
	$(CC) $(COPTS) pi_.c pi.c -o pi -lgambc

pi_nopts: pi.c
	$(CC) pi_.c pi.c -o pi_nopts -lgambc

pi.c: pi.scm
	$(COMPILER) -link pi.scm

clean:
	rm -f pi*.c pi pi_nopts
