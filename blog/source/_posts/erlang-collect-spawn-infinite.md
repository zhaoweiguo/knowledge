---
title: Erlang不断spawn新进程会有什么现象
date: 2019-02-10 10:26:00
tags:
- erlang
- spawn
- collect
categories:
- erlang
---

### 前言

最近和同事聊天的时候，我突然想到进程Pid格式为<A1, A2, A3>，其中A1代表Node值, A2, A3则代表指定Node下的进程值，开始A3为0。当A2的值增加到一定数后, A3的值加1，那么问题来了:

```
    1. A2增加到多少，A3加1
    2. 如果A3的值也增加到这个值后会有什么情况出现呢?
```

### 问题1

源码:

```
    -module(spawn_loop_infinite2).
    -author("zhaoweiguo").

    %% API
    -export([loop/1]).
    -export([do_nothing/0]).
    -export([loop1/2]).

    loop(N) ->
        {ok, F} = file:open("aaa.txt", [append]),
        loop1(F, N).

    loop1(_F, 0) ->
        ok;
    loop1(F, N) ->
        Pid = spawn(spawn_loop_infinite, do_nothing, []),
        file:write(F, io_lib:format("[~p]:(~p)~n", [N, Pid])),
        loop1(F, N-1).

    do_nothing() ->
        ok.
```

执行命令:

```
    erl> spawn_loop_infinite2:loop(33000).
```

打开文件aaa.txt:
   
``` 
    [303]:(<0.32766.0>)
    [302]:(<0.32767.0>)
    [301]:(<0.0.1>)
    [300]:(<0.1.1>)
    [299]:(<0.2.1>)
```

结论:

    A2增加到32767，A3加1


### 问题2

源码:

```
    % 每次生成100万新进程，打印下一进程的pid，休息0.1秒后再生成100万新进程
    -module(spawn_loop_infinite).
    -author("zhaoweiguo").

    %% API
    -export([loop/2]).
    -export([do_nothing/0]).

    loop(N, N) ->
        io:format("stop~n");
    loop(M, N) ->
        Add = 32768*10,
        io:format("~p;", [N]),
        {ok, F} = file:open("fff"++ integer_to_list(N) ++".txt", [append]),
        loop1(Add, N, F),
        file:close(F),
        timer:sleep(10),
        loop(M, N+1).

    loop1(0, _N, _F) ->
        ok;
    loop1(Add, N, F) ->
        Pid = spawn(spawn_loop_infinite, do_nothing, []),
        file:write(F, io_lib:format("[~p]:(~p)~n", [Add, Pid])),
        loop1(Add-1, N, F).

    do_nothing() ->
        ok.
```

在文件fff820.txt中看到::

```
    [296800]:(<0.32762.8191>)
    [296799]:(<0.32763.8191>)
    [296798]:(<0.32764.8191>)
    [296797]:(<0.32765.8191>)
    [296796]:(<0.32766.8191>)
    [296795]:(<0.32767.7>)
    [296794]:(<0.5.0>)
    [296793]:(<0.7.0>)
    [296792]:(<0.11.0>)
    [296791]:(<0.8.0>)
    [296790]:(<0.17.0>)
    [296789]:(<0.16.0>)
    [296788]:(<0.24.0>)
    [296787]:(<0.6.0>)
    ...
    [296755]:(<0.72.0>)
    [296754]:(<0.73.0>)
    [296753]:(<0.74.0>)
    [296752]:(<0.75.0>)
    [296751]:(<0.76.0>)
    [296750]:(<0.77.0>)
    [296749]:(<0.78.0>)
```

结论:

```
    A3在增加到8191后就不再增加,改为使用已经回收的进程
    经过很短的混乱后又变的有序起来
    之后每一次A3+1都会先乱,再有序,并且乱的顺序都是对的
```

其他发现:

```
    % 有个有趣的发现, 在每次进程到达<0.32766.8191>后产生的下一个进程分别是:
    <0.32767.7>
    <0.32767.15>
    <0.32767.23>
    <0.32767.31>
    <0.32767.39>
    <0.32767.47>
```



