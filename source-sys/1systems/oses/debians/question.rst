常见问题
=============

64位ubuntu14.04运行32位程序::

  sudo dpkg --add-architecture i386
  sudo apt-get update
  sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
  sudo apt-get install libz1:i386


  [问]如何查询linux服务器是64位还是32位:

  32位的系统中int类型和long类型一般都是4字节, 64位的系统中int类型还是4字节的, 但是long已变成了8字节inux系统中可用"getconf WORD_BIT"和"getconf LONG_BIT"获得word和long的位数. 64位系统中应该分别得到32和64(getconf命令还可以获取系统的基本配置信息，比如操作系统位数，内存大小，磁盘大小等. ``$getconf -a`` 可以看到详细的系统信息):

    #getconf LONG_BIT
    #getconf WORD_BIT

  //X686或X86_64则内核是64位的，i686或i386则内核是32位的:
    #uname -a

  直接看看有没有/lib64目目录的方法。64位的系统会有/lib64和/lib两个目录，32位只有/lib一个
  以下命令:

    #file /sbin/init
    #file /bin/cat
    #uname -m
    #arch
    # echo $HOSTTYPE

  查看cpu是多少位的:
    #more /proc/cpuinfo


error: error creating symbolic link '/usr/share/man/man1/xxx' [1]_ ::

    在debian中安装软件时报上面错误，解决方法:
    $ mkdir -p /usr/share/man/man1






.. [1] https://github.com/ammaraskar/sphinx-action/issues/18