ksonnet命令
###########

* github [1]_

说明::

    是一个基于jsonnet的快速简化kubernetes yaml 配置的工具，可以实现配置的复用
    同时也包含一个registry 的概念，可以实现可复用组件的分发，同时支持helm

安装
====

mac::

    $ brew install ksonnet/tap/ks

检测::

    $ ks version
    ksonnet version: 0.11.0
    jsonnet version: v0.10.0
    client-go version:

使用
====

初使化::

    $ ks init dalongdemo


.. [1] https://github.com/ksonnet/ksonnet