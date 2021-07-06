单服务器高性能模式: Reactor&Proactor
####################################

.. note:: 应对高并发场景


Reactor
=======

I/O 多路复用技术归纳起来有两个关键实现点::

    1. 当多条连接共用一个阻塞对象后，进程只需要在一个阻塞对象上等待，而无须再轮询所有连接
        常见的实现方式有 select、epoll、kqueue 等。
    2. 当某条连接有新的数据可以处理时，操作系统会通知进程，进程从阻塞状态返回，开始进行业务处理

.. note:: I/O 多路复用结合线程池，完美地解决了 PPC 和 TPC 的问题，并为它取了一个很牛的名字：Reactor，中文是 “反应堆”。Reactor 模式也叫 Dispatcher 模式（在很多开源的系统里面会看到这个名称的类，其实就是实现 Reactor 模式的），更加贴近模式本身的含义，即 I/O 多路复用统一监听事件，收到事件后分配（Dispatch）给某个进程。

Reactor 模式的核心组成部分包括::

    Reactor 和处理资源池（进程池或线程池）
    其中 Reactor 负责监听和分配事件，处理资源池负责处理事件

Reactor 模式的具体实现方案灵活多变，主要体现在::

    1. Reactor 的数量可以变化
        可以是一个 Reactor，也可以是多个 Reactor
    2. 资源池的数量可以变化
        以进程为例，可以是单个进程，也可以是多个进程（线程类似）

Reactor 模式有这三种典型的实现方案::

    单 Reactor 单进程 / 线程
    单 Reactor 多线程
    多 Reactor 多进程 / 线程

    注: “多 Reactor 单进程” 实现方案相比 “单 Reactor 单进程” 方案，既复杂又没有性能优势

以上方案具体选择进程还是线程，更多地是和编程语言及平台相关::

    例如:
    Java 语言一般使用线程（例如，Netty），C 语言使用进程和线程都可以
    Nginx 使用进程，Memcache 使用线程

1. 单 Reactor 单进程 / 线程
---------------------------

.. note:: 单 Reactor 单进程的方案在实践中应用场景不多，只适用于业务处理非常快速的场景，目前比较著名的开源软件中使用单 Reactor 单进程的是 Redis

2. 单 Reactor 多线程
--------------------

单 Reator 多线程方案能够充分利用多核多 CPU 的处理能力，但同时也存在下面的问题::

    a. 多线程数据共享和访问比较复杂。
        例如，子线程完成业务处理后，要把结果传递给主线程的 Reactor 进行发送，这里涉及共享数据的互斥和保护机制。
        以 Java 的 NIO 为例:
          Selector 是线程安全的，但是通过 Selector.selectKeys () 返回的键的集合是非线程安全的
          对 selected keys 的处理必须单线程处理或者采取同步措施进行保护
    b. Reactor 承担所有事件的监听和响应，只在主线程中运行，瞬间高并发时会成为性能瓶颈


3. 多 Reactor 多进程 / 线程
---------------------------

多 Reactor 多进程 / 线程的方案看起来比单 Reactor 多线程要复杂，但实际实现时反而更加简单，主要原因是::

    a. 父进程和子进程的职责非常明确，父进程只负责接收新连接，子进程负责完成后续的业务处理
    b. 父进程和子进程的交互很简单，父进程只需要把新连接传给子进程，子进程无须返回数据
    c. 子进程之间是互相独立的，无须同步共享之类的处理
      （这里仅限于网络模型相关的 select、read、send 等无须同步共享，“业务处理” 还是有可能需要同步共享的）

.. note:: 目前著名的开源系统 Nginx 采用的是多 Reactor 多进程，采用多 Reactor 多线程的实现有 Memcache 和 Netty。


Proactor
========

Proactor 方案::

    1. Proactor Initiator 负责创建 Proactor 和 Handler
        并将 Proactor 和 Handler 都通过 Asynchronous Operation Processor 注册到内核
    2. Asynchronous Operation Processor 负责处理注册请求，并完成 I/O 操作
    3. Asynchronous Operation Processor 完成 I/O 操作后通知 Proactor
    4. Proactor 根据不同的事件类型回调不同的 Handler 进行业务处理
    5. Handler 完成业务处理，Handler 也可以注册新的 Handler 到内核进程


















