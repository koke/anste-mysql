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
	install -d src/data/images $(DESTDIR)$(DATADIR)/images
	install -m644 src/data/images/* $(DESTDIR)$(DATADIR)/images
	install -d $(DESTDIR)$(DATADIR)/scenarios
	cp -a src/data/scenarios/* $(DESTDIR)$(DATADIR)/scenarios
	install -d src/data/files $(DESTDIR)$(DATADIR)/files
	cp -a src/data/files/* $(DESTDIR)$(DATADIR)/files
	install -d $(DESTDIR)$(DATADIR)/scripts
	install -m755 src/data/scripts/* $(DESTDIR)$(DATADIR)/scripts
	install -d $(DESTDIR)$(DATADIR)/templates
	cp -a src/data/templates/* $(DESTDIR)$(DATADIR)/templates
	install -d $(DESTDIR)$(DATADIR)/tests
	cp -a src/data/tests/ebox $(DESTDIR)$(DATADIR)/tests
	cp -a src/data/tests/sample $(DESTDIR)$(DATADIR)/tests
