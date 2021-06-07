Erlang Trace
################

https://mryufeng.iteye.com/blog/113852
经常的时候看大型工程的时候 碰到一二个地方实在不明白他是如何运作的 这时候最好的工具就是debugger 如gdb，的backtrace 可以得到完整的函数调用栈。在linux下推荐使用ddd, 俺的centos5 下标准版本没有安装ddd 顺手下载个安装就好了（标准版本却个motif-devel yum下就好）。ddd图形界面方便查看函数和变量，还有点击跳转功能。 附上几个调试erlang的脚本，希望能够方便大家:

* first::

    [root@test98 ~]# cat gdb_beam
    #! /bin/bash
    ddd -x gdb.init /usr/local/lib/erlang/erts-5.5.5/bin/beam

* second::

    [root@test98 ~]# cat gdb.init
    set arg -- -root /usr/local/lib/erlang -progname erl -- -home /root

* third::

     [root@test98 ~]# tail .bash_profile -n 13

     export PATH=$PATH:/usr/local/lib/erlang/erts-5.5.5/bin
     ROOTDIR=/usr/local/lib/erlang
     BINDIR=$ROOTDIR/erts-5.5.5/bin
     EMU=beam
     PROGNAME=`echo $0 | sed 's/.*\///'`
     export EMU
     export ROOTDIR
     export BINDIR
     export PROGNAME
     export EDITOR=vim

     export LANG=utf8

如果你要调试 ``beam.smp beam.hybrid 可以erl -smp true +K true -emu_args`` 得到参数::

    Executing: /usr/local/lib/erlang/erts-5.5.5/bin/beam.smp 
    /usr/local/lib/erlang/erts-5.5.5/bin/beam.smp -K true -- -root 
    /usr/local/lib/erlang -progname erl -- -home /root -smp true

跟踪相关::

    • sys  comes standard with OTP and allows to set custom tracing functions, log all kinds of events, and so on. It’s generally complete and fine to use for development. It suffers a bit in production because it doesn’t redirect IO to remote shells, and doesn’t have rate-limiting capabilities for trace messages. It is still recommended to read the documentation
    for the module.
    • dbg  also comes standard with Erlang/OTP. Its interface is a bit clunky in terms of usability, but it’s entirely good enough to do what you need. The problem with it is that you have to know what you’re doing, because dbg can log absolutely everything on the node and kill one in under two seconds.
    • tracing BIFs are available as part of the erlang module. They’re mostly the raw blocks used by all the applications mentioned in this list, but their lower level of abstraction makes them rather difficult to use.
    • redbug  is a production-safe tracing library, part of the eper 5 suite. It has an internal rate-limiter, and a nice usable interface. To use it, you must however be willing to add in all of eper’s dependencies. The toolkit is fairly comprehensive and can be a very interesting install.
    • recon_trace  is recon’s take on tracing. The objective was to allow the same levels of safety as with redbug, but without the dependencies. The interface is different, and the rate-limiting options aren’t entirely identical. It can also only trace function calls, and not messages.
    • sys 是一个标准的OTP， 可以允许自 定义trace函数， 记录所有类型的事件等等。 它非常完善且可以很好地用于开发。 但它会稍微影响处于生产 环境的系统， 因为它没有把IO重定向到远程的shell中， 而且他没有限制trace消息的速度。 不过还是推荐阅读其文档模块。
    • dbg 也是一个标准的OTP。 它的接口在可用性方面显得有点笨拙。 但它完全足以满足你所需。 问 题在于： 你必须要知道你要做什么,因为 dbg可以记录一切， 并在2秒内把系统搞崩溃。
    • tracing BIFs作为一个Erang的模块可用。 它们大多作为原始块(the raw blocks)由这个列表中提到的application所调用,但由于他们处于较底层， 比较抽象， 用起来也非常困难。
    • redbug 是可以在正式的生产 运行系统中使用的trace库， 是eper 的一部分， 它内部有一个速度限制开关， 和一个不错
    的可用接口。 为了使用它， 你必须把eper的所有依赖项都加上。 这个工具箱非常全面， 你会体验到一次非常有趣的安装。
    • recon_trace 是recon中负 责trace的模块。 目 的是和redbug有相同的安全水平,但却不要这么多的依赖项。 接口也不一样， 速度限制选项并不完全相同。 它可以只trace指定的函数调用， 没有trace send/recv message （实际在使用OTP的application里面根本没有必要支持trace message这种机制）




