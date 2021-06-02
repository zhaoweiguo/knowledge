ngrok [1]_
###################

说明::

    为本地服务提供public url. 
    在开发时，有时需要本地服务能通过外网访问, 如: 回调地址



前提::

    本地启动一个4000端口的服务

实例::

    $> ./ngrok http 4000
    ngrok by @inconshreveable             (Ctrl+C to quit)

    Session Status                online
    Session Expires               7 hours, 59 minutes
    Version                       2.3.35
    Region                        United States (us)
    Web Interface                 http://127.0.0.1:4040
    Forwarding                    http://85af1add.ngrok.io -> http://localhost:4000
    Forwarding                    https://85af1add.ngrok.io -> http://localhost:4000

    Connections                   ttl     opn     rt1     rt5     p50     p90
                                  0       0       0.00    0.00    0.00    0.00

后续::

    可以直接通过:
    http://85af1add.ngrok.io
    or
    https://85af1add.ngrok.io
    来访问本地的4000端口提供的服务



.. [1] https://ngrok.com/