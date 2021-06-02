安装与卸载
##########

* 官网: https://docs.docker.com/compose/install/

验证是否安装::

    $ docker-compose --version
    docker-compose version 1.17.1, build 6d101fb

二进制包安装::

    $ sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    $ sudo chmod +x /usr/local/bin/docker-compose

PIP 安装::

    $ sudo pip install -U docker-compose

容器中执行::

    # 本质是下载了 docker/compose 镜像并运行
    $ curl -L https://github.com/docker/compose/releases/download/1.8.0/run.sh > /usr/local/bin/docker-compose
    $ chmod +x /usr/local/bin/docker-compose


bash 补全命令::

    $ curl -L https://raw.githubusercontent.com/docker/compose/1.8.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

卸载::

    1. 如果是二进制包方式安装的，删除二进制文件即可
    $ sudo rm /usr/local/bin/docker-compose

    2. 如果是通过 pip 安装的，则执行如下命令即可删除
    $ sudo pip uninstall docker-compose







