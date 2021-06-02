---
title: lager实战1:对lager测试来分析Erlang的一些特性
date: 2018-07-31 13:22:09
categories:
- tune
tags:
- erlang
- tune
- lager
---

### 目的
通过对lager进程数与打印日志数的不同组合的性能表现，分析lager在系统中对性能的影响

### 系统资源
一台服务器:

    16CPU
    64G内存

系统环境:

    OS: CentOS 7.4.1708
    $ cat /etc/security/limits.conf
    * soft nofile 300000
    * hard nofile 300000

<!--more-->


### 测试方案
总体说明:

    supervisor: 重启机制为simple_one_for_one
    启动命令: erl +P 1002400 ...


测试代码:

    F = fun(_Num,Acc)->
      supervisor:start_child(demo_lager_sup,[]),
      1+Acc
        end,
    // 这儿的N是变化的进程数
    lists:foldl(F,0,lists:seq(1,N)).

测试步骤:

    分别测试以下几类情形下的情况
    1.没有启动进程
    2.1万进程
    3.10万进程
    4.50万进程
    5.100万进程

常用命令::

    erlang:process_info(pid(0,346,0), message_queue_len).


### 操作1:100万进程, 普通gen_server

资源占用:

    系统占内存约70M
    2万进程:170M
    10万进程:520M
    50万进程:2.26G，用时70s
    100万进程:5.7G->4.6G

超出进程数时，报以下错误:

    Eshell V8.3.5.4  (abort with ^G)
    *** ERROR: Shell process terminated! ***

错误原因:

    需要增加最大并发进程数了


### 操作2:100万进程,每10秒请求一次lager
变动部分:

    增加:每秒每进程打印10次lager日志

关键代码:

    init([]) ->
      lager:info("client process start"),
      {ok, #state{},1000}.
    handle_info(_Info, State) ->
    F = fun(_)->
      lager:info("=======>> handle_info _Info = ~p",[_Info]),
    end,
    lists:foreach(F,lists:seq(1,10)),
    {noreply, State,1000}.


1万进程:

    从Erlang层面:
      1.内存: 281M, 200M; 一段时间后稳定在: 390M, 285M; 
      2.CPU: 一个CPU已经占满
      3.MsgQueue: 稳定在10000(短暂时间会消耗到8000)
    从系统层面:
      负载: 0.80, 0.53, 0.26
      CPU: 单cpu跑满,具体哪个CPU是变化的;短暂会出现1cpu75%,3-4cpu有5%-20%不等的占用
      内存: ->4G
    其他:
      这是不能再增加哪怕一个新进程(原因应该是MsgQueue导致)
      还不准确,大约6,7s后,1个新进程创建成功.测试了下,10个新进程大约需要1分钟

10万进程:

    重启后重新执行
    现象:
      进程新增到13958后,新增速度极其缓慢,大约12s新增1个
    Erlang层面:
      1.内存:557M, 430M(一直在很缓慢的增加)
      2.MsgQueue已经到了13000左右了
      3.Current Function固定在lager_event的{prim_file,drv_get_response,1}
    系统级别:
      负载: 1万进程相同
      CPU: 1万进程基本相同
      内存: 与1万进程相同
    日志写入速度:
      406秒写入了783600条日志
      每秒965条日志
    说明:
      没必要再继续测试50万、100万进程了
    磁盘:
    [root@idc-iot-pr-server-15 hello]# iostat -x -d -k 1 10 | grep vda
    Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
    vda               0.00     5.64    0.01   15.55     0.47   243.28    31.33     0.16   10.52   11.86   10.52   2.45   3.82
    vda               0.00     5.00    0.00    3.00     0.00    32.00    21.33     0.01    2.00    0.00    2.00   2.00   0.60
    vda               0.00     4.00    0.00    8.00     0.00    44.00    11.00     0.01    1.75    0.00    1.75   1.75   1.40
    vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
    vda               0.00     0.00    0.00  433.00     0.00 208300.00   962.12    40.45   93.42    0.00   93.42   0.84  36.50
    vda               0.00    28.00    0.00    4.00     0.00   132.00    66.00     0.06   15.50    0.00   15.50  15.50   6.20
    vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
    vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
    vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
    vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00


### 结论

暂封存,有点别的事忙,此事回头再议:

  When the high-water mark is exceeded, lager can be configured to flush all event notifications in the message queue. This can have unintended consequences for other handlers in the same event manager (in e.g. the error_logger'), as events they rely on may be wrongly discarded. By default, this behavior is enabled
  这也许是为啥MsgQueue能维持在9999










