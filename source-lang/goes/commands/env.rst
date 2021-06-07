.. _go_env:

go env命令
##########

格式::

    $ usage: go env [-json] [var ...]



一般环境变量
============

::

    $GOFILE:        当前处理中的文件名
    $GOLINE:        当前命令在文件中的行号
    $GOPACKAGE:     当前处理文件的包名
    $DOLLAR:        固定的"$"(不清楚用途)

    $GOARCH:        体系架构 (arm、amd64等待)
      The architecture, or processor, for which to compile code.
      Examples are amd64, 386, arm, ppc64.
    $GOOS:          OS环境(linux、windows等)
      The operating system for which to compile code.
      Examples are linux, darwin, windows, netbsd.

    GCCGO
      The gccgo command to run for 'go build -compiler=gccgo'.
    GOBIN
      The directory where 'go install' will install a command.
    GOCACHE
      The directory where the go command will store cached
      information for reuse in future builds.
    GODEBUG
      Enable various debugging facilities. See 'go doc runtime'
      for details.
    GOENV
      The location of the Go environment configuration file.
      Cannot be set using 'go env -w'.
    GOFLAGS
      A space-separated list of -flag=value settings to apply
      to go commands by default, when the given flag is known by
      the current command. Each entry must be a standalone flag.
      Because the entries are space-separated, flag values must
      not contain spaces. Flags listed on the command line
      are applied after this list and therefore override it.
    GOPATH
      For more details see: 'go help gopath'.
    GOPROXY
      URL of Go module proxy. See 'go help modules'.
    GOPRIVATE, GONOPROXY, GONOSUMDB
      Comma-separated list of glob patterns (in the syntax of Go's path.Match)
      of module path prefixes that should always be fetched directly
      or that should not be compared against the checksum database.
      See 'go help module-private'.
    GOROOT
      The root of the go tree.
    GOSUMDB
      The name of checksum database to use and optionally its public key and
      URL. See 'go help module-auth'.
    GOTMPDIR
      The directory where the go command will write
      temporary source files, packages, and binaries.

cgo用到的环境变量
=================

::

    AR
      The command to use to manipulate library archives when
      building with the gccgo compiler.
      The default is 'ar'.
    CC
      The command to use to compile C code.
    CGO_ENABLED
      Whether the cgo command is supported. Either 0 or 1.
    CGO_CFLAGS
      Flags that cgo will pass to the compiler when compiling
      C code.
    CGO_CFLAGS_ALLOW
      A regular expression specifying additional flags to allow
      to appear in #cgo CFLAGS source code directives.
      Does not apply to the CGO_CFLAGS environment variable.
    CGO_CFLAGS_DISALLOW
      A regular expression specifying flags that must be disallowed
      from appearing in #cgo CFLAGS source code directives.
      Does not apply to the CGO_CFLAGS environment variable.
    CGO_CPPFLAGS, CGO_CPPFLAGS_ALLOW, CGO_CPPFLAGS_DISALLOW
      Like CGO_CFLAGS, CGO_CFLAGS_ALLOW, and CGO_CFLAGS_DISALLOW,
      but for the C preprocessor.
    CGO_CXXFLAGS, CGO_CXXFLAGS_ALLOW, CGO_CXXFLAGS_DISALLOW
      Like CGO_CFLAGS, CGO_CFLAGS_ALLOW, and CGO_CFLAGS_DISALLOW,
      but for the C++ compiler.
    CGO_FFLAGS, CGO_FFLAGS_ALLOW, CGO_FFLAGS_DISALLOW
      Like CGO_CFLAGS, CGO_CFLAGS_ALLOW, and CGO_CFLAGS_DISALLOW,
      but for the Fortran compiler.
    CGO_LDFLAGS, CGO_LDFLAGS_ALLOW, CGO_LDFLAGS_DISALLOW
      Like CGO_CFLAGS, CGO_CFLAGS_ALLOW, and CGO_CFLAGS_DISALLOW,
      but for the linker.
    CXX
      The command to use to compile C++ code.
    FC
      The command to use to compile Fortran code.
    PKG_CONFIG
      Path to pkg-config tool.

Architecture-specific的环境变量
===============================

::

    GOARM
      For GOARCH=arm, the ARM architecture for which to compile.
      Valid values are 5, 6, 7.
    GO386
      For GOARCH=386, the floating point instruction set.
      Valid values are 387, sse2.
    GOMIPS
      For GOARCH=mips{,le}, whether to use floating point instructions.
      Valid values are hardfloat (default), softfloat.
    GOMIPS64
      For GOARCH=mips64{,le}, whether to use floating point instructions.
      Valid values are hardfloat (default), softfloat.
    GOWASM
      For GOARCH=wasm, comma-separated list of experimental WebAssembly features to use.
      Valid values are satconv, signext.

Special-purpose
===============

::

    GCCGOTOOLDIR
      If set, where to find gccgo tools, such as cgo.
      The default is based on how gccgo was configured.
    GOROOT_FINAL
      The root of the installed Go tree, when it is
      installed in a location other than where it is built.
      File names in stack traces are rewritten from GOROOT to
      GOROOT_FINAL.
    GO_EXTLINK_ENABLED
      Whether the linker should use external linking mode
      when using -linkmode=auto with code that uses cgo.
      Set to 0 to disable external linking mode, 1 to enable it.
    GIT_ALLOW_PROTOCOL
      Defined by Git. A colon-separated list of schemes that are allowed
      to be used with git fetch/clone. If set, any scheme not explicitly
      mentioned will be considered insecure by 'go get'.
      Because the variable is defined by Git, the default value cannot
      be set using 'go env -w'.

其他
====

::

    GOEXE
      The executable file name suffix (".exe" on Windows, "" on other systems).
    GOGCCFLAGS
      A space-separated list of arguments supplied to the CC command.
    GOHOSTARCH
      The architecture (GOARCH) of the Go toolchain binaries.
    GOHOSTOS
      The operating system (GOOS) of the Go toolchain binaries.
    GOMOD
      The absolute path to the go.mod of the main module,
      or the empty string if not using modules.
    GOTOOLDIR
      The directory where the go tools (compile, cover, doc, etc...) are installed.


GOOS指的是目标操作系统::

    darwin
    freebsd
    linux
    windows
    android
    dragonfly
    netbsd
    openbsd
    plan9
    solaris

GOARCH指的是目标处理器的架构，目前支持的有::

    arm
    arm64
    386
    amd64
    ppc64
    ppc64le
    mips64
    mips64le
    s390x






