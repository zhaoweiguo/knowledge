brod [1]_
######################
kafka客户端

.. code-block:: erlang

  rr(brod),
  {ok, _} = application:ensure_all_started(brod),
  KafkaBootstrapEndpoints = [{"localhost", 9092}],
  Topic = <<"test-topic">>,
  Partition = 0,
  ok = brod:start_client(KafkaBootstrapEndpoints, client1),
  ok = brod:start_producer(client1, Topic, _ProducerConfig = []).


  {ok, FirstOffset} = brod:produce_sync_offset(client1, Topic, Partition, <<"key1">>, <<"value1">>),
  ok = brod:produce_sync(client1, Topic, Partition, <<"key2">>, <<"value2">>),

  SubscriberCallbackFun = fun(Partition, Msg, ShellPid = CallbackState) ->      
      ShellPid ! Msg, 
      {ok, ack, CallbackState} 
  end,

  Receive = fun() -> receive 
    Msg -> 
      Msg 
    after 1000 -> 
      timeout 
    end 
  end,
  brod_topic_subscriber:start_link(
      client1, 
      Topic, 
      Partitions=[Partition],
      _ConsumerConfig=[
        {begin_offset, FirstOffset}
      ],
      _CommittdOffsets=[], 
      message, 
      SubscriberCallbackFun,
      _CallbackState=self()),

  AckCb = fun(Partition, BaseOffset) -> 
      io:format(user, "\nProduced to partition ~p at base-offset ~p\n", [Partition, BaseOffset]) 
  end,
  ok = brod:produce_cb(client1, Topic, Partition, <<>>, [{<<"key3">>, <<"value3">>}], AckCb).
  Receive().
  Receive().

  {ok, {_, [Msg]}} = brod:fetch(KafkaBootstrapEndpoints, Topic, Partition, FirstOffset + 2), Msg.

输出::

  #kafka_message{offset = 0,key = <<"key1">>,
               value = <<"value1">>,ts_type = create,ts = 1531995555085,
               headers = []}
  #kafka_message{offset = 1,key = <<"key2">>,
                 value = <<"value2">>,ts_type = create,ts = 1531995555107,
                 headers = []}
  Produced to partition 0 at base-offset 406
  #kafka_message{offset = 2,key = <<"key3">>,
                 value = <<"value3">>,ts_type = create,ts = 1531995555129,
                 headers = []}

生产者:

.. code-block:: erlang

  % Auto start producer with default producer config
  {auto_start_producers, true}
  {default_producer_config, []}

  % Start a Producer on Demand
  brod:start_producer(_Client         = brod_client_1,
                    _Topic          = <<"brod-test-topic-1">>,
                    _ProducerConfig = []).


  % Synchronized Produce API
  brod:produce_sync(_Client    = brod_client_1,
                  _Topic     = <<"brod-test-topic-1">>,
                  _Partition = 0
                  _Key       = <<"some-key">>
                  _Value     = <<"some-value">>).
  % block calling process until Kafka confirmed the message:
  {ok, CallRef} =
    brod:produce(_Client    = brod_client_1,
               _Topic     = <<"brod-test-topic-1">>,
               _Partition = 0
               _Key       = <<"some-key">>
               _Value     = <<"some-value">>),
  brod:sync_produce_request(CallRef).


  % Produce One Message and Receive Its Offset in Kafka
  Client = brod_client_1,
  Topic  = <<"brod-test-topic-1">>,
  {ok, Offset} = brod:produce_sync_offset(Client, Topic, 0, <<>>, <<"value">>).

  % Produce with Random Partitioner
  Client = brod_client_1,
  Topic  = <<"brod-test-topic-1">>,
  PartitionFun = fun(_Topic, PartitionsCount, _Key, _Value) ->
                     {ok, crypto:rand_uniform(0, PartitionsCount)}
                 end,
  ok = brod:produce_sync(Client, Topic, PartitionFun, Key, Value).


  % Produce a Batch
  brod:produce(_Client    = brod_client_1,
             _Topic     = <<"brod-test-topic-1">>,
             _Partition = MyPartitionerFun,
             _Key       = KeyUsedForPartitioning,
             _Value     = [ 
                  #{key => "k1" value => "v1", headers = [{"foo", "bar"}]}
                  , #{key => "k2" value => "v2"}
                          ]).


  % Handle Acks from Kafka as Messages
  #brod_produce_reply{ 
        call_ref = CallRef %% returned from brod:produce
       , result   = brod_produce_req_acked
       }


