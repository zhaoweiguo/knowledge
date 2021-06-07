ENTRYPOINT场景
##############

那么有了 CMD 后，为什么还要有 ENTRYPOINT 呢？这种 <ENTRYPOINT> "<CMD>" 有什么好处么？让我们来看几个场景。
    
.. note:: 当指定了 ENTRYPOINT 后，CMD 的含义就发生了改变，不再是直接的运行其命令，
        而是将 CMD 的内容作为参数传给 ENTRYPOINT 指令，换句话说实际执行时，将变为:
        <ENTRYPOINT> "<CMD>"



场景一: 让镜像变成像命令一样使用
--------------------------------

CMD命令::

    FROM ubuntu:16.04
    RUN apt-get update \
        && apt-get install -y curl \
        && rm -rf /var/lib/apt/lists/*
    CMD [ "curl", "-s", "https://ip.cn" ]

使用::

    # 可以直接使用
    $ docker run myip
    当前 IP：61.148.226.66 来自：北京市 联通

    # 但不能直接增加参数
    $ docker run myip -i
    docker: Error response from daemon: invalid header field value "oci runtime error: container_linux.go:247: starting container process caused \"exec: \\\"-i\\\": executable file not found in $PATH\"\n".

    # 正常的使用
    $ docker run myip curl -s https://ip.cn -i
    HTTP/2 200
    date: Fri, 22 Nov 2019 06:43:43 GMT
    content-type: application/json; charset=UTF-8
    set-cookie: __cfduid=df927c30f2617905838b0537dfe7499e51574405023; expires=Sun, 22-Dec-19 06:43:43 GMT; path=/; domain=.ip.cn; HttpOnly
    cf-cache-status: DYNAMIC
    expect-ct: max-age=604800, report-uri="https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct"
    server: cloudflare
    cf-ray: 5398ee43ae9ae829-LAX

    {"ip": "111.205.43.233", "country": "北京市", "city": "联通"}

ENTRYPOINT命令::

    FROM ubuntu:16.04
    RUN apt-get update \
        && apt-get install -y curl \
        && rm -rf /var/lib/apt/lists/*
    ENTRYPOINT [ "curl", "-s", "http://ip.cn" ]

使用::

    $ docker run myip
    当前 IP：61.148.226.66 来自：北京市 联通

    $ docker run myip -i
    HTTP/1.1 200 OK
    Server: nginx/1.8.0
    Date: Tue, 22 Nov 2016 05:12:40 GMT
    Content-Type: text/html; charset=UTF-8
    Vary: Accept-Encoding
    X-Powered-By: PHP/5.6.24-1~dotdeb+7.1
    X-Cache: MISS from cache-2
    X-Cache-Lookup: MISS from cache-2:80
    X-Cache: MISS from proxy-2_6
    Transfer-Encoding: chunked
    Via: 1.1 cache-2:80, 1.1 proxy-2_6:8006
    Connection: keep-alive

    当前 IP：61.148.226.66 来自：北京市 联通

场景二: 应用运行前的准备工作
----------------------------

启动容器就是启动主进程，但有些时候，启动主进程前，需要一些准备工作::

    比如 mysql 类的数据库，可能需要一些数据库配置、初始化的工作，这些工作要在最终的 mysql 服务器运行之前解决
    此外，可能希望避免使用 root 用户去启动服务，以提高安全性，
        而在启动服务前还需要以 root 身份执行一些必要的准备工作
        最后切换到服务用户身份启动服务。或者除了服务外，其它命令依旧可以使用 root 身份执行，方便调试等。

这些准备工作是和容器 CMD 无关的，无论 CMD 为什么，都需要事先进行一个预处理的工作。这种情况下，可以写一个脚本，然后放入 ENTRYPOINT 中去执行，而这个脚本会将接到的参数（也就是 <CMD>）作为命令，在脚本最后执行。比如官方镜像 redis 中就是这么做的::

    FROM alpine:3.4
    ...
    RUN addgroup -S redis && adduser -S -G redis redis
    ...
    ENTRYPOINT ["docker-entrypoint.sh"]

    EXPOSE 6379
    CMD [ "redis-server" ]

docker-entrypoint.sh 脚本::

    #!/bin/sh
    ...
    # allow the container to be started with `--user`
    if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
        chown -R redis .
        exec su-exec redis "$0" "$@"
    fi

    exec "$@"

该脚本的内容就是根据 CMD 的内容来判断，如果是 redis-server 的话，则切换到 redis 用户身份启动服务器，否则依旧使用 root 身份执行。比如::

    $ docker run -it redis id
    uid=0(root) gid=0(root) groups=0(root)








