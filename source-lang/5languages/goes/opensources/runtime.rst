runtime包
#########

尽管 Go 编译器产生的是本地可执行代码，这些代码仍旧运行在 Go 的 runtime（这部分的代码可以在 runtime 包中找到）当中。这个 runtime 类似 Java 和 .NET 语言所用到的虚拟机，它负责管理包括内存分配、垃圾回收（第 10.8 节）、栈处理、goroutine、channel、切片（slice）、map 和反射（reflection）等等。

runtime包含Go运行时的系统交互的操作，例如控制goruntine的功能。还有debug，pprof进行排查问题和运行时性能分析，tracer来抓取异常事件信息，如 goroutine的创建，加锁解锁状态，系统调用进入推出和锁定还有GC相关的事件，堆栈大小的改变以及进程的退出和开始事件等等；race进行竞态关系检查以及CGO的实现。总的来说运行时是调度器和GC，也是本文主要内容。


关于 runtime 包几个方法::

    Gosched：让当前线程让出 cpu 以让其它线程运行,它不会挂起当前线程，因此当前线程未来会继续执行
    NumCPU：返回当前系统的 CPU 核数量
    GOMAXPROCS：设置最大的可同时使用的 CPU 核数
    Goexit：退出当前 goroutine(但是defer语句会照常执行)
    NumGoroutine：返回正在执行和排队的任务总数
    GOOS：目标操作系统





