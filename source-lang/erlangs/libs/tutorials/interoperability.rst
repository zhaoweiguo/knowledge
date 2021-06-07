interoperability [1]_
##############################



distributed Erlang and ports(linked-in drivers)


distributed Erlang::

  erlang manual page in ERTS (describes the BIFs)
  global manual page in Kernel
  net_adm manual page in Kernel
  pg2 manual page in Kernel
  rpc manual page in Kernel
  pool manual page in STDLIB
  slave manual page in STDLIB



When to use::

  Ports can be used for all kinds of interoperability situations where the Erlang program and the other program runs on the same machine. Programming is fairly straight-forward.
  open_port/2(erlang模块)

  Linked-in drivers involves writing certain call-back functions in C. This requires very good skills as the code is linked to the Erlang runtime system.
  erl_ddll模块

::

  open_port函数 ->  Ports       -> Erl_Interface
  erl_ddll函数  ->  port driver
  port driver + c node -> NIFs + c node

Ports:
''''''''''''

.. figure:: /images/languages/erlangs/doc_interoperability_port.gif
   :width: 80%


文件:port.c:

.. literalinclude:: /files/erlangs/doc_interoperability_port.c
   :language: c
   :linenos:

文件:complex1.erl:

.. literalinclude:: /files/erlangs/doc_interoperability_port.erl
   :language: erlang
   :linenos:

编译::

  unix> gcc -o extprg complex.c erl_comm.c port.c
  unix> erl
  1> c(complex1).
  {ok,complex1}

运行::

  2> complex1:start("./extprg").
  <0.34.0>
  3> complex1:foo(3).
  4
  4> complex1:bar(5).
  10
  5> complex1:stop().
  stop

Erl_Interface
''''''''''''''''''''
说明::

  基本同于Ports
  有以下2个不同点:
  1. As Erl_Interface operates on the Erlang external term format, the port must be set to use binaries.
  2. Instead of inventing an encoding/decoding scheme, the term_to_binary/1 and binary_to_term/1 BIFs are to be used.


代码::

  1.
  open_port({spawn, ExtPrg}, [{packet, 2}])
  =>
  open_port({spawn, ExtPrg}, [{packet, 2}, binary])

  2.
  Port ! {self(), {command, encode(Msg)}},
  receive
    {Port, {data, Data}} ->
      Caller ! {complex, decode(Data)}
  end
  =>
  Port ! {self(), {command, term_to_binary(Msg)}},
  receive
    {Port, {data, Data}} ->
      Caller ! {complex, binary_to_term(Data)}
  end



::

  for C Nodes
  Binary = term_to_binary(Term)
  Term = binary_to_term(Binary)

文件complex2.erl:

.. literalinclude:: /files/erlangs/doc_interoperability_erl_interface.erl
   :language: erlang
   :linenos:


文件:ei.c:

.. literalinclude:: /files/erlangs/doc_interoperability_erl_interface.c
   :language: erlang
   :linenos:

使用::

  % 未验证
  unix> gcc -o extprg -I/usr/local/otp/lib/erl_interface-3.9.2/include \\ 
      -L/usr/local/otp/lib/erl_interface-3.9.2/lib \\ 
      complex.c erl_comm.c ei.c -lerl_interface -lei -lpthread
  unix> erl
  1> c(complex2).
  {ok,complex2}
  2> complex2:start("./extprg").
  <0.34.0>
  3> complex2:foo(3).
  4
  4> complex2:bar(5).
  10
  5> complex2:bar(352).
  704
  6> complex2:stop().
  stop





Port Drivers
''''''''''''''''
说明::
  
  port driver是一种linked-in driver
  linked-in driver是作为Erlang程序的一部分被访问
  它是shared library (SO in UNIX, DLL in Windows)
  它是Erlang调用c代码最快的方式，同时也是最不安全的方式(port driver的崩溃会导致emulator挂掉)

.. figure:: /images/languages/erlangs/doc_interoperability_portdriver.gif
   :width: 80%

说明2::

  connected process: Erlang进程，所有的交流都通过此进程，终止此进程就关闭此port driver
  步骤:
  1.截入:通过函数erl_dll:load_driver/1: erl_ddll:load_driver(".", SharedLib)
  2.using the BIF open_port/2创建port:   Port = open_port({spawn, SharedLib}, [])
  3.

文件port_driver.c:

.. literalinclude:: /files/erlangs/doc_interoperability_portdriver.c
   :language: c
   :linenos:

文件complex5.erl:

.. literalinclude:: /files/erlangs/doc_interoperability_portdriver.erl
   :language: erlang
   :linenos:

使用::

  unix> gcc -o example_drv.so -fpic -shared complex.c port_driver.c
  windows> cl -LD -MD -Fe example_drv.dll complex.c port_driver.c
  > erl
  1> c(complex5).
  {ok,complex5}
  2> complex5:start("example_drv").
  <0.34.0>
  3> complex5:foo(3).
  4
  4> complex5:bar(5).
  10
  5> complex5:stop().
  stop



jinterface:
'''''''''''''''

  for Java Nodes

C Nodes: [2]_
''''''''''''''''''
说明::

  A C program that uses the Erl_Interface functions for setting up a connection to, and communicating with, a distributed Erlang node is called a C node, or a hidden node. 
  从Erlang的视觉看，C node就像是一个erlang进程: {RegName, Node} ! Msg

NIFs
''''''''
::

  Native Implemented Functions
  相比使用port drivers调用c node，NIFs是一种更有效、更简单的方式
  但也是最不安全的方式，因为NIF的崩溃会引起emulator挂掉
  适用于同步函数，用于做一些相对简单且没有副作用的计算

Erlang Program::

  1.The NIF library must be explicitly loaded by Erlang code in the same module.
  2.All NIFs of a module must have an Erlang implementation as well.

使用::

  erlang:load_nif/2



使用::

  unix> gcc -o complex6_nif.so -fpic -shared complex.c complex6_nif.c
  windows> cl -LD -MD -Fe complex6_nif.dll complex.c complex6_nif.c
  > erl
  1> c(complex6).
  {ok,complex6}
  3> complex6:foo(3).
  4
  4> complex6:bar(5).
  10
  5> complex6:foo("not an integer").
  ** exception error: bad argument
       in function  complex6:foo/1
          called as comlpex6:foo("not an integer")










.. [1] http://erlang.org/doc/tutorial/erl_interface.html
.. [2] http://erlang.org/doc/tutorial/cnode.html


