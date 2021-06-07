gen_tcp模块
=====================
.. _listen2:

accept/1/2
''''''''''''''''''''''''
用法::

  accept(ListenSocket, TimeOut) -> {ok, Socket} | {error, Reason}
  // ListenSocket 必须是由函数 gen_tcp:listen/2 建立返回
  // 该函数会引起进程阻塞，直到有一个连接请求发送到监听的套接字

返回值::

  {ok，Socket}: 连接已建立
  {error，closed}: ListenSocket 已经关闭
  {error，timeout}: 指定的时间内连接没有建立
  {error, system_limit}: Erlang 虚拟机里可用的端口都被使用了
  如果某些东西出错，也可能返回一个 POSIX 错误

close/1
''''''''''''''''''''
关闭一个 TCP 套接字

用法::

    gen_tcp:close(Socket) -> ok  


connect/3_4
'''''''''''''''''''''''
用法::

  connect(Address, Port, Options, Timeout) -> {ok, Socket} | {error, Reason}
  // 参数 Timeout 指定一个以毫秒为单位的超时值，默认值是 infinity

实例::

  gen_tcp:connect("localhost", Port, [{active, false}, {packet, 0}], 5000).

controlling_process/2
''''''''''''''''''''''''''''''''''''
改变一个套接字的控制进程

用法::

  gen_tcp:controlling_process(Socket, Pid) -> ok | {error, Reason}
  // 为 Socket 分配一个新的控制进程 Pid
  // 控制进程就是接收发自套接字消息数据的进程
  // 如果被当前控制进程以外的其他任何进程调用，则会返回 {error, not_owner} 的错误

实例::

  {Rand, _RandSeed} = random:uniform_s(9999, erlang:now()),
  Port = 40000 + Rand,
  case gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]) of
      {ok, Socket} ->
          gen_tcp:controlling_process(Socket, self());
      _ ->
          socket_listen_fail
  end.

listen/2
'''''''''''''''''''''''
使用方法::

  listen(Port, Options) -> {ok, ListenSocket} | {error, Reason}
  // 参数 Port 为 0，那么底层操作系统将赋值一个可用的端口号
  // 可以使用 inet:port/1 来获取一个 socket 监听的端口

参数 Options 的一些常用选项:

.. option:: {active,true}

    套接字设置为主动模式[默认]
    所有套接字接收到的消息都作为 Erlang 消息转发到拥有这个套接字进程上
    消息形式:
    {tcp, Socket, Data} | {tcp_closed, Socket}

.. option:: {active,false}

    设置套接字为被动模式
    套接字收到的消息被缓存起来,进程必须通过调用函数:
    gen_tcp:recv/2 或 gen_tcp:recv/3
    来读取这些消息:
    gen_tcp:recv(Socket, Length)  -> {ok, Data} | {error, Reason}
    
.. option:: {active,once}

    将设置套接字为主动模式，但是一旦收到第一条消息，就将其设置为被动模式
  
.. option:: {keepalive,true}

    当没有转移数据时，确保所连接的套接字发送保持活跃（keepalive）的消息。因为关闭套接字消息可能会丢失，如果没有接收到保持活跃消息的响应，那么该选项可确保这个套接字能被关闭。默认情况下，该标签是关闭的

.. option:: {nodelay,true}

    数据包直接发送到套接字，不管它多么小。在默认情况下，此选项处于关闭状态，并且与之相反，数据被聚集而以更大的数据块进行发送。
  
.. option:: {packet_size,Size}

    设置数据包允许的最大长度。如果数据包比 Size 还大，那么将认为这个数据包无效。

.. option:: {packet,PacketType}

    raw | 0::

        没有封包，即不管数据包头，而是根据Length参数接收数据,
        表示 Erlang 系统会把 TCP 数据原封不动地直接传送给应用程序

    1 | 2 | 4::

        表示包头的长度，分别是1,2,4个字节（2,4以大端字节序，无符号表示）
        当设置了此参数时，接收到数据后将自动剥离对应长度的头部，只保留Body

    asn1 | cdr | sunrm | fcgi | tpkt | line::

        设置以上参数时，应用程序将保证数据包头部的正确性
        但是在gen_tcp:recv/2,3接收到的数据包中并不剥离头部
        asn1 - ASN.1 BER, 
        sunrm - Sun's RPC encoding, 
        cdr - CORBA (GIOP 1.1), 
        fcgi - Fast CGI, 
        tpkt - TPKT format [RFC1006], 
        line - Line mode, a packet is a line terminated with newline, lines longer than the receive buffer are truncated.

    httph | httph_bin::

        设置以上参数，收到的数据将被erlang:decode_packet/3格式化
        在被动模式下将收到{ok, HttpPacket}
        主动模式下将收到{http, Socket, HttpPacket}.   


