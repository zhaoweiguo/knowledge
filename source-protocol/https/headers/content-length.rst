.. _content-length:

Content-Length
####################

使用Content-Length指定实体长度::

    require('net').createServer(function(sock) {
        sock.on('data', function(data) {
            sock.write('HTTP/1.1 200 OK\r\n');
            sock.write('Content-Length: 12\r\n');
            sock.write('\r\n');
            sock.write('hello world!');
        });
    }).listen(9090, '127.0.0.1');


如果 Content-Length 和实体实际长度不一致会怎样::

    如果 Content-Length 比实际长度短，会造成内容被截断
    如果比实体内容长，会造成 pending





我们在做 WEB 性能优化时，有一个重要的指标叫 TTFB（Time To First Byte），它代表的是从客户端发出请求到收到响应的第一个字节所花费的时间。大部分浏览器自带的 Network 面板都可以看到这个指标，越短的 TTFB 意味着用户可以越早看到页面内容，体验越好。



