调试
######

日志输出
========

通过打印日志来调试问题，一般线上运行的系统使用此方法


GDB调试
=======

GDB是一款类Unix下的调试器，也可以使用GDB调试go程序::

    1. 编译出我们需要调试的程序
    // -N -l的标记是忽略编译器优化的意思，这样我们就可以更容易的调试程序
    $ go build -gcflags "-N -l" main.go

    2. 启动GDB
    $ gdb main

Delve调试
=========

Delve是一个专门为调试Go程序而生的调试工具，它比GDB更强大，尤其是调试多goroutine高并发的Go程序，更多参见 :ref:`go_delve`