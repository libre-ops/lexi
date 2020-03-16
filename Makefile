install:
	-cp lexi /usr/local/bin/lexi
	-cp bash_completion /etc/bash_completion.d/lexi

uninstall:
	-rm /usr/local/bin/lexi
	-rm /etc/bash_completion.d/lexi

all: install

.PHONY: all
