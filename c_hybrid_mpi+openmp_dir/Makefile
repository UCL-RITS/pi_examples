CC=mpicc
EXEC=hybrid_pi
SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

$(EXEC): $(OBJECTS)
	$(CC) -fopenmp -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) -fopenmp -c $< -o $@

clean:
	rm -f $(EXEC) $(OBJECTS)
