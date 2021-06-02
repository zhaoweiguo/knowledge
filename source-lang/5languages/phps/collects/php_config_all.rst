.. _php_configure_all:

php配置
=========

用法
""""""
::

    configure [options] [host]


配置项
"""""""""


::

  --cache-file=FILE       cache test results in FILE
  --help                  print this message
  --no-create             do not create output files
  --quiet, --silent       do not print `checking...' messages
  --version               print the version of autoconf that created configure

目录和文件名
""""""""""""""""
::

  --prefix=PREFIX         install architecture-independent files in PREFIX
                          [/usr/local]
  --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
                          [same as prefix]
  --bindir=DIR            user executables in DIR [EPREFIX/bin]
  --sbindir=DIR           system admin executables in DIR [EPREFIX/sbin]
  --libexecdir=DIR        program executables in DIR [EPREFIX/libexec]
  --datadir=DIR           read-only architecture-independent data in DIR
                          [PREFIX/share]
  --sysconfdir=DIR        read-only single-machine data in DIR [PREFIX/etc]
  --sharedstatedir=DIR    modifiable architecture-independent data in DIR
                          [PREFIX/com]
  --localstatedir=DIR     modifiable single-machine data in DIR [PREFIX/var]
  --libdir=DIR            object code libraries in DIR [EPREFIX/lib]
  --includedir=DIR        C header files in DIR [PREFIX/include]
  --oldincludedir=DIR     C header files for non-gcc in DIR [/usr/include]
  --infodir=DIR           info documentation in DIR [PREFIX/info]
  --mandir=DIR            man documentation in DIR [PREFIX/man]
  --srcdir=DIR            find the sources in DIR [configure dir or ..]
  --program-prefix=PREFIX prepend PREFIX to installed program names
  --program-suffix=SUFFIX append SUFFIX to installed program names
  --program-transform-name=PROGRAM
                          run sed PROGRAM on installed program names


Host type:
""""""""""""""
::

  --build=BUILD           configure for building on BUILD [BUILD=HOST]
  --host=HOST             configure for HOST [guessed]
  --target=TARGET         configure for TARGET [TARGET=HOST]


Features and packages:
"""""""""""""""""""""""""""
::

  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --x-includes=DIR        X include files are in DIR
  --x-libraries=DIR       X library files are in DIR


--enable and --with options recognized:
""""""""""""""""""""""""""""""""""""""""""
::

  --with-libdir=NAME      Look for libraries in .../NAME rather than .../lib
  --disable-rpath         Disable passing additional runtime library
                          search paths
  --enable-re2c-cgoto     Enable -g flag to re2c to use computed goto gcc extension


SAPI modules:
"""""""""""""""""""""""

.. literalinclude:: /files/phps/php_config_sapi.txt
   :linenos:

基本配置
""""""""""""""

.. literalinclude:: /files/phps/php_config_general_settings.txt
   :linenos:


扩展
"""""""""

.. literalinclude:: /files/phps/php_config_extensions.txt
   :linenos:

PEAR
"""""""
::

  --with-pear=DIR         Install PEAR in DIR [PREFIX/lib/php]
  --without-pear          Do not install PEAR


Zend:
""""""""
::

  --with-zend-vm=TYPE     Set virtual machine dispatch method. Type is
                          one of CALL, SWITCH or GOTO [TYPE=CALL]
  --enable-maintainer-zts Enable thread safety - for code maintainers only!!
  --disable-inline-optimization 
                          If building zend_execute.lo fails, try this switch
  --enable-zend-multibyte Compile with zend multibyte support

TSRM:
""""""""
::

  --with-tsrm-pth[=pth-config]
                          Use GNU Pth
  --with-tsrm-st          Use SGI's State Threads
  --with-tsrm-pthreads    Use POSIX threads (default)

Libtool:
""""""""""""
::

  --enable-shared[=PKGS]  build shared libraries [default=yes]
  --enable-static[=PKGS]  build static libraries [default=yes]
  --enable-fast-install[=PKGS]  optimize for fast installation [default=yes]
  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
  --disable-libtool-lock  avoid locking (might break parallel builds)
  --with-pic              try to use only PIC/non-PIC objects [default=use both]
  --with-tags[=TAGS]      include additional configurations [automatic]

  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
