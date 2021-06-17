eBPF
####

eBPF (Extended Berkeley Packet Filter) 的核心是驻留在 kernel 的高效虚拟机。最初的目的是高效网络过滤框架，前身是 BPF，所以我们先了解下 BPF。


.. image:: /images/linuxs/linux_core_eBPF1.png

以上是 freebsd 的 BPF，Linux 中应该不叫这个，叫 `LSF <https://www.kernel.org/doc/Documentation/networking/filter.txt>`_


eBPF 初识
=========

Linux kernel 3.18 版本开始包含了 eBPF，相对于 BPF 做了一些重要改进，首先是效率，这要归功于 JIB 编译 eBPF 代码；其次是应用范围，从网络报文扩展到一般事件处理；最后不再使用 socket，使用 map 进行高效的数据存储。

目前 eBPF 可以分解为三个过程::

    1. 以字节码的形式创建 eBPF 的程序。
       编写 C 代码，将 LLVM 编译成驻留在 ELF 文件中的 eBPF 字节码
    2. 将程序加载到内核中，并创建必要的 eBPF-maps。
       eBPF 具有用作:
       socket filter，kprobe 处理器，流量控制调度，流量控制操作，
       tracepoint 处理，eXpress Data Path (XDP)，性能监测，
       cgroup 限制，轻量级 tunnel 的程序类型。
    3. 将加载的程序 attach 到系统中。
       根据不同的程序类型 attach 到不同的内核系统中。
       程序运行的时候，启动状态并且开始过滤，分析或者捕获信息。






进阶阅读
========

* https://zhaozhanxu.com/2018/04/01/Linux/2018-04-01-Linux-eBPF/
