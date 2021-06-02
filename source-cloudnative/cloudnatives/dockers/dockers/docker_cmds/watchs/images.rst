docker images
######################

Usage::

    // 列出images列表
    // List images
    docker images [OPTIONS] [REPOSITORY[:TAG]]


基本实例::

    $ docker images
    # docker images test/static_web
    REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    test/static_web     latest              94728651ce15        20 hours ago        212.1 MB

    # 查看所有镜像,可与其他命令配合使用(如rmi)
    $ docker images -a -q

    # 查看所有虚悬镜像(dangling image)
    $ docker image ls -f dangling=true

    # 查看所有中间层镜像
    $ docker image ls -a

    # 查看指定仓库的镜像
    $ docker image ls ubuntu          # 查看ubuntu的所有镜像
    $ docker image ls ubuntu:16.04    # 查看指定标签的镜像

    # 查看镜像摘要
    $ docker image ls --digests
    REPOSITORY   TAG   DIGEST                                                                    IMAGE ID            CREATED             SIZE
    node         slim  sha256:b4f0e0bdeb578043c1ea6862f0d40cc4afe32a4a582f3be235a3b164422be228   6e0c4c8e3913        3 weeks ago         214 MB




filter实例::

    # 在 mongo:3.2 之后建立的镜像
    $ docker image ls -f since=mongo:3.2
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    redis               latest              5f515359c7f8        5 days ago          183 MB
    nginx               latest              05a60462f8ba        5 days ago          181 MB

    # 在 mongo:3.2 之前建立的镜像
    $ docker image ls -f before=mongo:3.2

    # 通过 LABEL 来过滤
    $ docker image ls -f label=com.example.version=0.1

quiet实例::

    # 只显示docker的id
    $ docker image ls -q
    5f515359c7f8
    05a60462f8ba
    fe9198c04d62

    # 与--filter 配合 -q 产生出指定范围的 ID 列表，然后送给另一个 docker 命令作为参数
    $ docker image rm $(docker image ls -q redis)


高级::

    # 直接列出镜像结果，并且只包含镜像ID和仓库名
    $ docker image ls --format "{{.ID}}: {{.Repository}}"
    5f515359c7f8: redis
    05a60462f8ba: nginx
    fe9198c04d62: mongo

    # 打算以表格等距显示，并且有标题行，和默认一样，不过自己定义列
    $ docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"
    IMAGE ID            REPOSITORY          TAG
    5f515359c7f8        redis               latest
    05a60462f8ba        nginx               latest
    fe9198c04d62        mongo               3.2



Options::

    -a, --all             Show all images (default hides intermediate images)
        --digests         Show digests
    -f, --filter filter   Filter output based on conditions provided
        --format string   Pretty-print images using a Go template
        --no-trunc        Don't truncate output
    -q, --quiet           Only show numeric IDs





