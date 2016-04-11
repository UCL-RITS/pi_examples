EXEC=calculate_pi

CC=icc
FC=ifort

COPT=-O3 -xT 
FOPT=-O3 -xT 

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

$(EXEC): $(OBJECTS)
	$(CC) -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) -c $< -o $@

clean:
	-rm -f $(EXEC) $(OBJECTS)

