.. _http_load:

http_load命令使用方法
#####################

简介::

    程序非常小，解压后也不到100K
    http_load以并行复用的方式运行，用以测试web服务器的吞吐量与负载。
    但是它不同于大多数压力测试工具，它可以以一个单一的进程运行，一般不会把客户机搞死。
    还可以测试HTTPS类的网站请求。

安装::

    //下载安装，安装地址:
    http://www.acme.com/software/http_load/

命令格式::

    http_load -p 并发访问进程数 -s 访问时间 需要访问的URL文件

参数说明::

    -parallel (-p): 并发的用户进程数
    -fetches (-f): 总计的访问次数
    -rate (-r): 每秒的访问频率
    -seconds (-s): 总计的访问时间

.. note:: URL最好超过50－100个测试效果比较好

实例
====

实例::

    ./http_load -rate 5 -seconds 10 urllist.txt

实例说明::

    执行一个持续时间为10秒的测试，每秒频率为5
    urllist.txt中内容为:

    http://bbs.programfan.info/abc/test1.html
    http://bbs.programfan.info/abc/test2.html
    http://bbs.programfan.info/abc/test3.html

結果::

    49 fetches, 2 max parallel, 289884 bytes, in 10.0148 seconds
    5916 mean bytes/connection, 
    4.89274 fetches/sec, 28945.5 bytes/sec
    msecs/connect: 28.8932 mean, 44.243 max, 24.488 min
    msecs/first-response: 63.5362 mean, 81.624 max, 57.803 min
    HTTP response codes: code 200 — 49 

結果说明::

    1. 49 fetches, 2 max parallel, 289884 bytes, in 10.0148 seconds
        说明在上面的测试中运行了49个请求，最大的并发进程数是2，总计传输的数据是289884bytes，运行的时间是10.0148 秒
    2. 5916 mean bytes/connection
        说明每一连接平均传输的数据量289884/49=5916
    3. 4.89274 fetches/sec, 28945.5 bytes/sec
        说明每秒的响应请求为4.89274，每秒传递的数据为28945.5 bytes/sec
    4. msecs/connect: 28.8932 mean, 44.243 max, 24.488 min
        说明每连接的平均响应时间是28.8932 msecs，最大的响应时间44.243 msecs，最小的响应时间24.488 msecs
    5. msecs/first-response: 63.5362 mean, 81.624 max, 57.803 min
    6. HTTP response codes: code 200 — 49
        说明打开响应页面的类型，如果403的类型过多，那可能

特殊说明:

    测试结果中主要的指标是 fetches/sec、msecs/connect 这个选项，即服务器每秒能够响应的查询次数！

常见错误
========


常见错误-byte count wrong::

    http_load在处理时会去关注每次访问同一个URL返回结果（即字节数）是否一致
    若不一致就会抛出byte count wrong所以动态页面可以忽略这个错误信息
    或者可以对代码做修改http_load.c

常见错误-too many open files::

    系统限制的open files太小，ulimit -n 修改open files值即可

常见错误-无法发送大请求 （请求长度>600个字符）::

    默认接受请求的buf大小 http_load.c

常见错误-Cannot assign requested address::

    客户端频繁的连服务器，由于每次连接都在很短的时间内结束，导致很多的TIME_WAIT
    以至于用光了可用的端口号，所以新的连接没办法绑定端口，所以要改客户端机器的配置

    在sysctl.conf里加：
    net.ipv4.tcp_tw_reuse = 1 表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；
    net.ipv4.tcp_timestamps=1 开启对于TCP时间戳的支持,若该项设置为0，则下面一项设置不起作用
    net.ipv4.tcp_tw_recycle=1 表示开启TCP连接中TIME-WAIT sockets的快速回收    



