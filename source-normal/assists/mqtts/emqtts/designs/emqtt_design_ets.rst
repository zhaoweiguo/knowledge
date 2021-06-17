Mnesia/ETS 表设计
========================

Mnesia/ETS Tables::

  Table             Type    Description
  mqtt_trie         mnesia  Trie Table
  mqtt_trie_node    mnesia  Trie Node Table
  mqtt_route        mnesia  Global Route Table
  mqtt_local_route  mnesia  Local Route Table
  mqtt_pubsub       ets     PubSub Tab
  mqtt_subscriber   ets     Subscriber Tab
  mqtt_subscription ets     Subscription Tab
  mqtt_session      mnesia  Global Session Table
  mqtt_local_session ets    Local Session Table
  mqtt_client       ets     Client Table
  mqtt_retained     mnesia  Retained Message Table

Erlang 设计相关::

  1.使用 Pool, Pool, Pool… 推荐 GProc 库: https://github.com/uwiger/gproc
  2.异步，异步，异步消息…连接层到路由层异步消息，同步请求用于负载保护
  3.避免进程 Mailbox 累积消息，负载高的进程可以使用 gen_server2
  4.消息流经的 Socket 连接、会话进程必须 Hibernate，主动回收 binary 句柄
  5.多使用 Binary 数据，避免进程间内存复制
  6.使用 ETS, ETS, ETS… Message Passing vs ETS
  7.避免 ETS 表非键值字段 select, match
  8.避免大量数据 ETS 读写, 每次 ETS 读写会复制内存，可使用 lookup_element, update_counter
  9.适当开启 ETS 表 {write_concurrency, true}
  10.保护 Mnesia 数据库事务，尽量减少事务数量，避免事务过载(overload)
  11.避免 Mnesia 数据表索引，和非键值字段 match, select








