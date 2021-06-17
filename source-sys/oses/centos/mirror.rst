镜像源
######

CentOS7
=======

下载 CentOS 7 的 repo 文件::

    备份 CentOS 7 系统自带 yum 源配置文件: 
    $ mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    下载新的
    $ wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

更新镜像源::

    清除缓存：yum clean all
    生成缓存：yum makecache

将文件中的所有 http 开头的地址更改为 https::

    $ vim /etc/yum.repos.d/CentOS-Base.repo
    替换 http => https

更新 yum::

    $ yum update

参考
====

* CentOS 7- 配置阿里镜像源: https://developer.aliyun.com/article/704987


