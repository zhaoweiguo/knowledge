安装 [1]_
##########

Docker安装
===============

启动gitlab::

    docker run --detach \
      --hostname gitlab.zhaoweiguo.com \
      --publish 8443:443 --publish 8080:80 --publish 2222:22 \
      --name gitlab \
      --restart always \
      --volume /Users/zhaoweiguo/gitlab/config:/etc/gitlab \
      --volume /Users/zhaoweiguo/gitlab/logs:/var/log/gitlab \
      --volume /Users/zhaoweiguo/gitlab/data:/var/opt/gitlab \
      gitlab/gitlab-ce

启动gitlab-runner::

    sudo docker run -d /
      --name gitlab-runner /
      --restart always /
      -v /Users/zhangzc/gitlab-runner/config:/etc/gitlab-runner /
      -v /Users/zhangzc/gitlab-runner/run/docker.sock:/var/run/docker.sock /
      gitlab/gitlab-runner:latest

Dockerfile文件::

    # Base image: https://hub.docker.com/_/golang/
    FROM golang:1.9.2
    USER root
    # Install golint
    ENV GOPATH /go
    ENV PATH ${GOPATH}/bin:$PATH
    RUN mkdir -p /go/src/golang.org/x
    RUN mkdir -p /go/src/github.com/golang
    COPY source/golang.org /go/src/golang.org/x/
    COPY source/github.com /go/src/github.com/golang/
    RUN go install github.com/golang/lint/golint

    # install docker
    RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
        && tar zxvf docker-latest.tgz \
        && cp docker/docker /usr/local/bin/ \
        && rm -rf docker docker-latest.tgz

    # install expect
    RUN apt-get update
    RUN apt-get -y install tcl tk expect

生成镜像脚本::

    #!/bin/bash

    echo "提取构建镜像时需要的文件"
    source_path="source"
    mkdir -p $source_path/golang.org
    mkdir -p $source_path/github.com
    cp -rf $GOPATH/src/golang.org/x/lint $source_path/golang.org/
    cp -rf $GOPATH/src/golang.org/x/tools $source_path/golang.org/
    cp -rf $GOPATH/src/github.com/golang/lint $source_path/github.com

    echo "构建镜像"
    docker build -t go-tools:1.9.2 .

    echo "删除构建镜像时需要的文件"
    rm -rf $source_path

runner注册及配置
================

环境准备好后，在服务器上执行以下命令，注册runner::

    docker exec -it gitlab-runner gitlab-ci-multi-runner register

配置::

    [[runners]]
      name = "demo-test"
      url = "https://gitlab.chain.cn/"
      token = "c771fc5feb1734a9d4df4c8108cd4e"
      executor = "docker"
      [runners.docker]
        tls_verify = false
        image = "go-tools:1.9.2"
        privileged = false
        disable_cache = false
        volumes = ["/var/run/docker.sock:/var/run/docker.sock"]
        extra_hosts = ["gitlab.chain.cn:127.0.0.1"]
        network_mode = "host"
        pull_policy = "if-not-present"
        shm_size = 0
      [runners.cache]



相关链接
=============

* 敏捷开发与Gitlab CI/CD持续集成 [2]_







.. [1] https://studygolang.com/articles/14720
.. [2] 敏捷开发与Gitlab CI/CD持续集成