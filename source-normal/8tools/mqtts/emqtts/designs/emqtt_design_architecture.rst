架构设计
==============

EMQ1.X设计::

  The EMQ broker 1.0 is more like a network Switch or Router
  not a traditional enterprise message queue


.. figure:: /images/languages/erlangs/erl_emqtt_design_concept.png
    :width: 80%


EMQ2.X设计::

  EMQ 2.0 消息服务器将在 1.x 版本支持100万 MQTT 连接的基础上，向可管理可监控坚如磐石的稳定性方向迭代演进
  The EMQ 2.0在1.x的基础上分离了
    1.前端协议(FrontEnd)与后端集成(Backend)
    2.消息路由平面(Flow Plane)与监控管理平面(Monitor/Control Plane)

               Control Plane
           --------------------
              |            |
  FrontEnd -> | Flow Plane | -> BackEnd
              |            |
            Session      Router
           ---------------------
               Monitor Plane

Design Philosophy::

  1.Focus on handling millions of MQTT connections and routing MQTT messages between clustered nodes.
  2.Embrace Erlang/OTP, The Soft-Realtime, Low-Latency, Concurrent and Fault-Tolerant Platform.
  3.Layered Design: Connection, Session, PubSub and Router Layers.
  4.Separate the Message Flow Plane and the Control/Management Plane.
  5.Stream MQTT messages to various backends including MQ or databases.

  1.EMQ 消息服务器核心解决的问题：处理海量的并发 MQTT 连接与路由消息。
  2.充分利用 Erlang/OTP 平台软实时、低延时、高并发、分布容错的优势。
  3.连接(Connection)、会话(Session)、路由(Router)、集群(Cluster)分层。
  4.消息路由平面(Flow Plane)与控制管理平面(Control Plane)分离。
  5.支持后端数据库或 NoSQL 实现数据持久化、容灾备份与应用集成。

系统分层::

  连接层(Connection Layer)：负责 TCP、WebSocket 连接处理、MQTT 协议编解码
  会话层(Session Layer)：处理 MQTT 协议发布订阅消息交互流程
  路由层(Route Layer)：节点内路由派发 MQTT 消息
  分布层(Distributed Layer)：分布节点间路由 MQTT 消息
  认证与访问控制(ACL)：连接层支持可扩展的认证与访问控制模块
  钩子(Hooks)与插件(Plugins)：系统每层提供可扩展的钩子，支持插件方式扩展服务器





















