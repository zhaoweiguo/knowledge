服务注册&发现
#############

Rather than specifying a static configuration, use an existing etcd cluster to bootstrap a new one. This process is called "discovery".

There two methods that can be used for discovery::

    1. etcd discovery service
    2. DNS SRV records

服务注册::

    1. 自注册:
        违背了单一职责原则。 此种模式下，微服务多了一项职责: 将自身状态变化事件通知给发现服务 。
    2. 第三方注册

服务发现::

    1. 客户端发现:
        实例: Eureka, etcd...
        违背了单一职责原则。
    2. 服务端发现
        API网关




参考
====

* etcd发现协议: https://github.com/etcd-io/etcd/blob/master/Documentation/dev-internal/discovery_protocol.md