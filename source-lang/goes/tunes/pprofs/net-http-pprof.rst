net/http/pprof
##############

用法1-web服务::

    只需要引入包_ "net/http/pprof"
    然后就可以在浏览器中使用: http://localhost:port/debug/pprof/
    直接看到当前web服务的状态, 包括CPU占用情况和内存使用情况等


用法2-服务进程::

    也可以选择使用net/http/pprof包
    开启另外一个goroutine来开启端口监听
    比如:
    go func() {
        log.Println(http.ListenAndServe("localhost:6060", nil)) 
    }()


可通过 http://localhost:6060/debug/pprof/CMD 获取对应的采样数据。支持的 CMD 有::

    goroutine: 
        获取程序当前所有 goroutine 的堆栈信息
    heap: 
        包含每个 goroutine 分配大小，分配堆栈等
        每分配 runtime.MemProfileRate(默认为512K)个字节进行一次数据采样
    threadcreate: 
        获取导致创建 OS 线程的 goroutine 堆栈
    block: 
        获取导致阻塞的 goroutine 堆栈(如: channel, mutex等)
        使用前需要先调用 runtime.SetBlockProfileRate
    mutex: 
        获取导致 mutex 争用的 goroutine 堆栈
        使用前需要先调用 runtime.SetMutexProfileFraction

http://localhost:6060/debug/pprof/goroutine?debug=2::

    有相似的返回值(goroutine 堆栈)，它们都支持一个 debug URL参数
    1. 默认为0，此时返回的采样数据是不可人为解读的函数地址列表，需要结合 pprof 工具才能还原函数名字
    2. debug=1时，会将函数地址转换为函数名，即脱离 pprof 在浏览器中直接查看
    3. debug=2，此时将以 unrecovered panic 的格式打印堆栈，可读性更高

除此之外，go pprof 的 CMD 还包括::

    cmdline: 
        获取程序的命令行启动参数
    profile: 
        获取指定时间内(从请求时开始)的cpuprof，倒计时结束后自动返回
        参数: seconds, 默认值为30。cpuprofile 每秒钟采样100次，收集当前运行的 goroutine 堆栈信息
    symbol: 
        用于将地址列表转换为函数名列表，地址通过’+’分隔，
        如: URL/debug/pprof?0x18d067f+0x17933e7
    trace: 
        对应用程序进行执行追踪，参数: seconds, 默认值1s








