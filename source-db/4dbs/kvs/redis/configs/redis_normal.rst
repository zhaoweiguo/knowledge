常用
#########################

约定::

   # 1k => 1000 bytes
   # 1kb => 1024 bytes
   # 1m => 1000000 bytes
   # 1mb => 1024*1024 bytes
   # 1g => 1000000000 bytes
   # 1gb => 1024*1024*1024 bytes


主要配置参数::

  daemonize
   是否以后台daemon方式运行(yes/no)

  pidfile
   pid文件位置

  port
   监听的端口号(default 6379)

  timeout
   请求超时时间(Close the connection after a client is idle for N seconds (0 to disable))

  loglevel
   log信息级别:
       debug (a lot of information, useful for development/testing)
       verbose (many rarely useful info, but not a mess like the debug level)
       notice (moderately verbose, what you want in production probably)
       warning (only very important / critical messages are logged)

  logfile
   log文件位置:
       stdout #往控制台写日志, 如果使用daemonize则往/dev/null写
       /var/redis/redis.log

  databases
   开启数据库的数量(默认使用数据库0, 你可以使用 ``SELECT <dbid>`` 命令选择指定数据库,其中<dbid>是从0到你設定的值)

  save <seconds> <changes>
   保存快照的频率,在一定时间内执行一定数量的写操作时,自动保存快照.可设置多个条件::

       save 900 1       # 900 sec (15 min)内至少1个key改变
       save 300 10      # 300 sec (5 min)内至少10个key改变
       save 60 10000    # 60 sec内至少10000个key改变
       # 注意: 如不想存入磁盘把所有的save注释即可

  rdbcompression
   可往磁盘保存数据时是否使用LZF压缩

  dbfilename
   数据快照文件名(文件名,不包括目录)

  dir
   数据快照的保存目录(目录)

  appendonly
   是否开启appendonlylog，开启的话每次写操作会记一条log，这会提高数据抗风险能力，但影响效率

  appendfsync
   appendonlylog如何同步到磁盘（三个选项，分别是每次写都强制调用fsync、每秒启用一次fsync、不调用fsync等待系统自己同步）

复制配置参数::

  slaveof <masterip> <masterport>
   指定master的ip与port(以下是解释，没大看明白):
       # Master-Slave replication. Use slaveof to make a Redis instance a copy of
       # another Redis server. Note that the configuration is local to the slave
       # so for example it is possible to configure the slave to save the DB with a
       # different interval, or to listen to another port, and so on.

  masterauth <master-password>
   指定master的密码(如果有的话, 密码的設定是通过requirepass)

  slave-serve-stale-data
   当slave与master失去连接时有两种处理方法:
       * yes: 让连接slave的客户端继续使用可能过时的数据(默认)
       * no: 给所有客户端返回 ``SYNC with master in progress`` 错误(除了 ``INFO`` and ``SLAVEOF`` 两个命令)

  repl-ping-slave-period
   Slaves send PINGs to server间隔时间(默认10s).

  repl-timeout
   The following option sets a timeout for both Bulk transfer I/O timeout and master data or ping response timeout(默认60s).
   注意: 确保这个值比 ``repl-ping-slave-period`` 設定的值大(原因自己想想)

  slave-priority
       The slave priority is an integer number published by Redis in the INFO output.
       # It is used by Redis Sentinel in order to select a slave to promote into a
       # master if the master is no longer working correctly.
       #
       # A slave with a low priority number is considered better for promotion, so
       # for instance if there are three slaves with priority 10, 100, 25 Sentinel will
       # pick the one wtih priority 10, that is the lowest.
       #
       # However a special priority of 0 marks the slave as not able to perform the
       # role of master, so a slave with priority of 0 will never be selected by
       # Redis Sentinel for promotion.
       #
       # By default the priority is 100.

次要配置参数::

  bind
   绑定ip

  unixsocket
   指定unix socket的路径

  unixsocketperm
   ???

  syslog-enabled
   控制是否使用系统日志??(yes/no)

  syslog-ident
   redis日志名

  syslog-facility
   指定日志facility.(Must be USER or between LOCAL0-LOCAL7)










