Gopher协议
##########

gopher协议是一种信息查找系统，他将Internet上的文件组织成某种索引，方便用户从Internet的一处带到另一处。在WWW出现之前，Gopher是Internet上最主要的信息检索工具，Gopher站点也是最主要的站点，使用tcp70端口。但在WWW出现后，Gopher失去了昔日的辉煌。现在它基本过时，人们很少再使用它。它只支持文本，不支持图像。我们现在最多看到使用这个协议的时候都是在去ssrf打redis shell、读mysql数据的时候。

gopher协议格式::

    gopher://IP:port/_{TCP/IP数据流}


基础使用
========



使用nc监听端口::

    $ nc -lvp 192.168.109.1:6666

使用::

    $ curl gopher://192.168.109.1:6666/_abcd
    发送gopher get请求,可以发现_不会被显示

发送gopher get请求::

    在gopher协议中发送HTTP的数据，需要以下三步:
    1. 构造HTTP数据包
    2. URL编码、替换回车换行为%0d%0a，HTTP包最后加%0d%0a代表消息结束
    3. 发送gopher协议, 协议后的IP一定要接端口

    例:
    $ curl gopher://192.168.109.166:80/_GET%20/get.php%3fparam=Konmu%20HTTP/1.1%0d%0aHost:192.168.109.166%0d%0a

    cat get.php:
    <?php echo "Hello"." ".$_GET['param']."\n"?>

发送http post请求::

    POST与GET传参的区别：它有4个参数为必要参数
    Content-Type,
    Content-Length,
    host,
    post

    post.php中写入<?php echo "Hello".$_POST['name']."\n";?>









