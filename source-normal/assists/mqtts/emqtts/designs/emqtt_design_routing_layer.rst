Routing路由层
==================

The PubSub layer maintains a subscription table and is responsible to dispatch MQTT messages to subscribers:

.. figure:: /images/languages/erlangs/erl_emqtt_design_pubsub.png
    :width: 50%

MQTT messages will be dispatched to the subscriber’s session, which finally delivers the messages to client.


topic trie and route table::

  // node1 subscribed ‘t/+/x’ and ‘t/+/y’
  // node2 subscribed ‘t/#’
  // node3 subscribed ‘t/a’
  -------------------------
  |            t          |
  |           / \         |
  |          +   #        |   => Topic Trie
  |        /  \           |
  |      x      y         |
  -------------------------
  | t/+/x -> node1, node3 |
  | t/+/y -> node1        |
  | t/#   -> node2        |   => Route Table
  | t/a   -> node3        |
  -------------------------

The routing design follows two rules::

  1.A message only gets forwarded to other cluster nodes 
    if a cluster node is interested in it. 
    This reduces the network traffic tremendously, 
    because it prevents nodes from forwarding unnecessary messages.
  2.As soon as a client on a node subscribes to a topic 
    it becomes known within the cluster. 
    If one of the clients somewhere in the cluster is publishing to this topic, 
    the message will be delivered to its subscriber no matter to which cluster node it is connected.











