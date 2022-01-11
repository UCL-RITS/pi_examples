help:
	@echo ''
	@echo 'make nvhpc    Build with nvfortran.'
	@echo ''

.DEFAULT:
	@test -f Makefile.$@
	$(MAKE) -f Makefile.$@

clean:
	rm -f *.o pi

.PHONY: clean, help

