#serial 2

# AC_PROG_SHELL
# -------------
# Check for a working (i.e. POSIX-compatible) shell.
# Written by Paul Eggert <eggert@twinsun.com>,
# from an idea suggested by Albert Chin-A-Young <china@thewrittenword.com>.
AC_DEFUN([AC_PROG_SHELL],
  [AC_MSG_CHECKING([for a POSIX-compliant shell])
   AC_CACHE_VAL(ac_cv_path_shell,
     [ac_command='
	# Test the noclobber option, using the portable POSIX.2 syntax.
	set -C
	rm -f conftest.c
	>conftest.c || exit
	>|conftest.c || exit
	!>conftest.c || exit
      '
      ac_cv_path_shell=no

      case $SHELL in
      /*)
	rm -f conftest.c
	if ("$SHELL" -c "$ac_command") 2>/dev/null; then
	  ac_cv_path_shell=$SHELL
	fi;;
      esac

      case $ac_cv_path_shell in
      no)
	ac_dummy=/bin:/usr/bin:/usr/bin/posix:/usr/xpg4/bin:$PATH
	ac_save_IFS=$IFS; IFS=:
	for ac_dir in $ac_dummy; do
	  for ac_base in sh bash ksh sh5; do
	    case $ac_dir in
	    /*)
	      rm -f conftest.c
	      if ("$ac_dir/$ac_base" -c "$ac_command") 2>/dev/null; then
		ac_cv_path_shell="$ac_dir/$ac_base"
		break
	      fi;;
	    esac
	  done
	  case $ac_cv_path_shell in
	  no) ;;
	  *) break;;
	  esac
	done
	rm -f conftest.c
	IFS=$ac_save_IFS;;
      esac])
   AC_MSG_RESULT($ac_cv_path_shell)
   SHELL=$ac_cv_path_shell
   if test "$SHELL" = no; then
     SHELL=/bin/sh
     AC_MSG_WARN([using $SHELL, even though it does not conform to POSIX])
   fi
   AC_SUBST(SHELL)])
