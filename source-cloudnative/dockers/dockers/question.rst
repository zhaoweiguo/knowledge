常见问题
############

Docker.raw占用过多的磁盘空间
===============================

::
    
    $ cd ~/Library/Containers/com.docker.docker/Data/vms/0
    $ zhaoweiguo$ ls -lh Docker.raw
    -rw-r--r--@ 1 zhaoweiguo  staff    15G Jun 25 13:56 Docker.raw
    // 使用ls命令占用15G，而使用du命令占用只有3.6G    
    $ du -hs Docker.raw
    3.6G  Docker.raw

原因::

    // ls默认列出的是逻辑大小而不是物理大小, 物理大小要使用-ks
    $ zhaoweiguo$ ls -lhks Docker.raw
    3728116 -rw-r--r--@ 1 zhaoweiguo  staff    15G Jun 25 13:56 Docker.raw

    此例中,逻辑大小是15G,物理大小是3.6G

证书问题
============

问题::

    Get https://zhaoweiguo.com/auth: x509: certificate signed by unknown authority
    panic: Get https://zhaoweiguo.com/auth: x509: certificate signed by unknown authority

解决::

    alpine镜像, 增加一条语句:
    RUN apk add --no-cache ca-certificates

挂载的目录没有权限
==================

问题::

    $host> docker run -v /tmp/zwg:/data --name xinxi alpine
    $host> docker exec -it xinxi /bin/bash
    $docker> touch /data/abc
    cannot touch /data/abc: Permission denied

原因::

    centos7中安全模块selinux把权限禁掉了

解决方案::

    1. 在运行时加 --privileged=true
    2. 临时关闭selinux然后再打开
    $> setenforce 0     // 关闭
    ...
    $> setenforce 1     // 再打开
    3. 添加linux规则，把要挂载的目录添加到selinux白名单
    chcon [-R] [-t type] [-u user] [-r role] 文件或者目录
    选顷不参数：
    -R  ：该目录下的所有目录也同时修改；
    -t  ：后面接安全性本文的类型字段，例如 httpd_sys_content_t ；
    -u  ：后面接身份识别，例如 system_u；
    -r  ：后面街觇色，例如 system_r
    实例:
    chcon -Rt svirt_sandbox_file_t /tmp

Networking will not work
========================

问题::

    ---> [Warning] IPv4 forwarding is disabled. Networking will not work.
    ---> Running in 10ad6724b3b8

原因::

    容器要想访问外部网络，需要本地系统的转发支持

定位::

    在Linux 系统中，检查转发是否打开:
    $sysctl net.ipv4.ip_forward
    net.ipv4.ip_forward = 0         # 如果为0说明没有开启转发

解决::

    方法1(手动打开):
    $sysctl -w net.ipv4.ip_forward=1

    方法2(启动时指定):
    如果在启动 Docker 服务的时候设定 --ip-forward=true, Docker 就会自动设定系统的 ip_forward 参数为 1












