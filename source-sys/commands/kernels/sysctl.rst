.. index:: tune, linuxfile
.. _sysctl:

sysctl命令
#################


说明::

    sysctl设置和显示在/proc/sys目录中的内核参数
    可通过修改内核配置 ``/etc/sysctl.conf``

使用命令::

    sysctl [-n] [-e] -w variable=value  
    sysctl [-n] [-e] -p  (default /etc/sysctl.conf)  
    sysctl [-n] [-e] -a  

参数说明::

    -w   临时改动某个指定参数的值，如
        sysctl -w net.ipv4.ip_forward=1
    -a   显示所有的系统参数
    -p   从指定的文件加载系统参数，如不指定即从/etc/sysctl.conf中加载

实例(如想启用IP路由转发功能)::

    $> echo 1 > /proc/sys/net/ipv4/ip_forward
    $> sysctl -w net.ipv4.ip_forward=1
    // 说明:以上两命令功能相同


明确知道意义的::

    net.ipv4.ip_local_port_range(/proc/sys/net/ipv4/ip_local_port_range):
    端口范围.(默认32768    61000)

常见用法
==============

--system::

    $> sysctl --system
    从所有系统配置文件加载设置
    // 从上到下按给定顺序从以下列表中的目录中读取文件:
    /run/sysctl.d/*.conf
    /etc/sysctl.d/*.conf
    /usr/local/lib/sysctl.d/*.conf
    /usr/lib/sysctl.d/*.conf
    /lib/sysctl.d/*.conf
    /etc/sysctl.conf


其他
=======

配置说明::

    fs.file-max(默认1024): 整个系统所有可打开文件总数的限制, 可按256/4M内存计算值
    fs.nr_open(默认1048576): 单个进程可分配的最大文件数，所以在我们使用ulimit或limits.conf来设置时，如果要超过默认的1048576值时需要先增大nr_open值

    1.net.core.somaxconn(默认128): 表示socket监听（listen）的backlog上限.backlog就是socket的监听队列，当一个请求（request）尚未被处理或建立时，他会进入backlog.而socket server可以一次性处理backlog中的所有请求，处理后的请求不再位于监听队列中。当server处理请求较慢，以至于监听队列被填满后，新来的请求会被拒绝。
    对于一个TCP连接，Server与Client需要通过三次握手来建立网络连接.当三次握手成功后,
    我们可以看到端口的状态由LISTEN转变为ESTABLISHED,接着这条链路上就可以开始传送数据了.
 　　每一个处于监听(Listen)状态的端口,都有自己的监听队列.监听队列的长度,与如下两方面有关:
    - somaxconn参数.
    - 使用该端口的程序中listen()函数.
    2.net.ipv4.tcp_max_syn_backlog(默认1024): 表示SYN队列的长度,加大队列长度, 可以容纳更多等待连接的网络连接数.A tcp_max_syn_backlog variable sets how many half-open connections to backlog queue. 
    3.net.core.netdev_max_backlog(默认1000): 在每个网络接口接收数据包的速率比内核处理这些包的速率快时, number of incoming connections backlog. 允许送到队列的数据包的最大数目.net.core.netdev_max_backlog determines the maximum number of packets, queued on the INPUT side, when the interface receives packets faster than kernel can process them. 


    net.core.rmem_default(默认229376,224k): TCP数据接收窗口大小（字节）. Defines the default receive window size.
    net.core.rmem_max(默认131071,128k): 最大的TCP数据接收窗口（字节）.Defines the maximum receive window size.
    net.core.wmem_default(默认229376):默认的TCP数据发送窗口大小（字节）
    net.core.wmem_max(默认131071):最大的TCP数据发送窗口（字节）
    net.core.optmem_max(默认20480): 表示每个套接字所允许的最大缓冲区的大小

    net.ipv4.tcp_rmem(默认4096  87380  4011232):为自动调优定义socket使用的内存。第一个值是为socket接收缓冲区分配的最少字节数；第二个值是默认值（该值会被rmem_default覆盖），缓冲区在系统负载不重的情况下可以增长到这个值；第三个值是接收缓冲区空间的最大字节数（该值会被rmem_max覆盖）TCP Autotuning setting. "The first value tells the kernel the minimum receive buffer for each TCP connection, and this buffer is always allocated to a TCP socket, even under high pressure on the system. ... The second value specified tells the kernel the default receive buffer allocated for each TCP socket. This value overrides the /proc/sys/net/core/rmem_default value used by other protocols. ... The third and last value specified in this variable specifies the maximum receive buffer that can be allocated for a TCP socket." 

    net.ipv4.tcp_wmem(默认4096  16384  4011232):为自动调优定义socket使用的内存。第一个值是为socket发送缓冲区分配的最少字节数；第二个值是默认值（该值会被wmem_default覆盖），缓冲区在系统负载不重的情况下可以增长到这个值；第三个值是发送缓冲区空间的最大字节数（该值会被wmem_max覆盖）TCP Autotuning setting. "This variable takes 3 different values which holds information on how much TCP sendbuffer memory space each TCP socket has to use. Every TCP socket has this much buffer space to use before the buffer is filled up. Each of the three values are used under different conditions. ... The first value in this variable tells the minimum TCP send buffer space available for a single TCP socket. ... The second value in the variable tells us the default buffer space allowed for a single TCP socket to use. ... The third value tells the kernel the maximum TCP send buffer space." 

    net.nf_conntrack_max(默认65536): 当nf_conntrack模块被装置且服务器上连接超过这个设定的值时，系统会主动丢掉新连接包，直到连接小于此设置值才会恢复
    net.netfilter.nf_conntrack_max(默认65536): 如果你的机器是一个64GB 64bit的系统，那么最合适的值是 CONNTRACK_MAX = 64*1024*1024*1024/16384/2 = 2097152。哈希表一般是net.netfilter.nf_conntrack_max的1/8。
    net.netfilter.nf_conntrack_tcp_timeout_time_wait(默认432000): 代表nf_conntrack的TCP连接记录时间默认是5天

    net.ipv4.tcp_max_tw_buckets(默认180000): 表示系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息.建议减小，避免TIME_WAIT状态过多消耗整个服务器的资源，但也不能太小，跟你后端的处理速度有关，如果速度快可以小，速度慢则适当加大，否则高负载会有请求无法响应或非常慢

    net.ipv4.tcp_fin_timeout(默认60): 修改系统默认的 TIMEOUT 时间




常用查看命令::

    //查看当前系统使用的打开文件描述符数
    $> cat /proc/sys/fs/file-nr
    5664        0        186405
    其中第一个数表示当前系统已分配使用的打开文件描述符数
    第二个数为分配后已释放的（目前已不再使用）
    第三个数等于file-max。





/etc/sysctl.conf文件内容::

    应用服务器sysctl.conf部分参数
    ## network configurations
    net.ipv4.ip_forward = 0 # IP packet forwarding
    net.ipv4.tcp_tw_reuse=1
    net.ipv4.tcp_tw_recycle=1
    net.ipv4.tcp_fin_timeout=30  #60,每条至多占 1.5K 的内存
    net.ipv4.tcp_keepalive_time=1800 #7200
    net.core.netdev_max_backlog=3000 #1000每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的数据包的最大数目
    net.ipv4.tcp_max_syn_backlog=4096  #1024 增加TCP SYN队列长度，使系统可以处理更多的并发连接
    net.core.wmem_default = 2097152 #108544,系统套接字缓冲区
    net.core.rmem_default = 2097152 #108544,系统套接字缓冲区
    net.core.rmem_max=16777216   #131071,系统套接字缓冲区
    net.core.wmem_max=16777216 #131071,系统套接字缓冲区
    net.ipv4.tcp_rmem=4096 87380 16777216  #4096   87380   174760, TCP接收缓冲区
    net.ipv4.tcp_wmem=4096 65536 16777216 #4096  16384   131072, TCP发送缓冲区
    net.ipv4.tcp_mem = 786432 1048576 1572864 # Out of socket memory
    net.ipv4.tcp_syncookies=1  #0,防SyncFlood攻击
    net.ipv4.ip_local_port_range = 32768 61000 #用于向外连接的端口范围,这是默认值
    net.ipv4.tcp_max_tw_buckets = 5000  #180000,同时保持TIME_WAIT套接字的最大数量
    #以下可能需要加载ip_conntrack模块 modprobe ip_conntrack
    # net.ipv4.ip_conntrack_max=6553600
    # net.ipv4.netfilter.ip_conntrack_tcp_timeout_established = 1800
    # net.ipv4.netfilter.ip_conntrack_max=6553600
    # net.ipv4.netfilter.ip_conntrack_tcp_timeout_time_wait=120
    # net.ipv4.netfilter.ip_conntrack_tcp_timeout_close_wait=60
    # net.ipv4.netfilter.ip_conntrack_tcp_timeout_fin_wait=120
    # net.ipv4.icmp_echo_ignore_all = 1 #0, Disable ping requests
    # net.ipv4.icmp_echo_ignore_broadcasts = 1 #1, Enable ignoring broadcasts request
    net.ipv4.neigh.default.gc_thresh3 = 40960 #1024
    net.ipv4.neigh.default.gc_thresh2 = 20480 #512
    net.ipv4.neigh.default.gc_thresh1 = 10240 #128
    ##以上三条语句可以解决内核中出现的如下两行错误
    #Linux kernel: printk: xxxxx messages suppressed.
    #Linux kernel: Neighbour table overflow.

    ## system configurations
    fs.file-max = 372901 #23712, 整个系统所有可打开文件总数的限制, 可按256/4M内存计算值。
    # ulimit -n 10000 #某一程序可打开文件 总数的限制
    # kernel.ctrl-alt-del = 1 #0,Disable CTR+ALT+DEL Restart Keys

    附:sysctl.conf
    fs.file-max = 372901
    net.ipv4.tcp_tw_reuse=1
    net.ipv4.tcp_tw_recycle=1
    net.ipv4.tcp_fin_timeout=30
    net.ipv4.tcp_keepalive_time=1800
    net.core.netdev_max_backlog=3000
    net.ipv4.tcp_max_syn_backlog=4096
    net.core.wmem_default = 2097152
    net.core.rmem_default = 2097152
    net.ipv4.tcp_rmem=4096 87380 16777216
    net.core.rmem_max=33554432
    net.ipv4.tcp_wmem=4096 65536 16777216
    net.core.wmem_max=33554432
    net.ipv4.tcp_mem = 786432 1048576 1572864
    net.ipv4.tcp_syncookies=1
    net.ipv4.tcp_max_tw_buckets = 180000
    net.ipv4.ip_conntrack_max=6553600
    net.ipv4.netfilter.ip_conntrack_max=6553600
    net.ipv4.netfilter.ip_conntrack_tcp_timeout_time_wait=60
    net.ipv4.netfilter.ip_conntrack_tcp_timeout_close_wait=30
    net.ipv4.netfilter.ip_conntrack_tcp_timeout_fin_wait=60
    net.ipv4.ip_local_port_range = 32768 61000



常见问题=>error: 'net.ipv4.ip_conntrack_max' is an unknown key::

    sysctl -p的时, 报错
    解决方法:
    为linux kernel ``ip_conntrack`` 模块:
    /sbin/modprobe ip_conntrack

