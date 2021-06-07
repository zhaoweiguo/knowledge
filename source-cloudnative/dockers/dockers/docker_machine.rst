docker-machine命令
##################

Docker Machine 是 Docker 官方编排（Orchestration）项目之一，负责在多种平台上快速安装 Docker 环境。

简介::

    开发语言: Golang
    开源协议: Apache 2.0

github [1]_
官网 [2]_


Linux的安装
===========

::

    $ sudo curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine
    $ sudo chmod +x /usr/local/bin/docker-machine

检测是否安装成功::

    $ docker-machine -v
    docker-machine version 0.13.0, build 9ba6da9



.. [1] https://github.com/docker/machine
.. [2] https://docs.docker.com/machine/