Emqtt集群配置
====================


::

  ## 集群名
  cluster.name = emqcl

  ## Cluster discovery strategy: manual | static | mcast | dns | etcd | k8s
  cluster.discovery = manual

  ## Cluster Autoheal: on | off
  cluster.autoheal = on

  ## Clean down node of the cluster
  cluster.autoclean = 5m

EMQ Autodiscovery Strategy::

  manual: 手工命令创建集群
  static: Autocluster by static node list(静态节点列表自动集群)
  mcast: Autocluster by UDP Multicast(UDP 组播方式自动集群)
  dns: Autocluster by DNS A Record(DNS A 记录自动集群)
  etcd:  Autocluster using etcd(通过 etcd 自动集群)
  k8s: Autocluster on Kubernetes(Kubernetes 服务自动集群)

1.手工命令创建集群::

  默认配置为手动创建集群，节点通过 
  $ ./bin/emqttd_ctl join <Node> 命令加入

2.基于 static 节点列表自动集群::

  cluster.discovery = static
  ## Cluster with static node list
  cluster.static.seeds = emq1@127.0.0.1,ekka2@127.0.0.1

3.Autocluster by IP Multicast::

  cluster.discovery = mcast
  ##--------------------------------------------------------------------
  ## Cluster with multicast

  cluster.mcast.addr = 239.192.0.1
  cluster.mcast.ports = 4369,4370
  cluster.mcast.iface = 0.0.0.0
  cluster.mcast.ttl = 255
  cluster.mcast.loop = on

4.Autocluster by DNS A Record::

  cluster.discovery = dns
  ##--------------------------------------------------------------------
  ## Cluster with DNS
  cluster.dns.name = localhost
  cluster.dns.app  = ekka

5.Autocluster using etcd::

  cluster.discovery = etcd

  ##--------------------------------------------------------------------
  ## Cluster with Etcd
  cluster.etcd.server = http://127.0.0.1:2379
  cluster.etcd.prefix = emqcl
  cluster.etcd.node_ttl = 1m

6.Autocluster on Kubernetes::

  cluster.discovery = k8s

  ##--------------------------------------------------------------------
  ## Cluster with k8s
  cluster.k8s.apiserver = http://10.110.111.204:8080
  cluster.k8s.service_name = ekka
  ## Address Type: ip | dns
  cluster.k8s.address_type = ip
  ## The Erlang application name
  cluster.k8s.app_name = ekka

