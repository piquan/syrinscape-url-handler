PREFIX?=/usr/local

BUILDFILES=syrinscape-uri-handler.desktop
DISTFILES=copyright.txt Makefile README.md syrinscape-uri-handler syrinscape-uri-handler.1 syrinscape-uri-handler.desktop.in
INSTALL?=install -C

all: $(BUILDFILES)

%: %.in
	sed -e s%@PREFIX@%$(PREFIX)%g < $< > $@

clean distclean realclean:
	rm -f $(BUILDFILES)

ifeq ($(UPDATE_DESKTOP_DATABASE),no)
update-mime:
else
update-mime:
	update-desktop-database
endif

install-files: all
	$(INSTALL) -m755 -D -t $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler/ syrinscape-uri-handler
	$(INSTALL) -m644 -D -t $(DESTDIR)$(PREFIX)/share/man/man1/ syrinscape-uri-handler.1
	$(INSTALL) -m644 -D -t $(DESTDIR)$(PREFIX)/share/applications/ syrinscape-uri-handler.desktop

install: install-files update-mime

uninstall-files:
	rm -f $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler/syrinscape-uri-handler
	rmdir --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/syrinscape-uri-handler.1
	rm -f $(DESTDIR)$(PREFIX)/share/applications/syrinscape-uri-handler.desktop

uninstall: uninstall-files update-mime

dist:
	mkdir /tmp/syrinscape-uri-handler-0.0.1
	cp $(DISTFILES) /tmp/syrinscape-uri-handler-0.0.1
	tar cvzf syrinscape-uri-handler-0.0.1.tar.gz -C /tmp syrinscape-uri-handler-0.0.1
	rm -r /tmp/syrinscape-uri-handler-0.0.1
	mv syrinscape-uri-handler-0.0.1.tar.gz ../syrinscape-uri-handler_0.0.1.orig.tar.gz
