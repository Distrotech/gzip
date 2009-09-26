# Make gzip (GNU zip).

# Copyright (C) 1999, 2001-2002, 2006-2007, 2009 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

SUBDIRS = lib doc
ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -I$(top_srcdir)/lib

man_MANS = gunzip.1 gzexe.1 gzip.1 \
  zcat.1 zcmp.1 zdiff.1 zforce.1 zgrep.1 zless.1 zmore.1 znew.1

EXTRA_DIST = $(ACINCLUDE_INPUTS) $(man_MANS) \
  ChangeLog-2007 \
  tests/hufts-segv.gz \
  algorithm.doc amiga/match.a amiga/Makefile.gcc amiga/Makefile.sasc \
  amiga/tailor.c amiga/utime.h atari/Makefile.st crypt.h \
  gunzip.in gzexe.in gzip.doc gzip.h lzw.h msdos/match.asm msdos/tailor.c \
  msdos/gzip.prj msdos/doturboc.bat msdos/Makefile.msc msdos/Makefile.bor \
  msdos/Makefile.djg nt/Makefile.nt os2/gzip.def os2/Makefile.os2 \
  os2/gzip16.def primos/include/errno.h primos/include/fcntl.h \
  primos/include/stdlib.h primos/include/sysStat.h \
  primos/include/sysTypes.h primos/build.cpl primos/readme \
  primos/primos.c primos/ci.opts revision.h sample/makecrc.c \
  sample/ztouch sample/add.c sample/sub.c sample/zread.c sample/zfile \
  tailor.h vms/Makefile.mms vms/gzip.hlp vms/vms.c vms/Readme.vms \
  vms/Makefile.vms vms/Makefile.gcc vms/makegzip.com zcat.in zcmp.in zdiff.in \
  zegrep.in zfgrep.in zforce.in zgrep.in zless.in zmore.in znew.in

bin_PROGRAMS = gzip
bin_SCRIPTS = gunzip gzexe zcat zcmp zdiff \
  zegrep zfgrep zforce zgrep zless zmore znew
gzip_SOURCES = \
  bits.c crypt.c deflate.c gzip.c inflate.c lzw.c \
  trees.c unlzh.c unlzw.c unpack.c unzip.c util.c zip.c
gzip_LDADD = lib/libgzip.a

gzip.doc: gzip.1
	$(AM_V_GEN)groff -man -Tascii $(srcdir)/gzip.1 | col -b | uniq > $@-t \
	  && mv $@-t $@

gzip.doc.gz: gzip.doc $(bin_PROGRAMS)
	$(AM_V_GEN)./gzip < $(srcdir)/gzip.doc >$@-t && mv $@-t $@

SUFFIXES = .in
.in:
	$(AM_V_GEN)sed \
		-e 's|/bin/sh|$(SHELL)|g' \
		-e 's|[@]bindir@|'\''$(bindir)'\''|g' \
		-e 's|[@]VERSION@|$(VERSION)|g' \
		$(srcdir)/$@.in >$@-t \
	  && chmod a+x $@-t \
	  && mv $@-t $@

# Arrange so that .tarball-version appears only in the distribution
# tarball, and never in a checked-out repository.
dist-hook: gen-ChangeLog
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version

gen_start_date = 2008-01-01
.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog			\
	    --since=$(gen_start_date) > $(distdir)/cl-t;		\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

# A simple test, just of gzip -- more of a sanity check than anything else.
FILES_TO_CHECK = $(bin_SCRIPTS) $(gzip_LDADD) \
  $(top_srcdir)/ChangeLog $(top_srcdir)/configure $(top_srcdir)/gzip.c
check-local: $(FILES_TO_CHECK) $(bin_PROGRAMS) gzip.doc.gz
	{ test '$(srcdir)' != . || ./zdiff --__bindir . -c gzip.doc.gz; }
	./zdiff --__bindir . -c $(srcdir)/gzip.doc $(srcdir)/gzip.doc
	./zdiff --__bindir . $(srcdir)/gzip.doc gzip.doc.gz
	./zdiff --__bindir . -c - $(srcdir)/gzip.doc <gzip.doc.gz
	./zdiff --__bindir . -c gzip.doc.gz gzip.doc.gz
	./zgrep --__bindir . -iV >/dev/null
	for file in $(FILES_TO_CHECK); do \
	  ./gzip -cv -- "$$file" | ./gzip -d | cmp - "$$file" || exit 1; \
	done
	./gzip -dc $(srcdir)/tests/hufts-segv.gz > /dev/null 2>&1; \
	  test $$? = 1
	k=in-$$$$; printf a | ./gzip > $$k && \
	  test "`cat $$k | ./gzip -dc $$k - $$k`" = aaa && rm $$k
	@echo 'Test succeeded.'

install-exec-hook: remove-installed-links
install-exec-hook remove-installed-links:
	@for prog_ext in $(bin_PROGRAMS) $(bin_SCRIPTS); do \
	  prog=`echo "$$prog_ext"|sed 's/$(EXEEXT)$$//'`; \
	  case $$prog in \
	  gunzip) aliases='uncompress';; \
	  *) continue;; \
	  esac; \
	  transform='$(transform)'; \
	  test "X$$prog" = "X$$prog_ext" || \
	    transform="$$transform"';s/$$/$(EXEEXT)/'; \
	  destbindir=$(DESTDIR)$(bindir); \
	  source=`echo "$$prog"|sed "$$transform"`; \
	  for alias in $$aliases; do \
	    dest=`echo "$$alias"|sed "$$transform"`; \
	    (set -x; \
	     cd "$$destbindir" && \
	     rm -f "$$dest" && \
	     case $@ in \
	     install-exec-hook) \
	       ln "$$source" "$$dest" || $(LN_S) "$$source" "$$dest";; \
	     esac \
	    ) || exit; \
	  done; \
	done

uninstall-local: remove-installed-links

MAINTAINERCLEANFILES = gzip.doc

MOSTLYCLEANFILES = _match.i match_.s _match.S gzip.doc.gz \
  gunzip gzexe zcat zcmp zdiff zegrep zfgrep zforce zgrep zless zmore znew
