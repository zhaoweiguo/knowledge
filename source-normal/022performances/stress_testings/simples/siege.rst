.. _siege:

siege命令的使用方法
###################

* 官网:

    `siege官网 <http://www.joedog.org>`_

* 下载:

    源码安装

* 使用::

    siege -c 200 -r 10 -f example.url

* 参数说明:

    * -c: 并发量
    * -r: 重复次数
    * -f: 指定文件
    * example.url文件内容::

        http://bbs.programfan.info
        http://blog.programfan.info
        http://www.programfan.info

    * 每行都是一个url，它会从中随机选一个访问

* 結果说明::

    Lifting the server siege… done.
    Transactions: 3419263 hits //完成419263次处理
    Availability: 100.00 % //100.00 % 成功率
    Elapsed time: 5999.69 secs //总共用时
    Data transferred: 84273.91 MB //共数据传输84273.91 MB
    Response time: 0.37 secs //相应用时1.65秒：显示网络连接的速度
    Transaction rate: 569.91 trans/sec //均每秒完成 569.91 次处理：表示服务器后
    Throughput: 14.05 MB/sec //平均每秒传送数据
    Concurrency: 213.42 //实际最高并发数
    Successful transactions: 2564081 //成功处理次数
    Failed transactions: 11 //失败处理次数
    Longest transaction: 29.04 //每次传输所花最长时间
    Shortest transaction: 0.00 //每次传输所花最短时间

实例
====

非常类似于curl的-iL，只是这里Siege也会输出请求header::

    $ siege -g www.google.com:
    GET / HTTP/1.1 
    Host: www.google.com 
    User-Agent: JoeDog/1.00 [en] (X11; I; Siege 2.70)
    Connection: close  

    HTTP/1.1 302 Found 
    Location: http://www.google.co.uk/ 
    Content-Type: text/html; charset=UTF-8 
    Server: gws 
    Content-Length: 221 
    Connection: close  

    GET / HTTP/1.1 
    Host: www.google.co.uk 
    User-Agent: JoeDog/1.00 [en] (X11; I; Siege 2.70) 
    Connection: close  

    HTTP/1.1 200 OK 
    Content-Type: text/html; charset=ISO-8859-1 
    X-XSS-Protection: 1; mode=block 
    Connection: close

真正在行的是服务器的负载测试。就像ab::

    在30秒内向Google发起20个并发连接，最后会得到一个漂亮的测试报告
    $ siege -c20 www.google.co.uk -b -t30s 
    ...
    Lifting the server siege... done. 
    Transactions: 1400 hits 
    Availability: 100.00 % 
    Elapsed time: 29.22 secs 
    Data transferred: 13.32 MB 
    Response time: 0.41 secs 
    Transaction rate: 47.91 trans/sec 
    Throughput: 0.46 MB/sec 
    Concurrency: 19.53 
    Successful transactions: 1400 
    Failed transactions: 0 
    Longest transaction: 4.08 
    Shortest transaction: 0.08

Siege最有用的一个特性是它可以把一个记录URL的文件作为输入::

    // 重现Apache对另一台服务器的日志记录，以做负载测试
    $ cut -d ' ' -f7 /var/log/apache2/access.log > urls.txt 
    $ siege -c<concurrency rate> -b -f urls.txt







