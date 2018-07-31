COMPILER=gsc
CC=gcc

COPTS=-O3

pi: pi.c
	$(CC) $(COPTS) pi_.c pi.c -o pi -lgambc

pi.c: pi.scm
	$(COMPILER) -link pi.scm

clean:
	rm -f pi*.c pi
