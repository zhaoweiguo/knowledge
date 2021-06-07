网络相关
########

容器间访问
==========

容器之间相互访问，需要两方面的支持::

    容器的网络拓扑是否已经互联。默认情况下，所有容器都会被连接到 docker0 网桥上。
    本地系统的防火墙软件 -- iptables 是否允许通过。

访问所有端口::

    当启动 Docker 服务时候，默认会添加一条转发策略到 iptables 的 FORWARD 链上。
    策略为通过（ACCEPT）还是禁止（DROP）取决于配置--icc=true（缺省值）还是 --icc=false。
    当然，如果手动指定 --iptables=false 则不会添加 iptables 规则。

    可见，默认情况下，不同容器之间是允许网络互通的。
    如果为了安全考虑，可以在 /etc/default/docker 文件中配置 DOCKER_OPTS=--icc=false 来禁止它。

访问指定端口::

    在通过 -icc=false 关闭网络访问后，还可以通过 --link=CONTAINER_NAME:ALIAS 选项来访问容器的开放端口。

    例如:
    在启动 Docker 服务时，可以同时使用 ``icc=false --iptables=true`` 参数来
        关闭允许相互的网络访问，并让 Docker 可以修改系统中的 iptables 规则。

此时，系统中的 iptables 规则可能是类似::

    $ sudo iptables -nL
    ...
    Chain FORWARD (policy ACCEPT)
    target     prot opt source               destination
    DROP       all  --  0.0.0.0/0            0.0.0.0/0
    ...

当添加了 --link=CONTAINER_NAME:ALIAS 选项后，添加了 iptables 规则::

    $ sudo iptables -nL
    ...
    Chain FORWARD (policy ACCEPT)
    target     prot opt source               destination
    ACCEPT     tcp  --  172.17.0.2           172.17.0.3           tcp spt:80
    ACCEPT     tcp  --  172.17.0.3           172.17.0.2           tcp dpt:80
    DROP       all  --  0.0.0.0/0            0.0.0.0/0


映射容器端口到宿主主机的实现
============================

使用 -P 时(把80端口映射一个随机主机端口49153)::

    $ iptables -t nat -nL
    ...
    Chain DOCKER (2 references)
    target     prot opt source               destination
    DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:49153 to:172.17.0.2:80

使用 -p 80:80 时(把80端口映射到主机的80端口)::

    $ iptables -t nat -nL
    Chain DOCKER (2 references)
    target     prot opt source               destination
    DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:80 to:172.17.0.2:80














