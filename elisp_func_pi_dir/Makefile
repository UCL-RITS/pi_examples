# Set compiler here.
EMACS=emacs
EMOPTS=-nsl -batch

elisp-pi.elc: elisp-pi.el Makefile
	$(EMACS) $(EMOPTS) -f batch-byte-compile elisp-pi.el

run: elisp-pi.elc
	@$(EMACS) $(EMOPTS) -Q -script elisp-pi.elc $(PI_ARG)

clean:
	rm -f elisp-pi.elc
