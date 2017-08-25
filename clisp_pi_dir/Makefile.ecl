# Set compiler here.
CLISP=ecl
CLOPTS=

pi.fas: pi.cl Makefile
	$(CLISP) $(CLOPTS) -compile pi.cl

run: pi.fas
	@$(CLISP) $(CLOPTS) -shell pi.fas $(PI_ARG)

clean:
	rm -f pi.fas pi.lib pi.o
