Service Discovery
##########################
实现自己的epmd module
::

  Erlang Port Mapper Daemon (EPMD)
  Erlang/OTP 21+

  inet_tcp_dist/inet_tls_dist调用epmd模块得到ip(通过DNS)和port(通过EPMD unix process)
  -epmd_module: 设定discovery module


discovery module要实现的回调函数::

  start_link/0
  启动发现模块的进程
  names/1
  返回指定host注册机保留的结点names
  register_node/2
  用注册机注册结点name
  port_please/3
  返回指定node的分布式port

可实现的回调函数::

  address_please/3
  返回given node的地址. 如没实现, 使用inet:gethostbyname/1方法替代

  此回调也可返回指定node的port，如此则可以忽略函数port_please/3










