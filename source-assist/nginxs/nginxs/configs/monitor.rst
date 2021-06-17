监控
####


配置::

    location ~ ^/NginxStatus/ {
        stub_status on;
        access_log off;
        allow 127.0.0.1;
        deny all;
    }


上述配置中，首先我们定义了一个 ``location ~ ^/NginxStatus/`` ,这样通过 http://localhost/NginxStatus/ 就可以监控到 Nginx 的运行信息，显示的内容如下::

    Active connections: 70     
    server accepts handled requests
     14553819 14553819 19239266 
    Reading: 0 Writing: 3 Waiting: 67 

NginxStatus 显示的内容意思如下:

    1. Active connections
        当前 Nginx 正处理的活动连接数
    2. server accepts handled requests
        总共处理了 14553819 个连接
        成功创建 14553819 次握手 ( 证明中间没有失败的 )
        总共处理了 19239266 个请求 ( 平均每次握手处理了 1.3 个数据请求 )
    3. reading
        nginx 读取到客户端的 Header 信息数
    4. writing
        nginx 返回给客户端的 Header 信息数。
    5. waiting
        开启 keep-alive 的情况下，这个值等于 active - (reading + writing)
        意思就是 Nginx 已经处理完正在等候下一次请求指令的驻留连接

注::

    安装(可能需要增加选项 --with-http_stub_status_module 启用 nginx 的 NginxStatus 功能
    ./configure --with-http_stub_status_module 





