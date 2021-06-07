Dockerfile命令说明 [1]_
#######################


FROM::

    每个Dockerfile的第一条指令都应该是FROM,
    FROM指令指定一个已经存在的镜像，后续指令都是将基于该镜像进行，
    这个镜像被称为基础镜像（base iamge）
    
    格式:
    FROM <image>
    FROM <image>:<tag>
    
    实例:
    FROM zhaoweiguo/utuntu:12.02
    FROM python:2.7-slim


MAINTAINER::

    # 这条指令会告诉Docker该镜像的作者是谁，以及作者的邮箱地址。这有助于表示镜像的所有者和联系方式
    MAINTAINER <name>

RUN::

    每条RUN指令都会创建一个新的镜像层，如果该指令执行成功，就会将此镜像层提交
    之后继续执行Dockerfile中的下一个指令

    实例:
    1. shell 格式
    格式: RUN <command>

    默认情况下，RUN指令会在shell里使用命令包装器/bin/sh -c 来执行
    RUN apt-get update
    RUN apt-get install -y nginx
    RUN echo 'Hi, I am in your container' > /usr/share/nginx/html/index.html

    2. exec 格式
    格式: RUN ["executable", "param1", "param2"]

    如果是在一个不支持shell的平台上运行或者不希望在shell中运行
    也可以使用exec格式的RUN指令，通过一个数组的方式指定要运行的命令和传递给该命令的每个参数
    RUN ["/bin/bash", "-c", "echo hello"]
    RUN ["apt-get", "install", "-y", "nginx"]


CMD::

    CMD 指令就是用于指定默认的容器主进程的启动命令的
    
    在运行时可以指定新的命令来替代镜像设置中的这个默认命令，比如:
        ubuntu 镜像默认的 CMD 是 /bin/bash
    我们可使用如下命令直接进入 bash:
        $ docker run -it ubuntu
    我们也可以在运行时指定运行别的命令，如:
        $ docker run -it ubuntu cat /etc/

    CMD 指令的格式和 RUN 相似，也是两种格式:
    1. shell格式
    2. exec格式


    格式:
    # The main purpose of a CMD is to provide defaults for an executing container. 
    CMD ["executable", "param1", "param2"]    # (like an exec, this is the preferred form)
    CMD ["param1","param2"]       #  (as default parameters to ENTRYPOINT)
    CMD command param1 param2     #  (as a shell)

    实例:
    e.g. CMD echo "This is a test." | wc -
    e.g. CMD ["/usr/bin/wc","--help"]
    Note: don't confuse RUN with CMD. RUN actually runs a command and commits the result; CMD does not execute anything at build time, but specifies the intended command for the image.

ENTRYPOINT::

    ENTRYPOINT 的格式和 RUN 指令格式一样，分为 exec 格式和 shell 格式
    ENTRYPOINT 在运行时也可以替代，不过比 CMD 要略显繁琐，需要通过 docker run 的参数 --entrypoint 来指定

    # 一个Dockerfile文件中只能有一个ENTRYPOINT
    # 如果有ENTRYPOINT那么整个container可看作一个executable文件
    # 执行的命令不会被docker run覆盖(与CMD不同)

    样例1:
    ENTRYPOINT  ["executable", "param1", "param2"]   # (like an exec, the preferred form)
    // exec形式: 主进程(Pid 1)是node进程
    $> docker exec <xxx> ps x
    Pid TTY STAT    COMMAND
    1   ?   Ssl     node app.js
    12  ?   Rs      ps x

    样例2:
    ENTRYPOINT command param1 param2    # (as a shell)
    // shell形式: 主进程(Pid 1)是shell进程而非node进程
    $> docker exec <xxx> ps x
    Pid TTY STAT    COMMAND
    1   ?   Ss     /bin/sh -c node app.js
    7   ?   Sl     node app.js
    12  ?   Rs      ps x


EXPOSE::

    EXPOSE 指令是声明运行时容器提供服务端口，这只是一个声明，在运行时并不会因为这个声明应用就会开启这个端口的服务。
    在 Dockerfile 中写入这样的声明有两个好处:
        1. 帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射；
        2. 在运行时使用随机端口映射时，也就是 docker run -P 时，会自动随机映射 EXPOSE 的端口。

    而是需要你在使用docker run运行容器时来指定需要打开哪些端口
    可以指定多个EXPOSE指令来向外部公开多个端口，Docker也使用EXPOSE指令来帮助将多个容器

    格式:
    EXPOSE <port> [<port>...]

    实例:

ARG::

    格式:
    ARG <参数名>[=<默认值>]

    构建参数和 ENV 的效果一样，都是设置环境变量
    以在构建命令 docker build 中用 --build-arg <参数名>=<值> 来覆盖


ENV::

    # 设定环境变量environment
    ENV <key> <value>
    # 可以通过docker inspect查看这些值
    # 可以通过docker run --env <key>=<value>修改这些值
    e.g. ENV DEBIAN_FRONTEND noninteractive   # will persist when the container is run interactively; for example: docker run -t -i image bash

    下列指令可以支持环境变量展开: ADD、COPY、ENV、EXPOSE、LABEL、USER、WORKDIR、VOLUME、STOPSIGNAL、ONBUILD。

    # 实例(官方 node):
    ENV NODE_VERSION 7.2.0
    RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
      && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
      && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
      && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
      && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
      && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
      && ln -s /usr/local/bin/node /usr/local/bin/nodejs




