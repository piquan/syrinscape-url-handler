PREFIX?=/usr/local

BUILDFILES=syrinscape-uri-handler.desktop
DISTFILES=copyright.txt Makefile README.md syrinscape-uri-handler syrinscape-uri-handler.1 syrinscape-uri-handler.desktop.in
INSTALL?=install -C

.PHONY: all
all: $(BUILDFILES)

%: %.in
	sed -e s%@PREFIX@%$(PREFIX)%g < $< > $@

.PHONY: clean distclean realclean
clean distclean realclean:
	rm -f $(BUILDFILES)

.PHONY: update-mime
ifeq ($(UPDATE_DESKTOP_DATABASE),no)
update-mime:
else
update-mime:
	update-desktop-database
endif

.PHONY: install-files
install-files: all
	$(INSTALL) -m755 -D -t $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler/ syrinscape-uri-handler
	$(INSTALL) -m644 -D -t $(DESTDIR)$(PREFIX)/share/man/man1/ syrinscape-uri-handler.1
	$(INSTALL) -m644 -D -t $(DESTDIR)$(PREFIX)/share/applications/ syrinscape-uri-handler.desktop

.PHONY: install
install: install-files update-mime

.PHONY: uninstall-files
uninstall-files:
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/syrinscape-uri-handler.1
	rm -f $(DESTDIR)$(PREFIX)/share/applications/syrinscape-uri-handler.desktop
	rm -f $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler/syrinscape-uri-handler
	rmdir --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/libexec/syrinscape-uri-handler

.PHONY: uninstall
uninstall: uninstall-files update-mime

.PHONY: dist
dist:
	mkdir /tmp/syrinscape-uri-handler-0.0.2
	cp $(DISTFILES) /tmp/syrinscape-uri-handler-0.0.2
	tar cvzf syrinscape-uri-handler-0.0.2.tar.gz --owner=root:0 --group=root:0 -C /tmp syrinscape-uri-handler-0.0.2
	rm -r /tmp/syrinscape-uri-handler-0.0.2
	mv syrinscape-uri-handler-0.0.2.tar.gz ../syrinscape-uri-handler_0.0.2.orig.tar.gz
