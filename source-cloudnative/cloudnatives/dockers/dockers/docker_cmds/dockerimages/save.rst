docker save
###########

Docker 还提供了 docker load 和 docker save 命令，用以将镜像保存为一个 tar 文件，然后传输到另一个位置上，再加载进来。这是在没有 Docker Registry 时的做法，现在已经不推荐，镜像迁移应该直接使用 Docker Registry，无论是直接使用 Docker Hub 还是使用内网私有 Registry 都可以。


实例1::

    $ docker save alpine | gzip > alpine-latest.tar.gz

    # 然后我们将 alpine-latest.tar.gz 文件复制到了到了另一个机器上，可以用下面这个命令加载镜像：
    $ docker load -i alpine-latest.tar.gz
    Loaded image: alpine:latest

结合这两个命令以及 ssh 甚至 pv 的话，利用 Linux 强大的管道(带进度条)::

    $ docker save <镜像名> | bzip2 | pv | ssh <用户名>@<主机名> 'cat | docker load'





* 保存镜像::

    docker save -o rocketmq.tar rocketmq:3.2.6
    # -o：指定保存的镜像的名字；
    # rocketmq.tar：保存到本地的镜像名称；
    # rocketmq：镜像名字，通过"docker images"查看





