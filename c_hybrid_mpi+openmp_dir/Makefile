CC=mpicc
EXEC=hybrid_pi
SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)
CFLAGS=-O3

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) -fopenmp -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) $(CFLAGS) -fopenmp -c $< -o $@

clean:
	rm -f $(EXEC) $(OBJECTS)
