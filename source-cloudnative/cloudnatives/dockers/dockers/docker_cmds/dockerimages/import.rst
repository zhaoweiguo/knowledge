docker import
######################

格式::

    $ docker import [选项] <文件>|<URL>|- [<仓库名>[:<标签>]]
    # 压缩包可以是本地文件、远程 Web 文件，甚至是从标准输入中得到。
    # 压缩包将会在镜像 / 目录展开，并直接作为镜像第一层提交。

比如我们想要创建一个 OpenVZ 的 Ubuntu 14.04 模板的镜像::

    $ docker import \
        http://download.openvz.org/template/precreated/ubuntu-14.04-x86_64-minimal.tar.gz \
        openvz/ubuntu:14.04
    Downloading from http://download.openvz.org/template/precreated/ubuntu-14.04-x86_64-minimal.tar.gz
    sha256:f477a6e18e989839d25223f301ef738b69621c4877600ae6467c4e5289822a79B/78.42 MB

    # 这条命令自动下载了 ubuntu-14.04-x86_64-minimal.tar.gz 文件，
        并且作为根文件系统展开导入，并保存为镜像 openvz/ubuntu:14.04

如果我们查看其历史的话，会看到描述中有导入的文件链接::

    $ docker history openvz/ubuntu:14.04
    IMAGE               CREATED                SIZE                COMMENT
    f477a6e18e98        About a minute ago    214.9 MB            Imported from http://download.openvz.org/template/precreated/ubuntu-14.04-x86_64-minimal.tar.gz



实例-Docker导入本地镜像(导出参见export)::

    $ cat ubuntu.tar | docker import - test/ubuntu:v1.0
    $ docker image ls
    REPOSITORY          TAG                 IMAGE ID            CREATED              VIRTUAL SIZE
    test/ubuntu         v1.0                9d37a6082e97        About a minute ago   171.3 MB


