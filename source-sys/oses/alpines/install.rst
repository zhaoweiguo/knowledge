安装
####




安装软件::

    $ apk --help
    $ apk update
    $ apk list
    $ apk search xxx
    $ apk add zip

    update命令会从各个镜像源列表下载APKINDEX.tar.gz并存储到本地缓存
    一般在/var/cache/apk/(Alpine在该目录下)、 /var/lib/apk/ 、/etc/apk/cache/下

常用软件安装::

    $ apk add zip curl openssl
    // 安装telnet(3.7版本后)
    $ apk add busybox-extras
    $ apk add tzdata  // 时区相关
    $ apk add --no-cache <package>


增加国内源::

    $ echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories

Alpine 中软件安装包的名字可能会与其他发行版有所不同，可以在 https://pkgs.alpinelinux.org/packages 网站搜索并确定安装包名称。如果需要的安装包不在主索引内，但是在测试或社区索引中。那么可以按照以下方法使用这些安装包::

    $ echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
    $ apk --update add --no-cache <package>









