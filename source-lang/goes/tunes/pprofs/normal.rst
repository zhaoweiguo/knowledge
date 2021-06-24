常用
####

pprof 数据采样
==============

pprof 采样数据主要有三种获取方式::

    1. runtime/pprof: 
        工具型应用
        手动调用runtime.StartCPUProfile或者runtime.StopCPUProfile等 API来生成和写入采样文件，灵活性高
    2. net/http/pprof: 
        服务型应用
        通过 http 服务获取Profile采样文件，简单易用，适用于对应用程序的整体监控。通过 runtime/pprof 实现
    3. go test: 
        通过 go test -bench . -cpuprofile prof.cpu生成采样文件 适用对函数进行针对性测试

    // 其中net/http/pprof中只是使用runtime/pprof包来进行封装了一下，并在http端口上暴露出来





参考
====

* runtime/pprof: https://golang.org/pkg/runtime/pprof/
* http pprof 实现: https://github.com/golang/go/blob/release-branch.go1.9/src/net/http/pprof/pprof.go




