# Set compiler here.
RACO=raco
ROPTS=

pi: pi.rkt run.rkt Makefile
	$(RACO) $(ROPTS) exe -o pi run.rkt

run: pi
	@./pi $(PI_ARG)

clean:
	rm -f pi compiled
