Erlang OTP
======================
::

  supervisor 树中的子进程都按照顺序、以深度优先的方式启动


::

  {RestartStrategy, MaxR, MaxT}
  在最近的MaxT秒之内有超过MaxR次数的重启，则supervisor停止它本身和它所有的子进程
  
  one_for_one和simple_one_for_one策略适用于互相没有直接依赖关系的进程，不过
  它们的集体失败还是会导致整个application的shutdown
  rest_for_one:策略适用于具有线性依赖关系的进程,某子进程停止,启动顺序中在它之后的所有其他子进程也停止,然后重启这些停止进程
  one_for_all 策略适用于完全相互依赖的进程


::

  gen_server 会掌握一些资源，并且遵循 client‐server 模式（再一般化一点，就是request/response 模式）
  gen_fsm 会处理事件或者输入序列，并据此作出反应，就像一个有限状态机。一般会用来实现协议
  gen_event 会作为回调的事件聚合器，或者用来处理某种类型的通知

配置参数::

  description:
  vsn:
  modules:        本应用程序引入的所有模块
  registered:     本应用已注册进程的所有名称
  applications:   本应用依赖的所有应用



设计原则 [1]_
----------------

原始实现:
''''''''''''''

.. literalinclude:: /files/erlangs/otp_demo_ch1.erl
   :language: erlang
   :linenos:

OTP的plain模式实现:
'''''''''''''''''''''''
server端:

.. literalinclude:: /files/erlangs/otp_demo_server.erl
   :language: erlang
   :linenos:

实际实现:


.. literalinclude:: /files/erlangs/otp_demo_ch2.erl
   :language: erlang
   :linenos:

OTP真正实现:
''''''''''''''''''

.. literalinclude:: /files/erlangs/otp_demo_ch3.erl
   :language: erlang
   :linenos:


Distributed Applications
---------------------------------
不同的app运行在不同的node上，当运行着app1应用的node挂掉后，会在其他node重启此app1

配置::

  [{kernel,
    [{distributed, [{myapp, 5000, [cp1@cave, {cp2@cave, cp3@cave}]}]},
     {sync_nodes_mandatory, [cp2@cave, cp3@cave]},
     {sync_nodes_timeout, 5000}
    ]
   }
  ].

failover::

  运行此app的node挂掉，会在其他node上启动

takeover::

  运行此app的node负载重，会在其他node上启动

Releases
---------------

ch_rel-1.rel::

  {release,
     {"ch_rel", "A"},
     {erts, "8.3.5.4"},
     [
        {kernel, "5.2.0.1"},
        {stdlib, "3.3"},
        {sasl, "3.0.3"},
        {ch3, "0.1.0"}
     ]
  }.

执行::

  1> systools:make_script("ch_rel-1").
  % 在目录下能找到ch_rel-1.rel以及ch_rel-1.rel文件下的所有App.app文件
  % 生成以下2文件:
  % ch_rel-1.boot     % 二进制版
  % ch_rel-1.script   % 可读版

执行::

  % erl -boot ch_rel-1
  % 启动erlang并以下kernel,stdlib,sasl,ch_app

执行::

  2> systools:make_tar("ch_rel-1").
  % 生成ch_rel-1.tar.gz文件


Release Handling
-------------------------
Application Upgrade File::

  % ch.appup
  {"2",
     [{"1", [{load_module, ch3}]}],
     [{"1", [{load_module, ch3}]}]
  }.

Release Upgrade File::

  % ch_rel-2.rel
  {release,
     {"ch_rel", "B"},
     {erts, "8.3.5.4"},
     [
        {kernel, "5.2.0.1"},
        {stdlib, "3.3"},
        {sasl, "3.0.3"},
        {ch3, "0.2.0"}
     ]
  }.

执行::

  1> systools:make_relup("ch_rel-2", ["ch_rel-1"], ["ch_rel-1"]).
  ok
  1> systools:make_relup("ch_rel-2", ["ch_rel-1"], ["ch_rel-1"],
      [{path,["../ch_rel-1", "../ch_rel-1/lib/ch_app-1/ebin"]}]).
  ok
  % 生成文件relup

Installing a Release::

  release_handler:unpack_release(ReleaseName) => {ok, Vsn}
  % ReleaseName: 是release package->ReleaseName.tar.gz文件
  % Vsn: .rel文件中定义的unpacked release版本


  release_handler:install_release(Vsn) => {ok, FromVsn, []}
  % 

  release_handler:make_permanent(Vsn) => ok
  % 

  release_handler:remove_release(Vsn) => ok
  % 







.. [1] http://erlang.org/doc/design_principles/des_princ.html


