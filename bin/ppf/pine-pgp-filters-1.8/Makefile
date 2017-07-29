# $Id: Makefile.in,v 1.7 2010/04/12 00:28:58 dougb Exp $

all:
	@mkdir -p $$PWD/out
	@for file in $$PWD/scripts/*; do \
		sed -e "s#\@\@PREFIX\@\@#/home/acobaugh/bin/#g" \
		    -e "s#\@\@GPG\@\@#/usr/bin/gpg2#g" \
		$${file} > $$PWD/out/$${file##*/}; \
	done

install: all
	@if [ ! -d /home/acobaugh/bin//libexec ]; then \
		install -d -m 755 /home/acobaugh/bin//libexec; \
	fi

	install -m 555 $$PWD/out/ppf_* /home/acobaugh/bin//libexec

	@if [ ! -d /home/acobaugh/bin//bin ]; then \
		install -d -m 755 /home/acobaugh/bin//bin; \
	fi

	ln -sf /home/acobaugh/bin//libexec/ppf_mime /home/acobaugh/bin//bin/ppf_mime
	ln -sf /home/acobaugh/bin//libexec/ppf_mime_decrypt /home/acobaugh/bin//bin/ppf_mime_decrypt

clean:
	@if [ -d "$$PWD/out" ]; then \
		rm -f $$PWD/out/*; \
		rmdir $$PWD/out; \
	fi

cleandir: clean
	@rm -f $$PWD/Makefile
