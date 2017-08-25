# Set compiler here.
CLISP=clisp
CLOPTS=

pi.fas: pi.cl Makefile
	$(CLISP) $(CLOPTS) -c pi.cl

run: pi.fas
	@$(CLISP) $(CLOPTS) pi.fas $(PI_ARG)

clean:
	rm -f pi.fas pi.lib pi.o
