# Customize maint.mk                           -*- makefile -*-
# Copyright (C) 2003-2010 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Used in maint.mk's web-manual rule
manual_title = gzip: the data compression program

# Tests not to run as part of "make distcheck".
local-checks-to-skip =		\
  sc_error_message_period	\
  sc_error_message_uppercase	\
  sc_m4_quote_check		\
  sc_obsolete_symbols		\
  sc_program_name		\
  sc_prohibit_S_IS_definition	\
  sc_prohibit_atoi_atof		\
  sc_prohibit_stat_st_blocks	\
  sc_space_tab			\
  sc_useless_cpp_parens


# Tools used to bootstrap this package, used for "announcement".
bootstrap-tools = autoconf,automake,gnulib

# Now that we have better tests, make this the default.
export VERBOSE = yes

old_NEWS_hash = e35901d8427a032d2b88a3195ed24a8f

sc_obs_header_regex = \
  \<(STDC_HEADERS|HAVE_(LIMITS|STRING|UNISTD|STDLIB)_H)\>
sc_prohibit_obsolete_HAVE_HEADER_H:
	@re='^[	 ]*#[	 ]*(el)?if.*$(sc_obs_header_regex)' \
	msg='remove the above obsolete #if...HAVE_HEADER_H test(s)' \
	  $(_prohibit_regexp)

update-copyright-env = \
  UPDATE_COPYRIGHT_USE_INTERVALS=1 \
  UPDATE_COPYRIGHT_MAX_LINE_LENGTH=79

# Indent only with spaces.
sc_prohibit_tab_based_indentation:
	@re='^ *	'						\
	msg='TAB in indentation; use only spaces'			\
	  $(_prohibit_regexp)

# Don't use "indent-tabs-mode: nil" anymore.  No longer needed.
sc_prohibit_emacs__indent_tabs_mode__setting:
	@re='^( *[*#] *)?indent-tabs-mode:'				\
	msg='use of emacs indent-tabs-mode: setting'			\
	  $(_prohibit_regexp)
