.. _csp:

并发模型-CSP
###############

* Communicating Sequential Processes
* 通信顺序进程，又翻译为交换消息的顺序程序，用来描述并发性系统的交互模式
* 早在上个世纪七十年代，多核处理器还是一个科研主题，并没有进入普通程序员的视野。 Tony Hoare 于 1977 年提出通信顺序进程（CSP）理论，遥遥领先与他所在的时代。



CSP有以下三个特点::

    1.每个程序是为了顺序执行而创建的
    2.数据通过管道来通信，而不是通过共享内存
    3.通过增加相同的程序来扩容
    // Golang的并发模型基于CSP理论，Golang并发的口号是：不用通过共享内存来通信，而是通过通信来共享内存

Golang并发模式支持并发的元素集::

    goroutines
    channels
    select
    sync package
    // 其中goroutines，channels和select 对应于实现CSP理论，即通过通信来共享内存
    // 这几乎能解决Golang并发的90%问题，另外的10%场景需要通过同步原语来解决，即sync包相关的结构


实现-GPM调试模型
================

GPM 代表了三个角色，分别是::

    1. Goroutine:
        用 go 关键字创建的执行体，它对应一个结构体 g，结构体里保存了 goroutine 的堆栈信息
    2. Processor
        表示处理器，有了它才能建立 G、M 的联系
    3. Machine
        表示操作系统的线程

Goroutine::

    Goroutine 就是代码中使用 go 关键词创建的执行单元，也是大家熟知的有 “轻量级线程” 之称的协程，
    协程是不为操作系统所知的，它由编程语言层面实现，上下文切换不需要经过内核态，
    再加上协程占用的内存空间极小，所以有着非常大的发展潜力。

Proccessor::

    负责 Machine 与 Goroutine 的连接，它能提供线程需要的上下文环境，也能分配 G 到它应该去的线程上执行
    处理器的数量也是默认按照 GOMAXPROCS 来设置的，与线程的数量一一对应

Machine::

    M 就是对应操作系统的线程，最多会有 GOMAXPROCS 个活跃线程能够正常运行，默认情况下 GOMAXPROCS 被设置为内核数，假如有四个内核，那么默认就创建四个线程，每一个线程对应一个 runtime.m 结构体。线程数等于 CPU 个数的原因是，每个线程分配到一个 CPU 上就不至于出现线程的上下文切换，可以保证系统开销降到最低。

    M 里面存了两个比较重要的东西，一个是 g0，一个是 curg:
        g0：会深度参与运行时的调度过程，比如 goroutine 的创建、内存分配等
        curg：代表当前正在线程上执行的 goroutine。


.. figure:: /images/languages/golangs/GPM.png

   Goroutine、Processor和Machine三者的关系











参考
====

* `Golang 高效实践之并发实践channel篇 <https://www.cnblogs.com/makelu/p/11205704.html>`_
* `【知乎】如何深入浅出地解释并发模型中的 CSP 模型？ <https://www.zhihu.com/question/26192499>`_
* `并发之痛 Thread，Goroutine，Actor <http://jolestar.com/parallel-programming-model-thread-goroutine-actor/>`_
* [掘金]Go 语言的 GPM 调度器是什么？: https://juejin.cn/post/6844904130398404616

