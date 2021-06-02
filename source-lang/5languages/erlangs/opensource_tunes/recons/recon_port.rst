recon port
##############


端口::

  erlang:port_info(Port, Key).  % 基本信息
  recon:port_info/1‐2
  % 1.元信息(meta)
  %   id: 端口的内部索引。除了用来区分端口外，没啥特殊用途
  %   name: 端口的类型——比如像”tcp_inet”、”udp_inet”或者”efile”之类的名字
  %   os_pid: 如果端口不是 inet socket，而是代表一个外部的进程或者程序
  %       那么这个值会包含和外部程序对应的 OS 进程的 pid
  % 2.信号(signals)
  %   connected: 每个端口都会有一个控制进程来对其负责，connected 指的就是这个进程的pid
  %   links: 端口可以和进程链接起来，方式和进程间的类似。links 包含的就是所链接进程的列表
  %     注: 如果端口曾经的 owner 并不多，或者没有被手工和许多进程链接在一起，这个调用应该是安全的
  %   monitors: 端口(代表外部程序)可以让外部程序监控 Erlang 进程
  % 3.IO(io)
  %   input 端口读入的字节数 
  %   output 写入端口的字节数
  % 4.内存使用(memory_used)
  %   memory 运行时系统为该端口分配的内存(单位为字节)。这个值会偏小，并没有包含端口自己分配的空间
  %   queue_size 端口程序有一个特殊的队列，称为驱动程序队列。这个调用会返回队列大小，单位为字节
  % 5.特定类型(type)
  %   Inet Ports: 返回inet特定的数据
  %     包括统计数据、socket(sockename)的本地地址和端口号以及使用的inet选项
  %   其他: 目前除了inet端口外，recon不支持其他类型的端口，会返回空列表

  例:
  erl> recon:port_info("#Port<0.818>").

  %操作步骤:
  1.先整体
  erl> recon:inet_count(oct, 3).
    [{#Port<0.241>,30,[{recv_oct,4},{send_oct,26}]},
     {#Port<0.238>,0,[{recv_oct,0},{send_oct,0}]}]
  % 参数:
  %   发送的字节数: send_oct
  %   接收的字节数: recv_oct
  %   收发的字节数: oct
  %   发送的包数: send_cnt
  %   接收的包数: recv_cnt
  %   收发的包数: cnt
  2.再细节
  erl> recon:port_info("#Port<0.241>").
  3.时间段
  erl> recon:inet_window(Attribute, Count, Milliseconds)
  例:
  erl> recon:inet_window(send_oct, 3, 5000).




