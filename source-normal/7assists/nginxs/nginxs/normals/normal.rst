常用
####


Nginx调试::

    编译时使用:
    ./configure --with-debug


内置预定义变量::

    $is_args 如果$args设置，值为"?"，否则为""
    $document_root 当前请求在root指令中指定的值
    $args 这个变量等于GET请求中的参数。例如，foo=123&bar=blahblah;这个变量只可以被修改
    $uri 请求中的当前URI(不带请求参数，参数位于$args)，不同于浏览器传递的$request_uri的值
        它可以通过内部重定向，或者使用index指令进行修改。不包括协议和主机名，例如/foo/bar.html



常用的Nginx参数与控制::

    程序运行参数:
    nginx - t - c conf/nginx2.conf

    通过信号对 Nginx 进行控制:
    TERM, INT       快速关闭程序，中止当前正在处理的请求
    QUIT       处理完当前请求后，关闭程序
    HUP         重新加载配置，并开启新的工作进程，关闭就的进程，此操作不会中断请求
    USR1         重新打开日志文件，用于切换日志，例如每天生成一个新的日志文件
    USR2          平滑升级可执行程序
    WINCH          从容关闭工作进程

    两种方式:
    kill -HUP `cat /var/nginx/run/nginx.pid`
    killall - s HUP nginx





