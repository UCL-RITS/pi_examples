help:
	@echo ''
	@echo 'make legion      Build for legion.'
	@echo 'make myriad      Build for myriad.'
	@echo 'make host        Build for CPU (single core).'
	@echo ''

.DEFAULT:
	@test -f Makefile.$@
	$(MAKE) -f Makefile.$@

clean:
	rm -f *.o pi pi.host

.PHONY: clean, help

