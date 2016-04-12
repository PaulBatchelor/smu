# libsmu - simple markup
# (c) 2007, 2008 Enno Boland

include config.mk

SRC    = smu.c
OBJ    = ${SRC:.c=.o}

all: options smutex

options:
	@echo smu build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

smutex: ${OBJ}
	@echo LD $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f smutex ${OBJ} ${LIBOBJ} smu-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p smu-${VERSION}
	@cp -R LICENSE Makefile config.mk smu.1 ${SRC} smu-${VERSION}
	@tar -cf smu-${VERSION}.tar smu-${VERSION}
	@gzip smu-${VERSION}.tar
	@rm -rf smu-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f smutex ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/smutex

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/smutex

.PHONY: all options clean dist install uninstall
