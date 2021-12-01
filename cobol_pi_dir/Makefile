# While I could work out how to get the current time, 
# I couldn't work out how to cleanly and reliably work 
# out time differences without it taking up more than half the file.

cobol_pi: Makefile cobol_pi.cbl
	cobc -g -x -debug cobol_pi.cbl

clean:
	-rm -f cobol_pi cobol_pi.c cobol_pi.h cobol_pi.l.h cobol_pi.c.h cobol_pi.c.l.h cobol_pi.i

.PHONY: clean

