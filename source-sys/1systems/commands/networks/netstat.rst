.. _netstat:

netstat命令使用
######################

安装::

    yum install net-tools -y

基本用法::

    // debain用法
    netstat -nltp     // tcp
    netstat -nlup     // udp
    netstat -atunlp   // 全部

    netstat -anp tpc // freebsd用法

    netstat -anp | more   // centos


描述(linux)::

   --statistics , -s
       Display summary statistics for each protocol.

   --route , -r
       Display the kernel routing tables.

   --interface=iface , -i
       Display a table of all network interfaces, or the specified iface).

选项说明(linux)::

   --numeric , -n
       Show numerical addresses instead of trying to determine symbolic host, port or user names.
       不进行DNS解析

   -c, --continuous
       This will cause netstat to print the selected information every second continuously.

   -l, --listening
       Show only listening sockets.  (These are omitted by default.)
       仅显示监听套接字(LISTEN状态的套接字)

   -a, --all
       Show both listening and non-listening sockets.  
       With the --interfaces option, show interfaces that are not marked
       显示所有连接的端口

   -p, --program
       Show the PID and name of the program to which each socket belongs.
       显示进程标识符和程序名称，每一个套接字/端口都属于一个程序

   -u, --udp
      指明显示UDP端口
   -t, --tcp
      指明显示TCP端口

选项说明(mac)::

    -p protocol:
      Show statistics about protocol, 
        which is either a well-known name for a protocol or an alias for it.  
      Some protocol names and aliases are listed in the file /etc/protocols.


实例::


  netstat  网络连接状态

    netstat -nutlp | grep 3306
    or
    netstat -nutlp | grep mysql


    netstat -nlp        //查看系统当前监听的端口
    netstat -nap  // -p, --programs

    netstat -antup



实操
====

基本操作::

    netstat -anp | grep 8443 | wc -l
    netstat -anp | grep 8443 | grep -v ESTABLISHED | wc -l
    netstat -anp | grep 8443 | grep -v WAIT | wc -l

路由表相关操作(Mac)::

    # 查看当前路由表
    $> netstat -rn
    # 获取默认路由
    $> route get 0.0.0.0
    # 删除默认路由
    sudo route -n delete default 10.2.0.1
    # 添加公网网关
    sudo route add -net 0.0.0.0 10.2.0.1
    # 添加内网网关
    sudo route add -net 194.0.0.0 194.2.100.254


查看ddos情况::

    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr


查看php-fpm长连接情况::

    sh> netstat -nap |grep <port>    // 其中<port>为php请求的长连接服务端口
    tcp        0      0 192.168.35.141:48361    10.1.4.112:4230         TIME_WAIT   -               
    tcp        0      0 192.168.35.141:48358    10.1.4.112:4230         ESTABLISHED 6582/php-fpm: pool
    tcp        0      0 192.168.35.141:48357    10.1.4.112:4230         ESTABLISHED 6473/php-fpm: pool
    // 说明: 
    // 1. ESTABLISHED: 连接建立后没有释放
    // 2. TIME_WAIT: 连接关闭后释放资源的过程






