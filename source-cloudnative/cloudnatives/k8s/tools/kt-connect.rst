kt-connect工具
##############

* github [2]_
* 官网 [3]_

下载安装 [1]_
=============

安装sshuttle::

    brew install sshuttle

下载并安装KT::

    $ curl -OL https://rdc-incubators.oss-cn-beijing.aliyuncs.com/stable/ktctl_darwin_amd64.tar.gz
    $ tar -xzvf ktctl_darwin_amd64.tar.gz
    $ mv ktctl_darwin_amd64 /usr/local/bin/ktctl
    $ ktctl -h

说明
====

主要需要解决以下3个问题::

    本地网络与Kubernetes集群网络直接的连通问题
    在本地实现Kubernetes中内部服务的DNS解析
    如何将对集群中其它Pod访问的流量转移到本地

选项
========

默认选项::

    namespace,n: 默认值default
    kubeconfig,c: 默认值$HOME/.kube/config
    image,i: 默认值registry.cn-hangzhou.aliyuncs.com/rdc-incubator/kt-connect-shadow:latest
    debug,d: 格式true, false
    label,l: 格式label1=val1,label2=val2


1. 本地连接集群
===============

启动::

    // 注意需要sudo权限
    $ sudo ktctl -n default -c $HOME/.kube/config connect

使用::

    直接可以在浏览器上使用内网ip打开

connect选项::

    method: 默认值vpn
    proxy: 默认值2223
    port: 默认值2222
    disableDNS: 
    cidr: 格式172.2.0.0/16
    dump2hosts: bool类型
    dump2hostsNS: 
    shareShadow: 


2. 转发集群流量到本地
==========================

* 这个命令的前提条件是 Kubernetes 集群中必须有已经存在的 Deployment，在运行该命令时，将会起一个 shadow 容器，来代替已存在的 Deployment，调用该容器的流量，都会被转发到本地的指定端口

.. warning:: 要注意的是：该命令会将其代替的 Deployment 的 replicas 设置为0，可能会导致业务的暂停，请勿在生产环境中使用！

假设本地有一个服务监控8088端口::

    $ python -m http.server 8088 &

基本使用::

    $ ktctl exchange kk-feiyan --expose 8088

查看 Deployment::

    $ kubectl get deploy | grep kk-feiyan
    kk-feiyan             0/0     0   0    39d    # 原服务
    kk-feiyan-kt-eclcc    1/1     1   1    89s    # 转发流量服务

集群内调用::

    $ curl kk-feiyan // 相当于请求本地的8088端口的服务

3. 将本地服务暴露到 Kubernetes 集群
========================================

有些时候，我们并不想使用 exchange 来代替已经存在的 Deployment，只想在集群内新建一个服务来将流量转发到本地，以完成调试。

这个时候使用 ktctl run，就可以满足需求，该命令会在 Kubernetes 集群中新建一个服务，并将访问该服务的流量被转发到本地的指定端口。

基本使用::

    $ ktctl run localservice --port 8088 --expose

查看Deployment::

    $ kubectl get deploy localservice

集群内调用::

    $ curl localservice:8088

4. Dashboard 功能
======================

* 管理所有使用 kt 连入集群的用户

5. Service Mesh 支持
=========================

* 支持用户可以基于Service Mesh的能力做更多自定义的流量规则定义


参考
====

* `郭旭东x——Kt Connect：研发侧利器，本地连通 Kubernetes 集群内网 <https://developer.aliyun.com/article/751321>`_


.. [1] https://alibaba.github.io/kt-connect/#/zh-cn/downloads
.. [2] https://github.com/alibaba/kt-connect
.. [3] https://alibaba.github.io/kt-connect/