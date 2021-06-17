.. _nc:

nc命令使用
######################

安装::

    yum install -y nmap-ncat.x86_64
    yum install -y nc.x86_64

    apt-get install  netcat  -y

    apt-get install nc-traditional 
    或者
    apt-get install nc-openbsd


给某一个endpoint发送TCP请求::

  nc 192.168.0.11 8000 < data

nc可以当做服务器，监听某个端口号::

  nc -l 8000 > received_data
  // 把某一次请求的内容存储到received_data里

.. note:: 不管是 gnu 版本还是 openbsd 版本，都有新老的区别，主要是传送文件时 stdin 发生 EOF 了，老版本会自动断开，而新的 gnu/openbsd 还会一直连着，两年前 debian jessie 时统一升过级，导致网上的所有教程几乎同时失效。


.. warning:: 注意: OpenBSD版与GNU版是有细节上的不同。openbsd 版本 netcat 用了 -l 以后可以省略 -p 参数，写做：nc -l 8080 ，但在 GNU netcat 下面无法运行，所以既然推荐写法是加上 -p 参数，两个版本都通用。老版本的 nc 只要 CTRL+D 发送 EOF 就会断开，新版本一律要 CTRL+C 结束，不管是服务端还是客户端只要任意一边断开了，另一端也就结束了，但是 openbsd 版本的 nc 可以加一个 -k 参数让服务端持续工作。

查看nc是OpenBSD版还是GNU版::

    $ readlink -f $(which nc)
    结果会有两种:
    1. /bin/nc.traditional: 默认 GNU 基础版本，一般系统自带
    2. /bin/nc.openbsd: openbsd 版本，强大很多


实例-端口扫描::

    端口扫描:
    nc -v -w 2 <server ip> -z <port1>-<port2>
    例:
    $ nc -z example.com 20-100
    Connection to example.com 22 port [tcp/ssh] succeeded!
    Connection to example.com 80 port [tcp/ssh] succeeded!


实例-tcp::

    % 1.启动一tcp服务
    server1> nc -l <port>
    ...
    % 2.连接此tcp服务
    server2> nc <ip> <port>

实例-udp::

    # 1. 启动udp服务
    nc -u -l <port>
    # 2. 请求udp服务
    nc --wait 1 --udp 127.0.0.1 8125
    等同于
    nc -w 1 -u 127.0.0.1 8125

实例-连接远程http系统::

    $ ncat IP_address port_number
    % 以下是几种请求
    GET / HTTP/1.1
    HEAD / HTTP/1.1

实例-服务器间复制文件(实现类似rsync功能)::

    server> nc -l [port] > test.txt
    ...
    client> nc [server1 Ip] <test.txt
    例:
    server:
    $ nc -l 9090 | tar -xzf -
    client:
    $ tar -czf dir/ | nc <server_ip> 9090



实例-将 nc 作为代理::

    % 所有8080 端口的连接都会自动转发到 192.168.1.200 上的 80 端口
    $ ncat -l 8080 | ncat 192.168.1.200 80

    %上面是单向传输，可使用下面命令实现双向管道
    $ mkfifo 2way
    $ ncat -l 8080 0<2way | ncat 192.168.1.200 80 1>2way

实例-端口转发::

    % 80端口会自动转发到8080
    $ ncat -u -l  80 -c  'ncat -u -l 8080'


实例-创建后门::

    1. GNU 版本
    原理: GNU 版本的 netcat 有一个 -e 参数，可以在连接建立的时候执行一个程序，并把它的标准输入输出重定向到网络连接上来

    $ /bin/nc.traditional -l -p 8080 -e /bin/bash
    % -e 标志将一个 bash 与端口 10000 相连
    % 以用以下命令可以获取所有bash权限
    $ ncat 192.168.1.100 10000

    2. 通用方法(参见下面: 实例-把任何应用通过网络暴露出来)
    对于 openbsd 版本的 netcat，-e 命令被删除了，没关系，我们可以用管道来完成:
    mkfifo /tmp/f
    $ cat /tmp/f | /bin/bash 2>&1 | /bin/nc.openbsd -l -p 8080 > /tmp/f
    然后 B 主机和刚才一样：
    $ nc 192.168.1.2 8080



实例-连接超时::

    % 连接 10 秒后终止
    $ ncat -w 10 192.168.1.100 8080

实例-强制监听待命::

    % 客户端从服务端断开连接后，过一段时间服务端也会停止监听
    % 即使来自客户端的连接断了也依然会处于待命状态
    $ ncat -l -k 8080

实例-把任何应用通过网络暴露出来::

    实例: 实现类似ssh的功能
    server:
    $ mkfifo backpipe
    $ nc -l 8080 0<backpipe | /bin/bash > backpipe

    $ nc example.com 8080
    uname -a
    Linux li228-162 2.6.39.1-linode34 ##1 SMP Tue Jun 21 10:29:24 EDT 2011 i686 GNU/Linux

实例-网速吞吐量测试::

    1. GNU 版本原理:
    GNU 版本的 netcat 加上 -v -v 参数后，结束时会统计接收和发送多少字节

    server:
    $ /bin/nc.traditional -v -v -n -l -p 8080 > /dev/null     // 加 n 的意思是不要解析域名，避免解析域名浪费时间造成统计误差

    client:
    $ time nc -n 192.168.1.2 8080 < /dev/zero

    回车后执行十秒钟按 CTRL+C 结束，然后在 A 主机那里就可以看到接收了多少字节了，此时根据 time 的时间自己做一下除法即可得知
    注意: GNU 的 netcat 统计的数值是 32 位 int，如果传输太多就回环溢出成负数了。


    2. OpenBSD 版本的 nc可以用管道搭配 dd 命令进行统计
    
    server:
    $ nc -l -p 8080 > /dev/null

    client:
    $ dd if=/dev/zero bs=1MB count=100 | /bin/nc.openbsd -n -N 192.168.1.2 8080

    3. 上面两种方法都把建立连接的握手时间以及 TCP 窗口慢启动的时间给计算进去了，不是特别精确
       最精确的方式是搭配 pv 命令（监控统计管道数据的速度）

    server:
    $ nc -l -p 8080 | pv

    client:
    $ nc 192.168.1.2 8080 < /dev/zero

    能看到实时的带宽统计了，pv 会输出一个实时状态：
     353MiB 0:00:15 [22.4MiB/s] [          <=>  ]
    在不需要 iperf 的情况下，直接使用 nc 就能得到一个准确的数据。


.. note:: 还有很多其他用法，比如你可以用 netcat + shell script 写一个 http 服务器，使用 fifo 搭配两层 nc 可以实现 tcp 端口转发，搭配 openssl 命令行工具和 nc 加管道可以把 ssl 的套接字解码并映射成裸的 socket 端口供没有 ssl 功能的工具访问。。。。

参考
====

* https://zhuanlan.zhihu.com/p/83959309




    
