Emqtt配置vm相关
=======================


Erlang VM Arguments::

  ## SMP support: enable, auto, disable
  node.smp = auto

  ## Enable kernel poll
  node.kernel_poll = on
  
  ## async thread pool
  node.async_threads = 32
  
  ## Erlang Process Limit
  ## 【重要】
  ## 一个 MQTT 连接会消耗2个 Erlang 进程
  ## 所以参数值 > 最大连接数 * 2
  node.process_limit = 256000
  
  ## Sets the maximum number of simultaneously existing ports for this system
  ## 【重要】
  ## 一个 MQTT 连接消耗1个 Port
  ## 所以参数值 > 最大连接数
  node.max_ports = 65536
  
  ## Set the distribution buffer busy limit (dist_buf_busy_limit)
  node.dist_buffer_size = 32MB
  
  ## Max ETS Tables.
  ## Note that mnesia and SSL will create temporary ets tables.
  node.max_ets_tables = 256000
  
  ## Tweak GC to run more often
  node.fullsweep_after = 1000
  
  ## Crash dump
  node.crash_dump = log/crash.dump
  
  ## Distributed node ticktime
  node.dist_net_ticktime = 60
  
  ## Distributed node port range
  ## Erlang 分布节点间通信使用 TCP 连接端口范围
  ## 注: 节点间如有防火墙，需要配置该端口段
  ## node.dist_listen_min = 6000

  ## Erlang 分布节点间通信使用 TCP 连接端口范围
  ## 注: 节点间如有防火墙，需要配置该端口段
  ## node.dist_listen_max = 6999







