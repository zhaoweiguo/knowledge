.. _go_build:

go build命令
###################

usage::

    $ go build [-o output] [-i] [build flags] [packages]
    $ go help build


实例::

    $ go build      // 默认packages为当前目录
    $ go build flysnow.org/tools

    // 3个点表示匹配所有字符串，这样go build就会编译tools目录下的所有包
    $ go build flysnow.org/tools/...


选项ldflags
===========

格式::

    -ldflags '[pattern=]arg list'

说明::

    arguments to pass on each go tool link invocation.

app/config/vars.go::

    package config

    var Version string 

    var BuildTime string 

main.go::

    package main

    import (
        "fmt"
        "app/config"
    )

    func main() {
        fmt.Println("build.Version:\t", Version)
        fmt.Println("build.Time:\t", build.BuildTime)
    }

build::

    $ go build -ldflags "-X 'app/config.Version=0.0.1' -X 'app/config.BuildTime=$(date)'" main.go

run::

    $ ./app 
    Version:     0.0.1
    build.Time:  Sat Jul  4 19:49:19 UTC 2020

更多实例: `参见 <https://github.com/zhaoweiguo/demo-go/tree/master/pkg/basic4_flag/ldflags>`_


.. note:: ``-w``: turns off DWARF debugging information: you will not be able to use gdb on the binary to look at specific functions or set breakpoints or get stack traces, because all the metadata gdb needs will not be included. 

.. note:: ``-s``: turns off generation of the Go symbol table: you will not be able to use 'go tool nm' to list the symbols in the binary. Strip -s is like passing -s to -ldflags but it doesn't strip quite as much.


更多详情: :ref:`参见<go_tool_link>`



跨平台编译
==========

查看编译环境::

    ➜  ~ go env
    GOARCH="amd64"
    GOEXE=""
    GOHOSTARCH="amd64"
    GOHOSTOS="darwin"
    GOOS="darwin"
    GOROOT="/usr/local/go"
    GOTOOLDIR="/usr/local/go/pkg/tool/darwin_amd64"
    // 注意里面两个重要的环境变量GOOS和GOARCH

编译链工具::

    // 可以让我们在任何一个开发平台上，编译出其他平台的可执行文件
    GOOS=linux GOARCH=amd64 go build flysnow.org/hello

共享资源竞争检测
================

使用::

    $ go build -race

实例``cat main.go``::

    var (
        count int32
        wg    sync.WaitGroup
    )

    func main() {
        wg.Add(2)
        go incCount()
        go incCount()
        wg.Wait()
        fmt.Println(count)
    }

    func incCount() {
        defer wg.Done()
        for i := 0; i < 2; i++ {
            value := count
            runtime.Gosched()
            value++
            count = value
        }
    }

检测::

    $ go build -race
    $ ls
    main.go concurrency
    $ ./concurrency
    ==================
    WARNING: DATA RACE
    Read at 0x0000012282b8 by goroutine 8:
      main.incCount()
          /Users/zhaoweiguo/9tool/go/src/github.com/zhaoweiguo/demo-go/pkg/basic3/concurrency/demo1.go:34 +0x79

    Previous write at 0x0000012282b8 by goroutine 7:
      main.incCount()
          /Users/zhaoweiguo/9tool/go/src/github.com/zhaoweiguo/demo-go/pkg/basic3/concurrency/demo1.go:37 +0x98

    Goroutine 8 (running) created at:
      main.main()
          /Users/zhaoweiguo/9tool/go/src/github.com/zhaoweiguo/demo-go/pkg/basic3/concurrency/demo1.go:26 +0x77

    Goroutine 7 (finished) created at:
      main.main()
          /Users/zhaoweiguo/9tool/go/src/github.com/zhaoweiguo/demo-go/pkg/basic3/concurrency/demo1.go:25 +0x5f
    ==================
    4
    Found 1 data race(s)






