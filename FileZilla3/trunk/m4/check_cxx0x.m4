dnl Checks C++0x support, in particular we look for unordered_map

AC_DEFUN([CHECK_CXX0X], [
  
  AC_LANG_PUSH(C++)

  if test "X$GCC" = "Xyes"; then

    AC_MSG_CHECKING([whether compiler supports -std=C++0x])

    old_cxxflags="$CXXFLAGS"
    CXXFLAGS="$CXXFLAGS -std=c++0x"
 
    AC_COMPILE_IFELSE([
      AC_LANG_PROGRAM([[
      ]], [[
        return 0;
      ]])
    ], [
      AC_MSG_RESULT([yes])
    ], [
      AC_MSG_RESULT([no])
      CXXFLAGS=old_cxxflags
    ])
  fi

  AC_MSG_CHECKING([for whether we can include <unordered_map>])

  has_unordered_map=""
  AC_PREPROC_IFELSE([
      AC_LANG_PROGRAM([[
        #include <unordered_map>
      ]], [[
        return 0;
      ]])
    ], [
      has_unordered_map=std
      AC_MSG_RESULT([yes])
    ], [
      AC_MSG_RESULT([no])

      AC_MSG_CHECKING([for whether we can include <tr1/unordered_map>])

      AC_PREPROC_IFELSE([
          AC_LANG_PROGRAM([[
           #include <unordered_map>
        ]], [[
          return 0;
        ]])
      ], [
        has_unordered_map=tr1
        AC_MSG_RESULT([yes])
      ], [
        AC_MSG_FAILURE([No unordered_map implementation found.])
      ])
    ])

  AH_TEMPLATE(HAVE_TR1_UNORDERED_MAP, [Define HAVE_TR1_UNORDERED_MAP on systems where unordered_map is in tr1/ subdirectory.])
  if test "$has_unordered_map" = "std"; then
    AC_DEFINE(HAVE_TR1_UNORDERED_MAP)
  fi

  AC_LANG_POP(C++)

])


