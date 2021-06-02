Erlang临时
==================


help::

  $ erl -man lists
  http://www.erlang.org/community/mailinglists
  #erlang channel on irc.freenode.net

各类型大小比较顺序::

  number < atom < reference < fun < port < pid < tuple < list < bit string



收集::

  get('$ancestors')

进制::

  10> 2#101010.
  42
  11> 8#0677.
  447
  12> 16#AE.
  174


::

  Erlang 的 list 就是堆栈。它提供的 push 和 pop 操作具有 O(1)的复杂性，非常快，在各个方面都满足要求
  一般来讲，ETS 表每秒能处理的请求量要远高于进程，不过它们只能支持简单一些的操作。
  读一个值，原子地增加、减少一个计数器也就是最复杂的操作了




::

  process_flag(trap_exit, true)   % 如果进程没有trap_exit 的话，exit(Pid,Reason)就会直接关闭进程；如果设了trap_exit，进程不会被关闭，而是收到一条退出消息：{'EXIT', From, Reason} 
  % https://blog.csdn.net/mycwq/article/details/41172863

  net_kernel:monitor_nodes(true, [nodedown_reason]),  
  % 1.nodes()能看到的结点列表
  % 2.其他结点挂掉后，本结点能收到挂掉消息
  % http://www.erlang.org/doc/man/net_kernel.html#monitor_nodes-1 

  code:load_file(hcc_syn_data_schedule) % 加载文件

  is_process_alive(pid(0,92,0)).



::

  observer:start().

  erlang:get_cookie().

  //检测是否能ping通结点:
  net_adm:ping('b@localhost').
  // pang:
  // pong:

  //查看内存使用情况:
  memory().

  application:which_applications().







选项::

  +P 1002400
  erlang节点系统的最大并发进程数
  Sets the maximum number of simultaneously existing processes for this system if a Number is passed as value. Valid range for Number is [1024-134217727]

  NOTE: The actual maximum chosen may be much larger than the Number passed. Currently the runtime system often, but not always, chooses a value that is a power of 2. This might, however, be changed in the future. The actual value chosen can be checked by calling erlang:system_info(process_limit).

  The default value is 262144







命令行::

  erl -name octopus_2@test.com -mnesia extra_db_nodes "['octopus_1@test.com']" -s mnesia

调试::

  1 编译
  只有编译时加上debug_info的模块才能被调试
  在erlang shell中加上debug_info标志如下
  1>c(MODULE, debug_info).
  使用erlc的例子如下：
  erlc +debug_info ms.erl

  2. 启动
  调试器的启动可以通过debugger:start()或者im().
  启动可以悬着模式，默认是global模式即所有已知节点此模块

  3. 指定要调试模块
    默认是不会有调试的进程，只有指定哪些模块要调试，执行这些模块是，就能对执行此代码的进程进行调试，
    被指定为调试模块的过程被命名为interpreted module。
    通过菜单项Module->Interpret选择文件，没有debug信息的文件将提示失败，
    加载完成之后，就可以通过Module->MODULE->view查看源代码，在代码行双击即可设置断点。

  4. 调试
    当一个模块别标志为interpreted之后，我们在此模块代码设置断点，之后启动的进程都会进入调试状态。
    我们也可以通过菜单Process->Attach，attach到一个运行中的进程。

  5. 特殊情况
  我们使用otp的behavior时，我们自动模块都是一些call back, 
  正在运行otp behavior的代码，我们看到进程会处于idle状态。




  

::

  String = "[1,2,3].".
  {ok, Ts, _} = erl_scan:string(String).
  {ok, ListAST} = erl_parse:parse_exprs(Ts).

  {ok, Ts, _} = erl_scan:string(String).
  {ok, Term} = erl_parse:parse_term(Ts).
  ListAST = erl_syntax:abstract(Term).


  

erlang的beam模拟器:

    * beam   默认的
    * beam.smp               支持多处理器的
    * beam.hybrid            支持混合堆的



我们允许erl的时候 在linux下实际运行的是shell脚本::


    #!/bin/sh
    ROOTDIR=/usr/local/lib/erlang
    BINDIR=$ROOTDIR/erts-5.5.5/bin
    EMU=beam
    PROGNAME=`echo $0 | sed 's/.*\///'`
    export EMU
    export ROOTDIR
    export BINDIR
    export PROGNAME
    exec $BINDIR/erlexec ${1+"$@"}

这个脚本给erlexec 设置写必须的环境变量 具体调用那个模拟器是在erlexec里面根据 参数区分 -smp -hybrid来分别调用不同
的beam









