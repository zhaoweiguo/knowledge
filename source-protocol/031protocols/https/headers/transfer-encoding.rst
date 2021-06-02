Transfer-Encoding
#######################


* HTTP 头部字段::

    Transfer-Encoding(传输编码)
    Content-Encoding(内容编码)
    Connection(持久连接)


* HTTP 协议中的 Transfer-Encoding [1]_





* 传输编码::

    Transfer-Encoding 则是用来改变报文格式，
    Transfer-Encoding: chunked
    历史上Transfer-Encoding可以有多种取值，为此还引入了一个名为TE的头部用来协商采用何种传输编码
    但是最新的 HTTP 规范里，只定义了一种传输编码：分块编码（chunked）
    分块编码相当简单，在头部加入 Transfer-Encoding: chunked 之后，就代表这个报文采用了分块编码

报文中的实体需要改为用一系列分块来传输。每个分块包含十六进制的长度值和数据，长度值独占一行，长度不包括它结尾的 CRLF（\r\n），也不包括分块数据结尾的 CRLF。最后一个分块长度值必须为 0，对应的分块数据没有内容，表示实体结束::

    require('net').createServer(function(sock) {
        sock.on('data', function(data) {
            sock.write('HTTP/1.1 200 OK\r\n');
            sock.write('Transfer-Encoding: chunked\r\n');
            sock.write('\r\n');

            sock.write('b\r\n');
            sock.write('01234567890\r\n');

            sock.write('5\r\n');
            sock.write('12345\r\n');

            sock.write('0\r\n');
            sock.write('\r\n');
        });
    }).listen(9090, '127.0.0.1');

    上面这个例子中，我在响应头中表明接下来的实体会采用分块编码，然后:
      输出了 11 字节的分块，
      接着又输出了 5 字节的分块，
      最后用一个 0 长度的分块表明数据已经传完了

Content-Encoding 和 Transfer-Encoding 二者经常会结合来用，其实就是针对进行了内容编码（压缩）的内容再进行传输编码（分块）。下面是我用 telnet 请求测试页面得到的响应，可以看到对 gzip 内容进行的分块::

    > telnet 106.187.88.156 80

    GET /test.php HTTP/1.1
    Host: qgy18.qgy18.com
    Accept-Encoding: gzip

    HTTP/1.1 200 OK
    Server: nginx
    Date: Sun, 03 May 2015 17:25:23 GMT
    Content-Type: text/html
    Transfer-Encoding: chunked
    Connection: keep-alive
    Content-Encoding: gzip

    1f
    �H���W(�/�I�J

    0








.. [1] https://imququ.com/post/transfer-encoding-header-in-http.html