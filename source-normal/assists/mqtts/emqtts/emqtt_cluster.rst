Emqtt分布集群
===================

::

  (node1@127.0.0.1)1> net_kernel:connect_node('node2@127.0.0.1').
  (node1@127.0.0.1)4> nodes().

  // epmd(Erlang Port Mapper Daemon) 
  // Erlang 端口映射服务程序
  // 自启动，负责映射节点名称到通信 TCP 端口号
  (node1@127.0.0.1)6> net_adm:names().

Cookie::

  1. $HOME/.erlang.cookie
  2. erl -setcookie <Cookie>
  本节内容来自: http://erlang.org/doc/reference_manual/distributed.html


Cluster Design::

  emqttd broker的cluster架构是基于distributed Erlang/OTP and Mnesia database.
  两条规则:
  1.MQTT客户端在一个node上SUBSCRIBE一个Topic时，这个node会广播告知此cluster上的所有其他node:I subscribed a Topic.
  2.MQTT客户端在一个node上PUBLISH一个Topic时，这个结点会lookup这个Topic表，并把Message转寄到subscribe了此Topic的所有结点
  // 这就形成了一个global route table，如:
  topic1 -> node1, node2
  topic2 -> node3

Topic Trie and Route Table::

  Every node in the cluster will store a topic trie and route table in mnesia database.
  // 表
  客户端   节点    订阅主题
  client1 node1 t/+/x, t/+/y
  client2 node2 t/#
  client3 node3 t/+/x, t/a
  最终形成的Topic Trie and Route Table:
  --------------------------
  |          t             |
  |         / \            |
  |        +   #           |
  |      /  \              |
  |    x      y            |
  --------------------------
  | t/+/x -> node1, node3  |
  | t/+/y -> node1         |
  | t/#   -> node2         |
  | t/a   -> node3         |
  --------------------------

Message Route and Deliver::

  // client1 往topic ‘t/a’上PUBLISH一条消息
  // 这消息的路由和派发流程如下:
  client1->node1: Publish[t/a]
  node1-->node2: Route[t/#]
  node1-->node3: Route[t/a]
  node2-->client2: Deliver[t/#]
  node3-->client3: Deliver[t/a]


.. figure:: /images/languages/erlangs/erl_emqtt_cluster_route.png
    :width: 50%

Network Partition and Autoheal（集群脑裂与自动愈合EMQ R2.3）::

  //Enable autoheal of Network Partition:
  cluster.autoheal = on
  When network partition occurs,集群脑裂自动恢复流程:

  1.Node reports the partitions to a leader node which has the oldest guid.
  2.Leader node create a global netsplit view and choose one node in the majority as coordinator.
  3.Leader node requests the coordinator to autoheal the network partition.
  4.Coordinator node reboots all the nodes in the minority side.

  1.节点收到 Mnesia库 的 inconsistent_database 事件3秒后进行集群脑裂确认；
  2.节点确认集群脑裂发生后，向 Leader 节点(集群中最早启动节点)上报脑裂消息；
  3.Leader 节点延迟一段时间后，在全部节点在线状态下创建脑裂视图(SplitView)；
  4.Leader 节点在多数派(majority)分区选择集群自愈的 Coordinator 节点；
  5.Coordinator 节点重启少数派(minority)分区节点恢复集群。


Node down and Autoclean（集群节点自动清除）::

  //A down node will be removed from the cluster if autoclean is enabled:
  cluster.autoclean = 5m

Session across Nodes::

  EMQ 消息服务器集群模式下，MQTT 连接的持久会话(Session)跨节点:
  如负载均衡的两台集群节点: node1 与 node2，
  同一 MQTT 客户端先连接 node1，
  node1 节点会创建持久会话；
  客户端断线重连到 node2 时，
  MQTT 的连接在 node2 节点，持久会话仍在 node1 节点:
  因而connection在node2,而session还在node1

                              node1
                                -----------
                            |-->| session |
                            |   -----------
              node2         |
           --------------   |
  client-->| connection |<--|
           --------------

The Firewall::

  如果集群节点间存在防火墙，防火墙需要开启 4369 端口和一个 TCP 端口段
  1.4369 由 epmd 端口映射服务使用
  2.TCP 端口段用于节点间建立连接与通信

  防火墙设置后，EMQ 需要配置相同的端口段，emqttd/etc/emq.conf 文件:
  ## Distributed node port range
  node.dist_listen_min = 6369
  node.dist_listen_max = 7369

Consistent Hash and DHT（一致性 Hash 与 DHT）::

  NoSQL 数据库领域分布式设计，大多会采用一致性 Hash 或 DHT
  Cluster of emqttd broker could support 10 million size of global routing table now. 
  更大级别的集群可采用一致性 Hash、DHT 或 Shard 方式切分路由表






