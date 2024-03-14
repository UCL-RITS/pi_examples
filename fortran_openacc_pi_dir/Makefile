default: nvhpc

help:
	@echo ''
	@echo 'make legion      Build for legion.'
	@echo 'make myriad      Build for myriad.'
	@echo ''

.DEFAULT:
	@test -f Makefile.$@
	$(MAKE) -f Makefile.$@

clean:
	rm -f *.o pi pi_host pi_big

.PHONY: clean, help, default