ADD::

    # 拷贝一个宿主机上的文件<src>到container的<dest>目录下
    ADD <src> <dest>
    类似: mount到指定位置
    
    ADD 指令和 COPY 的格式和性质基本一致。但是在 COPY 基础上增加了一些功能:
    比如: <源路径> 可以是一个 URL,下载后的文件权限自动设置为 600

    注:
    如果 <源路径> 为一个 tar 压缩文件的话，压缩格式为 gzip, bzip2 以及 xz 的情况下
        ADD 指令将会自动解压缩这个压缩文件到 <目标路径> 去
    但在某些情况下，如果我们真的是希望复制个压缩文件进去，而不解压缩，这时就不可以使用 ADD 命令了。

    在 Docker 官方的 Dockerfile 最佳实践文档 中要求，尽可能的使用 COPY
        因为 COPY 的语义很明确，就是复制文件而已，而 ADD 则包含了更复杂的功能，其行为也不一定很清晰。
        最适合使用 ADD 的场合，就是所提及的需要自动解压缩的场合
    另外需要注意的是，ADD 指令会令镜像构建缓存失效，从而可能会令镜像构建变得比较缓慢。



COPY::

    // 建议使用copy，少用add
    COPY <src> <dest>
    类似cp命令



VOLUME::

    格式:
    VOLUME ["<路径1>", "<路径2>"...]
    VOLUME <路径>

    # 磁盘挂载
    VOLUME ["/data"]
    VOLUME /data
    这里的 /data 目录就会在运行时自动挂载为匿名卷，
    任何向 /data 中写入的信息都不会记录进容器存储层，从而保证了容器存储层的无状态化。
    当然，运行时可以覆盖这个挂载设置。比如:
    docker run -d -v mydata:/data xxxx


USER::

    指定当前用户
    格式：USER <用户名>
    USER 指令和 WORKDIR 相似，都是改变环境状态并影响以后的层。
    WORKDIR 是改变工作目录，USER 则是改变之后层的执行 RUN, CMD 以及 ENTRYPOINT 这类命令的身份
    
    # sets the user name or UID
    USER daemon

WORKDIR::

    格式:
    WORKDIR /path/to/workdir
    
    实例:
    WORKDIR /a
    WORKDIR b
    WORKDIR c
    RUN pwd
    # /a/b/c

ONBUILD::

    格式: ONBUILD [INSTRUCTION]

    ONBUILD 是一个特殊的指令，它后面跟的是其它指令，比如 RUN, COPY 等
    而这些指令，在当前镜像构建时并不会被执行。只有当以当前镜像为基础镜像，去构建下一级镜像的时候才会被执行

    实例:
    1. 基础镜像:
    FROM node:slim
    RUN mkdir /app
    WORKDIR /app
    ONBUILD COPY ./package.json /app
    ONBUILD RUN [ "npm", "install" ]
    ONBUILD COPY . /app/
    CMD [ "npm", "start" ]

    # 基于基础镜像 
    FROM <baseMirror>
    它等同于:
    FROM node:slim
    RUN mkdir /app
    WORKDIR /app
    COPY ./package.json /app
    RUN [ "npm", "install" ]
    COPY . /app/
    CMD [ "npm", "start" ]


HEALTHCHECK::

    格式:
    HEALTHCHECK [选项] CMD <命令>：设置检查容器健康状况的命令
    HEALTHCHECK NONE：如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令

    HEALTHCHECK 指令是告诉 Docker 应该如何进行判断容器的状态是否正常，这是 Docker 1.12 引入的新指令。
    用这行命令来判断容器主进程的服务状态是否还正常，从而比较真实的反应容器实际状态。

    初始状态会为 starting
    检查成功后变为 healthy
    连续一定次数失败，则会变为 unhealthy

    HEALTHCHECK 支持下列选项:
    --interval=<间隔>：两次健康检查的间隔，默认为 30 秒；
    --timeout=<时长>：健康检查命令运行超时时间，如果超过这个时间，本次健康检查就被视为失败，默认 30 秒；
    --retries=<次数>：当连续失败指定次数后，则将容器状态视为 unhealthy，默认 3 次。

    和 CMD, ENTRYPOINT 一样，HEALTHCHECK 只可以出现一次，如果写了多个，只有最后一个生效。
    命令的返回值决定了该次健康检查的成功与否：0：成功；1：失败；2：保留，不要使用这个值

    实例:
    FROM nginx
    RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
    HEALTHCHECK --interval=5s --timeout=3s \
      CMD curl -fs http://localhost/ || exit 1



实例::

    # This is a comment
    FROM ubuntu:14.04
    MAINTAINER Kate Smith <ksmith@example.com>
    RUN apt-get update && apt-get install -y ruby ruby-dev
    RUN gem install sinatra

实例-时区::

    实例1:
    // 前提宿主机有文件/usr/share/zoneinfo/Asia/Shanghai
    // 使用docker镜像的, 要求镜像有此文件
    RUN copy /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

    实例2:
    RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && apk del tzdata



.. [1] https://docs.docker.com/reference/builder/

