EXEC=calculate_pi

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

$(EXEC): $(OBJECTS)
	$(CC) -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) -c $< -o $@

clean:
	-rm -f $(EXEC) $(OBJECTS)

