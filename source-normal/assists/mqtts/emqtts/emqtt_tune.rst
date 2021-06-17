Emqtt优化相关
====================
.. index:: tune, mqtt

:作者: 新溪-gordon <programfan.info#gmail.com>
:时间: 2018-07-03



EMQ 消息服务器1.x版本 MQTT 连接压力测试到130万，在一台8核心、32G内存的 CentOS 服务器上



Emqtt优化步骤
------------------

一、Linux Kernel Tuning::

  //The system-wide limit on max opened file handles:
  # 2M:系统所有进程可打开的文件数量
  sysctl -w fs.file-max=2097152
  sysctl -w fs.nr_open=2097152
  echo 2097152 > /proc/sys/fs/nr_open

  # 1M:系统允许当前进程打开的文件数量
  ulimit -n 1048576


  ## 上面临时操作，这儿是持久化的
  // 文件/etc/sysctl.conf
  fs.file-max = 1048576

  // 文件/etc/security/limits.conf
  *      soft   nofile      1048576
  *      hard   nofile      1048576

二、Network Tuning::

  //Increase number of incoming connections backlog::
  # backlog，Socket 监听队列长度
  sysctl -w net.core.somaxconn=32768
  sysctl -w net.ipv4.tcp_max_syn_backlog=16384
  sysctl -w net.core.netdev_max_backlog=16384

  //Local Port Range:
  # 可用知名端口范围
  sysctl -w net.ipv4.ip_local_port_range="1000 65535"

  // Read/Write Buffer for TCP connections:
  # TCP Socket 读写 Buffer 设置:
  sysctl -w net.core.rmem_default=262144
  sysctl -w net.core.wmem_default=262144
  sysctl -w net.core.rmem_max=16777216
  sysctl -w net.core.wmem_max=16777216
  sysctl -w net.core.optmem_max=16777216

  #sysctl -w net.ipv4.tcp_mem='16777216 16777216 16777216'
  sysctl -w net.ipv4.tcp_rmem='1024 4096 16777216'
  sysctl -w net.ipv4.tcp_wmem='1024 4096 16777216'

Connection Tracking::

  # TCP 连接追踪设置:
  sysctl -w net.nf_conntrack_max=1000000
  sysctl -w net.netfilter.nf_conntrack_max=1000000
  sysctl -w net.netfilter.nf_conntrack_tcp_timeout_time_wait=30

  // The TIME-WAIT Buckets Pool, Recycling and Reuse:
  # TIME-WAIT Socket 最大数量、回收与重用设置:
  sysctl -w net.ipv4.tcp_max_tw_buckets=1048576
  # 注意: 不建议开启該设置，NAT模式下可能引起连接RST
  # net.ipv4.tcp_tw_recycle = 1
  # net.ipv4.tcp_tw_reuse = 1

  // Timeout for FIN-WAIT-2 sockets:
  # FIN-WAIT-2 Socket 超时设置:
  sysctl -w net.ipv4.tcp_fin_timeout = 15

Erlang VM Tuning::

  # 优化设置 Erlang 虚拟机启动参数，配置文件 emqttd/etc/emq.conf:
  >> emqttd/etc/emq.conf:
  ## Erlang Process Limit（重要）
  ## Max number of Erlang proccesses. 
  ## A MQTT client consumes two proccesses. 
  ## The value should be larger than max_clients * 2
  node.process_limit = 2097152

  ## Sets the maximum number of simultaneously existing ports for this system（重要）
  ## Max number of Erlang Ports. A MQTT client consumes one port. The value should be larger than max_clients.
  node.max_ports = 1048576

The EMQ Broker(EMQ消息服务器参数)::

  // Tune the acceptor pool, max_clients limit and sockopts for TCP listener in etc/emqttd.config:
  ## TCP Listener
  # 设置 TCP 监听器的 Acceptor 池大小，最大允许连接数。配置文件 emqttd/etc/emq.conf:
  listener.tcp.external = 0.0.0.0:1883
  listener.tcp.external.acceptors = 64
  listener.tcp.external.max_clients = 1000000


Test Client（另一台专门测试的服务器）::

  sysctl -w net.ipv4.ip_local_port_range="500 65535"
  sysctl -w fs.file-max=1000000  # 注:这个在上面已经解释
  echo 1000000 > /proc/sys/fs/nr_open
  ulimit -n 100000


Benchmark使用
-------------------

并发连接测试工具: http://github.com/emqtt/emqtt_benchmark:

安装::

  make

emqtt_bench_sub的使用::

  // -c, --count: 最大client数量(最高60K)
  // -i, --interval: 连接broker的间隔,默认为10
  // -t, --topic
  // -q, --qos: 默认为0
  ./emqtt_bench_sub -h 10.140.2.6 -c 50000 -i 10 -t bench/%i -q 2

emqtt_bench_pub的使用::

  // -s, --size: payload size [default: 256]
  // -I, --interval_of_msg: 发布消息的间隔,默认为1000
  ./emqtt_bench_pub -h 10.140.2.6 -c 100 -I 10 -t bench/%i -s 256

认证相关::

  -u, --username     username for connecting to server
  -P, --password     password for connecting to server
  -k, --keepalive    keep alive in seconds [default: 300]
  -C, --clean        clean session [default: true]


Local interface::

  // --ifaddr: local ipaddress or interface address
  ./emqtt_bench_pub --ifaddr 192.168.1.10
  ./emqtt_bench_sub --ifaddr 192.168.2.10

One-way SSL Socket::

  // -h, --host[default: localhost]
  // -p, --port[default: 1883]
  ./emqtt_bench_sub -c 100 -i 10 -t bench/%i -p 8883 -S
  ./emqtt_bench_pub -c 100 -I 10 -t bench/%i -p 8883 -s 256 -S

Two-way SSL Socket::

  ./emqtt_bench_sub -c 100 -i 10 -t bench/%i -p 8883 --certfile path/to/client-cert.pem --keyfile path/to/client-key.pem
  ./emqtt_bench_pub -c 100 -i 10 -t bench/%i -s 256 -p 8883 --certfile path/to/client-cert.pem --keyfile path/to/client-key.pem










  
