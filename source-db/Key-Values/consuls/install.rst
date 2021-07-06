安装
====

Precompiled Binaries::

    https://www.consul.io/downloads.html

Compiling from Source::

    $ mkdir -p $GOPATH/src/github.com/hashicorp && cd !$
    $ git clone https://github.com/hashicorp/consul.git
    $ cd consul

    $ make tools
    $ make dev


The key features of Consul are::

    1. Service Discovery
    2. Health Checking
    3. KV Store
    4. Secure Service Communication
    5. Multi Datacenter

* Consul is a distributed, highly available system. 
* Every node that provides services to Consul runs a Consul agent. 

