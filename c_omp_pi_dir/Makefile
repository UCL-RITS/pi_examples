EXEC=pi
COPTS=-O3 -fopenmp

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

$(EXEC): $(OBJECTS)
	$(CC) $(COPTS) $(CFLAGS) -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) $(COPTS) $(CFLAGS) -c $< -o $@

clean:
	-rm -f $(EXEC) $(OBJECTS)

