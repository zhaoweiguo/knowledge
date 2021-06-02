etcd命令
########

有3种配置方式::

    1. configuration file
    2. various command-line flags
    3. environment variables    

环境变量格式::

    ETCD_后面跟对应大写的flag，如:
    --my-flag   => ETCD_MY_FLAG
    --config-file flag => ETCD_CONFIG_FILE
    ...

使用配置文件注意::

    1. 配置文件使用: --config-file flag
    2. 使用配置文件时其他flag会被忽略，如:
       $ etcd --config-file etcd.conf.yml.sample --data-dir /tmp 
       // will ignore the --data-dir flag


Member flags
============


--name::

    default: “default”

--data-dir::

    default: “${name}.etcd”
    数据保存的路径

--heartbeat-interval::

    default: “100”(milliseconds)

--election-timeout::

    default: “1000”(milliseconds)
    重新投票的超时时间，如果 follower 在该时间间隔没有收到心跳包，会触发重新投票
    注: 注意此值与--heartbeat-interval值的关系


--listen-peer-urls::

    default: “http://localhost:2380”

    和同伴通信的地址
    List of URLs to listen on for peer traffic

--listen-client-urls::

    default: “http://localhost:2379”

    说明:
      对外提供服务的地址，客户端会连接到这里和 etcd 交互

    List of URLs to listen on for client traffic. 





Clustering flags
================

--initial-advertise-peer-urls::

    default: “http://localhost:2380”

    说明:
      该节点同伴监听地址，这个值会告诉集群中其他节点
      List of this member’s peer URLs to advertise to the rest of the cluster. 
      These addresses are used for communicating etcd data around the cluster. 
      At least one must be routable to all cluster members.



--initial-cluster::

    default: “default=http://localhost:2380”
    格式: <name1>=<peer-urls1>,<name2>=<peer-urls2>,...
    注:
      <name1>: 是节点用--name指定的名字
      <peer-urls1>: 是用--initial-advertise-peer-urls 指定的值

    说明:
      Initial cluster configuration for bootstrapping.
      在启动时初使化集群配置(即: 集群中所有节点的信息)

--initial-cluster-state::

    default: “new”
    可用值: (“new” or “existing”)

    说明:
        Initial cluster state 
        1. new: 新建集群时:
        Set to new for all members present during initial static or DNS bootstrapping. 
        2. existing: 已存在集群时:
        If this option is set to existing, etcd will attempt to join the existing cluster. 

--initial-cluster-token::

    default: “etcd-cluster”

    说明:
      创建集群的 token，这个值每个集群保持唯一
      这样，如果你要重新创建集群
        即使配置和之前一样，也会再次生成新的集群和节点 uuid
        否则会导致多个集群之间的冲突，造成未知的错误

.. note:: --init 开头的配置都是在第一次启动 etcd 集群的时候才会用到，后续节点的重启会被忽略。如果服务已经运行过就要把修改 --initial-cluster-state 为 existing




--advertise-client-urls::

    default: “http://localhost:2379”

    说明:
      对外公告的该节点客户端监听地址，这个值会告诉集群中其他节点
      List of this member’s client URLs to advertise to the rest of the cluster





--discovery::

    prefix flags need to be set when using discovery service.

Proxy flags
===========

--proxy::

    default: “off”
    
    Proxy mode setting 
    (“off”, “readonly” or “on”).

--proxy-failure-wait::

    default: 5000(milliseconds)
    Time an endpoint will be held in a failed state before being reconsidered for proxied requests

.. note::  1、proxy 只支持 API v2，不支持 v3；2、在服务发现集群模式下，多启动的 etcd 节点将会自动降级成读写模式的代理；3、代理不会自动变成 etcd 集群节点



Security flags
==============

--cert-file::

    default: ""
    Path to the client server TLS cert file.

--key-file::

    default: ""
    Path to the client server TLS key file

--peer-cert-file::

    default: ""
    Path to the peer server TLS cert file. 
    This is the cert for peer-to-peer traffic, used both for server and client.

--peer-key-file::

    default: ""
    Path to the peer server TLS key file. 
    This is the key for peer-to-peer traffic, used both for server and client.

--cipher-suites::

    default: ""
    Comma-separated list of supported TLS cipher suites between server/client and peers.


Logging flags
=============

--logger::

    default: capnslog
    可选值: 
      zap: for structured logging
      capnslog: 默认

    Available from v3.4
    WARNING: --logger=capnslog to be deprecated in v3.5.


--log-outputs::

    default: default
    Specify ‘stdout’ or ‘stderr’ to skip journald logging even when running under systemd, 
        or list of comma separated output targets.


--log-level::

    default: info
    Configures log level. Only supports debug, info, warn, error, panic, or fatal.

--debug::

    default: false (INFO for all packages)
    Drop the default log level to DEBUG for all subpackages.



Unsafe flags
============

--force-new-cluster::

    default: false



Miscellaneous flags
===================

--version::

    default: false
    Print the version and exit.

--config-file::

    default: ""
    
    Load server configuration from a file. 
    Note that if a configuration file is provided, 
      other command line flags and environment variables will be ignored.



Profiling flags
===============

--enable-pprof::

    default: false
    Enable runtime profiling data via HTTP server. 
    Address is at client URL + “/debug/pprof/”

--metrics::

    default: basic

    Set level of detail for exported metrics, 
        specify ‘extensive’ to include server side grpc histogram metrics.

--listen-metrics-urls::

    default: ""
    List of additional URLs to listen on that will respond to both the /metrics and /health endpoints


Auth flags
==========

--auth-token::

    default: “simple”
    format: “type,var1=val1,var2=val2,…"

    实例:
    --auth-token jwt,pub-key=app.rsa.pub,priv-key=app.rsa,sign-method=RS512,ttl=10m

参考
====

* 官网,Configuration flags: https://etcd.io/docs/current/op-guide/configuration/








