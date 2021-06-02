.. _go_delve:

golang调试工具Delve
###################

* `gitlab <https://github.com/go-delve/delve>`_

安装::

    go get -u github.com/go-delve/delve/cmd/dlv

命令
====

说明::

    Delve is a source level debugger for Go programs.
    Delve enables you to interact with your program by 
        controlling the execution of the process,
        evaluating variables, 
        and providing information of thread / goroutine state, CPU register state and more.
    The goal of this tool is to provide a simple yet powerful interface for debugging Go programs.
    Pass flags to the program you are debugging using `--`, for example:
    `dlv exec ./hello -- server --config conf/config.toml`

用法::

    dlv [command]

Available Commands::

    attach    Attach to running process and begin debugging.
    connect   Connect to a headless debug server.
    core      Examine a core dump.
    debug     Compile and begin debugging main package in current directory,or the package specified.
    exec      Execute a precompiled binary, and begin a debug session.
    help      Help about any command
    run       Deprecated command. Use 'debug' instead.
    test      Compile test binary and begin debugging program.
    trace     Compile and begin tracing program.
    version   Prints version.

Flags::

      --accept-multiclient   Allows a headless server to accept multiple client connections.
      --api-version int      Selects API version when headless. (default 1)
      --backend string       Backend selection (see 'dlv help backend'). (default "default")
      --build-flags string   Build flags, to be passed to the compiler.
      --check-go-version     Checks that the version of Go in use is compatible with Delve. (default true)
      --headless             Run debug server only, in headless mode.
      --init string          Init file, executed by the terminal client.
    -l, --listen string      Debugging server listen address. (default "127.0.0.1:0")
      --log                  Enable debugging server logging.
      --log-dest string      Writes logs to the specified file or file descriptor (see 'dlv help log').
      --log-output string    Comma separated list of components that should produce debug output (see 'dlv help log')
      --wd string            Working directory for running the program. (default ".")

Additional help topics::

    dlv backend Help about the --backend flag.
    dlv log     Help about logging flags.



使用
====

::

    dlv debug ./main.go
    dlv> help           // 查看帮助命令
    dlv> b main.main    // 设置断点
    dlv> c              // 运行
    dlv> n              // 执行到下一行(Step Over)
    dlv> s              // 单步运行(Step Into)
    dlv> p <variable>   // 打印变量
    dlv> args           // 打印出所有的方法参数信息
    dlv> locals         // 打印所有的本地变量

    
The following commands are available::

    args ------------------------ Print function arguments.
    break (alias: b) ------------ Sets a breakpoint.
    breakpoints (alias: bp) ----- Print out info for active breakpoints.
    call ------------------------ Resumes process, injecting a function call (EXPERIMENTAL!!!)
    clear ----------------------- Deletes breakpoint.
    clearall -------------------- Deletes multiple breakpoints.
    condition (alias: cond) ----- Set breakpoint condition.
    config ---------------------- Changes configuration parameters.
    continue (alias: c) --------- Run until breakpoint or program termination.
    deferred -------------------- Executes command in the context of a deferred call.
    disassemble (alias: disass) - Disassembler.
    down ------------------------ Move the current frame down.
    edit (alias: ed) ------------ Open where you are in $DELVE_EDITOR or $EDITOR
    exit (alias: quit | q) ------ Exit the debugger.
    frame ----------------------- Set the current frame, or execute command on a different frame.
    funcs ----------------------- Print list of functions.
    goroutine (alias: gr) ------- Shows or changes current goroutine
    goroutines (alias: grs) ----- List program goroutines.
    help (alias: h) ------------- Prints the help message.
    libraries ------------------- List loaded dynamic libraries
    list (alias: ls | l) -------- Show source code.
    locals ---------------------- Print local variables.
    next (alias: n) ------------- Step over to next source line.
    on -------------------------- Executes a command when a breakpoint is hit.
    print (alias: p) ------------ Evaluate an expression.
    regs ------------------------ Print contents of CPU registers.
    restart (alias: r) ---------- Restart process.
    set ------------------------- Changes the value of a variable.
    source ---------------------- Executes a file containing a list of delve commands
    sources --------------------- Print list of source files.
    stack (alias: bt) ----------- Print stack trace.
    step (alias: s) ------------- Single step through program.
    step-instruction (alias: si)  Single step a single cpu instruction.
    stepout (alias: so) --------- Step out of the current function.
    thread (alias: tr) ---------- Switch to the specified thread.
    threads --------------------- Print out info for every traced thread.
    trace (alias: t) ------------ Set tracepoint.
    types ----------------------- Print list of types
    up -------------------------- Move the current frame up.
    vars ------------------------ Print package variables.
    whatis ---------------------- Prints type of an expression.

两种使用方法
============

源码调试::

    dlv debug ./main.go
    dlv>...

使用Delve附加到运行的golang服务进行调试::

    1. 编译运行:
    $ go build main.go
    $ ./main

    2. attach到项目中debug
    $ ps aux|grep main
    $ dlv attach 29260



实例
====

源码::

    package main

    import (
        "fmt"
        "log"
        "net/http"
        "os"
    )

    const port  = "8000"

    func main() {
        http.HandleFunc("/hi", hi)

        fmt.Println("runing on port: " + port)
        log.Fatal(http.ListenAndServe(":" + port, nil))
    }

    func hi(w http.ResponseWriter, r *http.Request) {
        hostName, _ := os.Hostname()
        fmt.Fprintf(w, "HostName: %s", hostName)
    }

使用::

    // 在指定一行加断点
    (dlv) b $GOROOT/src/github.com/zhaoweiguo/demo-go/github.com/derekparker/delve/example1/main.go:21

    > main.hi() ./main.go:21 (PC: 0x13316f2)
        16:         log.Fatal(http.ListenAndServe(":" + port, nil))
        17: }
        18: 
        19: func hi(w http.ResponseWriter, r *http.Request) {
        20:         hostName, _ := os.Hostname()
    =>  21:         fmt.Fprintf(w, "HostName: %s", hostName)
        22: }
    (dlv) locals
    hostName = "zhaowgMac"
    (dlv) p hostName
    "zhaowgMac"
    (dlv) args
    w = net/http.ResponseWriter(*net/http.response) 0xc000135968
    r = ("*net/http.Request")(0xc000160000)





* 参考: https://www.cnblogs.com/li-peng/p/8522592.html



