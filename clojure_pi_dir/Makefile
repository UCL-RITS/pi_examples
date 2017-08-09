# Set compiler here.
CLJC = clojurec
CLJ = clojure

all: tidy

run: all
	@$(CLJ) -cp pi.jar run.clj $(PI_ARG)

pi.jar: pi.clj Makefile
	$(CLJC) -cp . pi
	jar -cvf pi.jar *.class

tidy: pi.jar
	@rm -f *.class

clean: tidy
	rm -f pi.jar
