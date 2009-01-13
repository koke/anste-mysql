PREFIX = /usr/local
DATADIR = $(PREFIX)/share/anste
LIBDIR = $(PREFIX)/lib
SBINDIR = $(PREFIX)/sbin
BINDIR = $(PREFIX)/bin
VERSION = `cat VERSION`
EXPORT = anste-mysql-$(VERSION)

distclean:
	rm -rf $(EXPORT)
	rm -f anste-mysql-$(VERSION).tar.gz
	rm -f anste-mysql_$(VERSION)*
	rm -f *.deb

export:
	git archive --format=tar --prefix=$(EXPORT)/ master | tar x

dist: export
	tar cvvzf anste-mysql-$(VERSION).tar.gz $(EXPORT)

install:
	install -d $(DESTDIR)$(DATADIR)
	install -d images $(DESTDIR)$(DATADIR)/images
	install -m644 images/* $(DESTDIR)$(DATADIR)/images
	install -d $(DESTDIR)$(DATADIR)/scenarios
	cp -a scenarios/* $(DESTDIR)$(DATADIR)/scenarios
	install -d files $(DESTDIR)$(DATADIR)/files
	cp -a files/* $(DESTDIR)$(DATADIR)/files
	install -d $(DESTDIR)$(DATADIR)/scripts
	install -m755 scripts/* $(DESTDIR)$(DATADIR)/scripts
	install -d $(DESTDIR)$(DATADIR)/tests
	cp -a tests/mysql $(DESTDIR)$(DATADIR)/tests

pkg: dist
	cd $(EXPORT) &&	dpkg-buildpackage -rfakeroot -uc -us