.. option:: {reuseaddr,true}

    允许本地重复使用端口号


.. option:: {delay_send,true}

    数据不是立即发送，而是存到发送队列里，等 socket 可写的时候再发送
 
.. option:: {backlog,1024}

    缓冲区的长度
  
.. option:: {exit_on_close,false}

    设置为 false，那么 socket 被关闭之后还能将缓冲区中的数据发送出去

.. option:: {send_timeout,15000}

    设置一个时间去等待操作系统发送数据，如果底层在这个时间段后还没发出数据，那么就会返回 {error,timeout}

recv/3
''''''''
用法::

  recv(Socket, Length, Timeout) -> {ok, Packet} | {error, Reason}
  //当 Socket 是 raw 模式下，参数 Length 才有意义的，并且 Length 表示接收字节的大小
  //如果 Length = 0，所有有效的字节数据都会被接收
  //如果 Length > 0，则只会接收 Length 长度的字节，或发生错误
  //当另一端 Socket 关闭时，接收的数据长度可能会小于 Length
  //选项 Timeout 是一个以毫秒为单位的超时值，默认值是 infinity。

实例::

  {Rand, _RandSeed} = random:uniform_s(9999, erlang:now()),
  Port = 40000 + Rand,
  case gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]) of
      {ok, ListenSocket} ->
          case gen_tcp:accept(ListenSocket) of
              {ok, Socket} ->
                  gen_tcp:recv(Socket, 0, 5000);
              {error, SocketAcceptFail} ->
                  SocketAcceptFail
          end;
      _ ->
          socket_listen_fail
  end.


send/2
'''''''''
在一个套接字 Socket 发送一个数据包

用法::

  send(Socket, Packet) -> ok | {error, Reason}


shutdown/2
'''''''''''''''
半关闭一个套接字
用法::

  shutdown(Socket, How) -> ok | {error, Reason}
  // How :: read | write | read_write
  // 如果参数How为write的形式,则套接字socket会关闭数据写入,读取仍可以正常执行
  // 参数 How 为 read，则反之
  // 要实现套接字半打开， 那么套接字要设置 {exit_on_close, false} 这个参数

实例::

  {Rand, _RandSeed} = random:uniform_s(9999, erlang:now()),
  Port = 40000 + Rand,
  case gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]) of
      {ok, ListenSocket} ->
          case gen_tcp:accept(ListenSocket, 1500) of
              {ok, Socket} ->
                  inet:setopts(Socket, [{exit_on_close, false}]),
                  gen_tcp:shutdown(Socket, write);
              {error, SocketAcceptFail} ->
                  SocketAcceptFail
          end;
      _ ->
          socket_listen_fail
  end.



实例
--------

.. literalinclude:: /files/erlangs/gen_tcp1.erl
   :language: erlang
   :linenos:

操作::

    C:\>erlc tcp_test.erl
    C:\>erl -s tcp_test start_server
    Eshell V5.10.2  (abort with ^G)

    1> tcp_test:start_client_packed().
    received message <<"1">>
    received message <<"2">>
    received message <<"3">>
    received message <<"4">>
    received message <<"5">>
    ok

    2> tcp_test:start_client_unpack().
    received message <<"12345">>
    ok


字节序
---------

字节序分为两类：Big-Endian和Little-Endian，定义如下::

    a) Little-Endian就是低位字节排放在内存的低地址端，高位字节排放在内存的高地址端。
    b) Big-Endian就是高位字节排放在内存的低地址端，低位字节排放在内存的高地址端。
    其实还有一种网络字节序，为TCP/IP各层协议定义的字节序，为Big-Endian。

packet包头是以大端字节序（big-endian）表示。如果erlang与其他语言，比如C++，就要注意字节序问题了。如果机器的字节序是小端字节序（little-endian），就要做转换::

    {packet, 2} ：[L1,L0 | Data]
    {packet, 4} ：[L3,L2,L1,L0 | Data]

如何判断机器的字节序，以C++为例::

  
  BOOL IsBigEndian()  
  {  
      int a = 0x1234;  
      char b =  *(char *)&a;  //通过将int强制类型转换成char单字节，通过判断起始存储位置  
      if( b == 0x12)  
      {  
          return TRUE;  
      }  
      return FALSE;  
  }

转换字节序，以C++为例::

    // 32位字数据
    #define LittletoBig32(A)   ((( (UINT)(A) & 0xff000000) >> 24) | \
      (( (UINT)(A) & 0x00ff0000) >> 8)   | \
      (( (UINT)(A) & 0x0000ff00) << 8)   | \
      (( (UINT)(A) & 0x000000ff) << 24))
     
    // 16位字数据
    #define LittletoBig16(A)   (( ((USHORT)(A) & 0xff00) >> 8)    | \
      (( (USHORT)(A) & 0x00ff) << 8))








