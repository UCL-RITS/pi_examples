help:
	@echo ''
	@echo 'make pgi      Build with pgfortran.'
	@echo ''

.DEFAULT:
	@test -f Makefile.$@
	$(MAKE) -f Makefile.$@

clean:
	rm -f *.o pi

.PHONY: clean, help

