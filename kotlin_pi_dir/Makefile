KOTLINC = kotlinc

pi.jar: pi.kt Makefile
	$(KOTLINC) pi.kt -include-runtime -d pi.jar
	
clean:
	rm -f pi.jar
