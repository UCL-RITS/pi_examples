help:
	@echo ''
	@echo 'make intel    Build with ifort.'
	@echo 'make nag      Build with nagfor.'
	@echo 'make gnu      Build with gfortran.'
	@echo 'make pgi      Build with pgfortran.'
	@echo ''

.DEFAULT:
	@test -f Makefile.$@
	$(MAKE) -f Makefile.$@

clean:
	rm -f *.o pi

.PHONY: clean, help

