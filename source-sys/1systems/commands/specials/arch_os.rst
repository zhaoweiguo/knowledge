*************
linux平台架构
*************

uname -a::

    // mac
    Darwin zhaowgMac 18.6.0 Darwin Kernel Version 18.6.0: Thu Apr 25 23:16:27 PDT 2019; root:xnu-4903.261.4~2/RELEASE_X86_64 x86_64

    // CentOS
    Linux myserver 3.10.0-957.21.3.el7.x86_64 #1 SMP Tue Jun 18 16:35:19 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

    // Debian
    Linux myserver 4.9.0-6-amd64 #1 SMP Debian 4.9.88-1 (2018-04-29) x86_64 GNU/Linux

uname -m::
    
    // mac
    x86_64
    // CentOS
    x86_64
    // Debian
    x86_64


arch::

    // mac
    i386
    // CentOS
    x86_64
    // Debian
    x86_64

file /bin/cat::

    // mac
    /bin/cat: Mach-O 64-bit executable x86_64
    // CentOS
    /bin/cat: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=8ac8b57ae50762a4a0480486839107e87b3c284d, stripped
    // Debian
    /bin/cat: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=8a5ac6fc8d1a22b34798b7896be48428086d5df1, stripped

/proc/cpuinfo::

    // 有几个物理处理器
    $ grep 'physical id' /proc/cpuinfo | sort | uniq | wc -l
    // 有几个虚拟处理器
    $ grep ^processor /proc/cpuinfo | wc -l

    注: mac下不适用














