常用
####

基本使用-一个Agent的开发模式
============================

# Agent的开发模式::

    [root@local13 ~]# ./consul agent -dev
    ==> Starting Consul agent...
    ==> Consul agent running!

# 查看集群成员::

    [root@local13 ~]# ./consul members
    Node     Address         Status  Type    Build  Protocol  DC   Segment
    local13  127.0.0.1:8301  alive   server  1.2.2  2         dc1  <all>

# 使用 HTTP API 查看::

    [root@local13 ~]# curl localhost:8500/v1/catalog/nodes
    [
        {
            "ID": "796b14fe-1332-4aa0-d96f-8f287a4ccc7e",
            "Node": "local13",
            "Address": "127.0.0.1",
            "Datacenter": "dc1",
            "TaggedAddresses": {
                "lan": "127.0.0.1",
                "wan": "127.0.0.1"
            },
            "Meta": {
                "consul-network-segment": ""
            },
            "CreateIndex": 9,
            "ModifyIndex": 10
        }
    ]

# 还可以使用 DNS 接口来查询节点（默认端口：8600::

    [root@local13 ~]# yum install bind-utils
    [root@local13 ~]# dig @127.0.0.1 -p 8600 local13.node.consul
    ...
    ;; QUESTION SECTION:
    ;local13.node.consul.       IN  A
    ;; ANSWER SECTION:
    local13.node.consul.    0   IN  A   127.0.0.1
    ...

注册服务
========

定义一个服务::


    [root@local13 ~]# mkdir /etc/consul.d
    [root@local13 ~]# echo '{"service": {"name": "web", "tags": ["rails"], "port": 80}}'  | sudo tee /etc/consul.d/web.json
    [root@local13 ~]# ./consul agent -dev -config-dir=/etc/consul.d

# 使用 DNS API::

    [root@local13 ~]# dig @127.0.0.1 -p 8600 web.service.consul
    ...
    ;; QUESTION SECTION:
    ;web.service.consul.        IN  A
    ;; ANSWER SECTION:
    web.service.consul. 0   IN  A   127.0.0.1

# 使用 DNS API 查找 SRV 记录::

    [root@local13 ~]# dig @127.0.0.1 -p 8600 web.service.consul SRV
    ...
    ;; QUESTION SECTION:
    ;web.service.consul.        IN  SRV
    ;; ANSWER SECTION:
    web.service.consul. 0   IN  SRV 1 1 80 local13.node.dc1.consul.
    ;; ADDITIONAL SECTION:
    local13.node.dc1.consul. 0  IN  A   127.0.0.1
    ...

# 使用 HTTP API 查询::

    [root@local13 ~]# curl http://localhost:8500/v1/catalog/service/web
    # 健康检查
    [root@local13 ~]# curl 'http://localhost:8500/v1/health/service/web?passing'

Consul集群
==========

创建node1，consul server::

    [root@local12 ~]# ./consul agent \
    -server \
    -bootstrap-expect=1  \
    -data-dir=/tmp/consul \
    -node=agent-one \
    -bind=192.168.56.112 \
    -enable-script-checks=true \
    -config-dir=/etc/consul.d \
    -client 0.0.0.0 \
    -ui
    # -node: 节点的名称 
    # -bind: 绑定的一个地址，用于节点之间通信的地址 
    # -server: 这个就是表示这个节点是个SERVER
    # -bootstrap-expect: 这个就是表示期望提供的SERVER节点数目,数目一达到就会被激活,生成LEADER
    # -dc: 指明数据中心的名字
    # -client 0.0.0.0 
    # -ui: 启动UI（为了方便后续的UI访问）

创建node2,consul client::

    [root@local13 ~]# ./consul agent -data-dir=/tmp/consul \
    -node=agent-two   \
    -bind=192.168.56.113 -enable-script-checks=true \
    -config-dir=/etc/consul.d \
    -ui

加入集群::

    [root@local13 ~]# ./consul join 192.168.56.112
    Successfully joined cluster by contacting 1 nodes.
    [root@local13 ~]# ./consul members
    Node       Address            Status  Type    Build  Protocol  DC   Segment
    agent-one  192.168.1.13:8301  alive   server  1.2.2  2         dc1  <all>
    agent-two  192.168.1.12:8301  alive   client  1.2.2  2         dc1  <default>

查询节点::

    [root@local13 ~]# dig @127.0.0.1 -p 8600 agent-two.node.consul
    ...
    ;; QUESTION SECTION:
    ;agent-two.node.consul.     IN  A
    ;; ANSWER SECTION:
    agent-two.node.consul.  0   IN  A   192.168.1.12

KV数据
======

基本操作::

    consul kv put redis/config/minconns 1
    consul kv put redis/config/minconns 2 # 更新
    consul kv get redis/config/minconns
    consul kv delete redis/config/minconns
    consul kv delete -recurse redis # 批量删除

WEB UI
======

* http://192.168.56.112:8500/ui


参考
====

* 链接：https://www.jianshu.com/p/7d20dc58c9fc

