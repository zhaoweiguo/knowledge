并发编程
########

基本
======

语法::

    go <fun>

管道chan定义::

    ch chan int   // 通道建立（var <chanName> chan <ElementType>）
    ch <- <data>  // 把数据传入管道
    <- ch         // 把管道里的数据传出

    ch := make(chan int)

    // 关闭channel
    close(ch)
    // 判断channel是否已正常关闭
    x, ok := <-ch

支持并发的元素集::

    goroutines
    channels
    select
    sync package
    // 其中goroutines，channels和select 对应于实现CSP理论，即通过通信来共享内存
    // 这几乎能解决Golang并发的90%问题，另外的10%场景需要通过同步原语来解决，即sync包相关的结构

* :ref:`共享资源竞争检测 <go_build>`

::

    runtime.NumCPU()        // 返回当前CPU内核数
    runtime.GOMAXPROCS(2)   // 设置运行时最大可执行CPU数
    runtime.NumGoroutine()  // 当前正在运行的goroutine 数
    runtime.Gosched()       // 用于让出CPU时间片


select语法
==========

基本::

    select {
        case <- ch:
            //如成功读取管道数据, 则执行
        case ch <- 1:
            // 如成功写入管道, 则执行
        default:
            // default
    }

超时-实例1::

    timeout := make(chan bool, 1)
    go func() {
        time.Sleep(1e9)   // 等待一秒
        timeout <- true
    }

    select {
        case <- ch:
            // 从ch取得数据
        case <- timeout:
            // 1秒后得到数据
    }

超时-实例2::

    var c <-chan int, duration time.Duration
    select {
        case data, isOK = <-c:
        　　return data, isOK, true
        case <- time.After(duration):
        　　return 0, true, false
    }

channel相关
===========

定义::

    A channel provides a mechanism for concurrently executing functions to communicate 
        by sending and receivingvalues of a specified element type. 
    The value of an uninitialized channel is nil.

关闭channel::

    c := make(chan int)
    close(c)
    fmt.Println(<-c) //接收并输出chan类型的零值，这里int是0 
    // channel不像socket或者文件，不需要通过close来释放资源
    // 需要close的唯一情况是，通过close触发channel读事件，comma，ok := <- c 中ok为false，表示channel已经关闭
    // 只能在发送端close channel，因为channel关闭接收端能感知到，但是发送端感知不到，只能主动关闭
    // 往已经关闭的channel发送信息将会触发panic

channel的传递::

    type PipeData struct {
        value int
        handle func(int) int
        next chan int
    }

    func handle(queue chan *PipeData) {
        for data := range queue {
            data.next <- data.handler(data.value)
        }
    }

单向channel::

    var ch1 chan int    // 正常chan
    var ch2 chan<- int  // 单写chan
    var ch3 <-chan int  // 单读chan
    原文说明:
    The optional <- operator specifies the channel direction, send or receive.
    If no direction is given, the channel isbidirectional.
    A channel may be constrained only to send or only to receive by conversion or assignment.
    实例:
    chan T // can be used to send and receive values of type T
    chan<- float64 // can only be used to send
    float64s <-chan int // can only be used to receive ints

Channel特点::

    1. goroutine safe
    2. store and pass value between goroutines
    3. provide FIFO semantics
    4. can cause goroutines block and unblock


Channel的缺点::

    1. Channel可能会导致死锁（循环阻塞）
    2. Channel中传递的都是数据的拷贝，可能会影响性能
    3. Channel中传递指针会导致数据竞态问题（data race/ race conditions）
    说明: data race 指的是多线程并发读写一个变量，对应到Golang中就是多个goroutine同时读写一个变量，
        这种行为是未定义的，也就是说读变量出来的值很有可能不是写入的值，这个值是任意值都有可能





sync同步
========

golang 中的 sync 包实现了两种锁::

    Mutex：互斥锁
    RWMutex：读写锁，RWMutex 基于 Mutex 实现

Mutex(互斥锁)::

    Mutex 为互斥锁，Lock() 加锁，Unlock() 解锁
    在一个 goroutine 获得 Mutex 后，其他 goroutine 只能等到这个 goroutine 释放该 Mutex
    使用 Lock() 加锁后，不能再继续对其加锁，直到利用 Unlock() 解锁后才能再加锁
    在 Lock() 之前使用 Unlock() 会导致 panic 异常
    已经锁定的 Mutex 并不与特定的 goroutine 相关联
    在同一个 goroutine 中的 Mutex 解锁之前再次进行加锁，会导致死锁
    适用于读写不确定，并且只有一个读或者写的场景

RWMutex(读写锁)::

    RWMutex 是单写多读锁，该锁可以加多个读锁或者一个写锁
    读锁占用的情况下会阻止写，不会阻止读，多个 goroutine 可以同时获取读锁
    写锁会阻止其他 goroutine(无论读和写)进来,整个锁由该 goroutine 独占
    适用于读多写少的场景

    Lock() 和 Unlock():
    Lock() 加写锁，Unlock() 解写锁
    如果在加写锁之前已经有其他的读锁和写锁，则 Lock() 会阻塞直到该锁可用
        为确保该锁可用，已经阻塞的 Lock() 调用会从获得的锁中排除新的读取器，
        即写锁权限高于读锁，有写锁时优先进行写锁定
    在 Lock() 之前使用 Unlock() 会导致 panic 异常

    RLock() 和 RUnlock():
    RLock() 加读锁，RUnlock() 解读锁
    RLock() 加读锁时，如果存在写锁，则无法加读锁；当只有读锁或者没有锁时，可以加读锁，读锁可以加载多个
    RUnlock() 解读锁，RUnlock() 撤销单次 RLock() 调用，对于其他同时存在的读锁则没有效果
    在没有读锁的情况下调用 RUnlock() 会导致 panic 错误
    RUnlock() 的个数不得多余 RLock()，否则会导致 panic 错误



::

    // 同步锁(sync.Mutex读锁, sync.RWMutex写锁)
    var l sync.Mutex

    // 全局唯一性操作
    var once sync.Once
    once.Do(<fun>)


缓冲机制
========

::

    chs := make(chan int, 1024)

    for i:= range chs {
        fmt.Print("Received:", i)
    }

不带buffer和带buffer的channel用途::

    不带buffer的channel：用于同步通信
    带buffer的channel：用于异步通信


趣味
====

.. figure:: /images/languages/golangs/cocurrence_chan1.png
   :alt: 看图识channel1
   :width: 70%
   :align: center

   看图识channel1


.. figure:: /images/languages/golangs/cocurrence_chan2.png
   :alt: 看图识channel2
   :width: 70%
   :align: center

   看图识channel2



相关
====

:ref:`CSP(Communicating Sequential Processes) <csp>`


参考
====

* https://www.cnblogs.com/makelu/p/11205704.html