Example of group consumer which commits offsets to Kafka:

.. literalinclude:: /files/erlangs/brod_my_subscriber.erl
   :language: erlang




brod-cli: A command line tool to interact with Kafka


.. code-block:: bash

  make brod-cli
  _build/brod_cli/rel/brod/bin/brod -h

  % Fetch and print metadata
  brod meta -b localhost

  % Produce a Message
  brod send -b localhost -t test-topic -p 0 -k "key" -v "value"

  % Fetch a Message
  brod fetch -b localhost -t test-topic -p 0 --fmt 'io:format("offset=~p, ts=~p, key=~s, value=~s\n", [Offset, Ts, Key, Value])'


client配置::

    restart_delay_seconds:  默认10
          How much time to wait between attempts to restart brod_client process when it crashes
          在supervisor3中使用的配置{permanent, DelaySecs}
    max_metadata_sock_retry:      默认1
          Number of retries if failed fetching metadata due to socket error
    get_metadata_timeout_seconds: 默认5
          Return timeout error from brod_client:get_metadata/2 in case the
              respons is not received from kafka in this configured time.
    reconnect_cool_down_seconds:  默认1
          Delay this configured number of seconds before retrying to
              estabilish a new connection to the kafka partition leader.
    allow_topic_auto_creation:    默认true
          By default, brod respects what is configured in broker about
             topic auto-creation. i.e. whatever auto.create.topics.enable
             is set in borker configuration.
          However if 'allow_topic_auto_creation' is set to 'false' in client
            config, brod will avoid sending metadata requests that may cause an
            auto-creation of the topic regardless of what the broker config is.
    auto_start_producers:         默认false
          If true, brod client will spawn a producer automatically when
            user is trying to call 'produce' but did not call
            brod:start_producer explicitly. Can be useful for applications
            which don't know beforehand which topics they will be working with.
    default_producer_config:      默认[]
          Producer configuration to use when auto_start_producers is true.
            @see brod_producer:start_link/4. for details about producer config
    ssl:                          默认false
          true | false | [{certfile, ...},{keyfile, ...},{cacertfile, ...}]
            When true, brod will try to upgrade tcp connection to ssl using default
            ssl options. List of ssl options implies ssl=true.
          说明:为false用gen_tcp,为true用ssl,ssl:connect(Sock, SslOpts, Timeout)
    sasl:                         默认undefined
           Credentials for SASL/Plain authentication.
           {plain, "username", "password"}
           {plain, File}
    connect_timeout:        默认5000
          Timeout when trying to connect to one endpoint.
    request_timeout:        默认240000,限制>= 1000
          Timeout when waiting for a response, socket restart when timeout.
    query_api_versions:     默认true
          Must be set to false to work with kafka versions prior to 0.10,
            When set to 'true', brod_sock will send a query request to get
            the broker supported API version ranges. When set to 'false', brod
            will alway use the lowest supported API version when sending requests
            to kafka. Supported API version ranges can be found in:
            `brod_kafka_apis:supported_versions/1'
    nolink:                 false -> 使用start还是start_link
    extra_sock_opts:        []  -> gen_tcp的socket连接相关
    client_id:              <<"kpro-client">>   -> 返回的state的client_id值
    debug:                  [Opt] -> 主用于sys:debug_options([Opt]).


partition配置::

    partition_buffer_limit:     默认512
    partition_onwire_limit:     默认1
    max_batch_size:             默认1048576(1M)
    max_retries:                默认3
    retry_backoff_ms:           默认500
    required_acks:              默认-1
    ack_timeout:                默认10000(10s)
    compression:                no_compression
    max_linger_ms:              0
    max_linger_count:           0
    produce_req_vsn:            undefined



group配置::

    partition_assignment_strategy:  roundrobin_v2
    session_timeout_seconds:        10
    heartbeat_rate_seconds:         2
    max_rejoin_attempts:            5
    rejoin_delay_seconds:           1
    offset_retention_seconds:       undefined
    offset_commit_policy:           commit_to_kafka_v2
    offset_commit_interval_seconds: 5
    protocol_name:                  roundrobin_v2


supervisor图:

.. figure:: /images/languages/erlangs/brod_sup_struct.png
    :width: 80%



源码分析
-------------

启动application::

    $> erl -name abcd@127.0.0.1 -setcookiet bbbb -pa ./_build/default/lib/*/ebin
    erl> application:ensure_all_started(brod).
        brod依赖 -> ssl,kafka_protocol,supervisor3
        kafka_protocol依赖 -> snappyer
    erl> ets:tab2list(brod_kafka_apis).
      []

    说明:
    brod_sup:init/1 ->
        brod_kafka_apis:init/1: ets表brod_kafka_apis

启动client::

    erl> Broker = [{"localhost", 9092}].
    erl> ClientId = kafka_test.
    erl> brod:start_client(Broker, ClientId, []).
    erl> ets:tab2list(brod_kafka_apis).
      [
        {<0.94.0>,
          [
            {produce_request,2},
            {fetch_request,3},
            {offsets_request,1},
            {metadata_request,2},
            {offset_fetch_request,2}
          ]
        },
        {"localhost",
          [
            {produce_request,2},
            {fetch_request,3},
            {offsets_request,1},
            {metadata_request,2},
            {offset_fetch_request,2}
          ]
        }
      ]
    erl> ets:tab2list(kafka_test).
      []

    说明:
    brod_sup:start_client/3 ->
        brod_client:start_link(Endpoints, ClientId, Config).
          新建表ClientId
          brod_client:handle_info(init, State) ->
            1.start_metadata_socket/3
              brod_sock:start_link(Parent, Host, Port, ClientId, Options).
                gen_tcp:connect(Host, Port, SockOpts, Timeout).
            2.brod_producers_sup:start_link/0
            3.brod_consumers_sup:start_link/0


启动producer::

    erl> ProducerTopic= <<"nbiot-producer-topic">>.
    erl> brod:start_producer(ClientId, ProducerTopic, []).
    erl> ets:tab2list(kafka_test).                        
      [
        {
          {topic_metadata,<<"nbiot-producer-topic">>},
          1,
          {1548,141275,434124}
        },
       {
          {producer,<<"nbiot-producer-topic">>,0},
          <0.10215.0>
        }
      ]

    说明:

      -define(PRODUCER_KEY(Topic, Partition), {producer, Topic, Partition}).
      1. 从ets表kafka_test中按key:{topic_metadata,<<"nbiot-producer-topic">>}取数据
        1.1 第1次肯定为[],给brod_client发call消息:get_producers_sup_pid得到producer_sup的pid
        1.2 查找此pid的children,第1次也是[],返回{error, {producer_not_found, Topic}}
        1.3 给brod_client发call消息{auto_start_producer, Topic}
        1.4 配置中auto_start_producers为false,继续向上返回{error, {producer_not_found, Topic}}
      2. 给brod_client发call消息{start_producer, TopicName, ProducerConfig}
        2.1 会通过kafka_protocol请求kafka得到meta信息存入kafka_test表:
                {topic_metadata,<<"nbiot-producer-topic">>}, Num, Timestamp
        2.2 执行brod_producers_sup:post_init/1
        2.3 对每个partition执行:brod_producer:init/1
        2.4 往ets表kafka_test中插入数据:
                {producer,<<"nbiot-producer-topic">>,0} => Pid




.. [1] https://github.com/klarna/brod



