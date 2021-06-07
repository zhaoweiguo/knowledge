Connection
################

持久连接::

    http1.0:
    Connection: keep-alive  # 指定持久连接机制

    http1.1:
    Connection: close    # 默认持久连接,非持久连接要明确指定



实例::

    require('net').createServer(function(sock) {
        sock.on('data', function(data) {
            sock.write('HTTP/1.1 200 OK\r\n');
            sock.write('\r\n');
            sock.write('hello world!');
            sock.destroy();
        });
    }).listen(9090, '127.0.0.1');

    去掉 sock.destroy() 这一行，让它变成持久连接
    但变成持久连接后，请求一直处于pending状态
    原因是:
      1. 对非持久连接，浏览器可以通过连接是否关闭来界定请求或响应实体的边界
      2. 而对于持久连接，这种方法显然不奏效,可以指定实体长度来告诉浏览器



* :ref:`使用Content-Length指定实体长度 <content-length>`
