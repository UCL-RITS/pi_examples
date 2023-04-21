EXEC=pi

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) -lpthread -o $(EXEC) $(OBJECTS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	-rm -f $(EXEC) $(OBJECTS)

