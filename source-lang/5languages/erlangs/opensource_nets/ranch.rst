ranch [1]_
##################

* 文档 [2]_

Listeners
--------------
handlers::

  ranch_tcp: 对gen_tcp简单封装
  ranch_ssl: 对ssl简单封装

启动::

  ok = application:start(ranch).
  {ok, _} = ranch:start_listener(tcp_echo,
    ranch_tcp, [
      {port, 5555},             % port=0,时使用随机端口>1024
      {max_connections, 100},   % 最大连接数,默认1024,可用infinity
      {num_acceptors, 42}       % 默认为10
    ],  
    echo_protocol, []
  ).


操作::

  ranch:stop_listener(tcp_echo).

  ranch:suspend_listener(tcp_echo).
  ranch:resume_listener(tcp_echo).

  % 查看
  ranch:get_status(tcp_echo)

Default transport options::

  binary
  {active, false}, {packet, raw}, {reuseaddr, true}
  % 可用以下命令覆盖
  Transport:setopts/2
  {backlog, 1024} and {nodelay, true}

Limiting the number of concurrent connections::

  % 说明: max_connections是软限制,因backlog
  %  到达max_connections时, 停止接收accepting connections
  %  实践中,最大可达: max_connections + the number of acceptors
  
  % 有些长连接会一直占connection
  % 但可能交互小,而占资源少的可通过下面方法减少个数
  ranch:remove_connection(Ref).

  ranch:set_max_connections(tcp_echo, MaxConns).

其他::

  % Upgrading
  ranch:set_protocol_options(tcp_echo, NewOpts).
  Opts = ranch:get_protocol_options(tcp_echo).

  % Changing transport options:
  ranch:set_transport_options(tcp_echo, NewOpts).
  Opts = ranch:get_transport_options(tcp_echo).

  % 信息查看
  ranch:info().
  ranch:procs(tcp_echo, acceptors).
  ranch:procs(tcp_echo, connections).

Transports
---------------
Sending and receiving data::

    Transport:send(Socket, <<"Ranch is cool!">>).
    Transport:send(Socket, "Ranch is cool!").
    Transport:send(Socket, ["Ranch", ["is", "cool!"]]).
    Transport:send(Socket, ["Ranch", [<<"is">>, "cool!"]]).

    {ok, Data} = Transport:recv(Socket, 0, 5000).

Three different messages::

    1.{OK, Socket, Data}
    2.{Closed, Socket}
    3.{Error, Socket, Reason}
    {OK, Closed, Error} = Transport:messages().

实例::

    {OK, Closed, Error} = Transport:messages(),
    Transport:setopts(Socket, [{active, once}]),  % {active, true} | {active, true}
    receive
      {OK, Socket, Data} ->
        io:format("data received: ~p~n", [Data]);
      {Closed, Socket} ->
        io:format("socket got closed!~n");
      {Error, Socket, Reason} ->
        io:format("error happened: ~p~n", [Reason])
    end.

Sending files::

    {ok, SentBytes} = Transport:sendfile(Socket, Filename).

    Opts = [{chunk_size, ChunkSize}],
    {ok, SentBytes} = Transport:sendfile(Socket, Filename, Offset, Bytes, Opts).

    {ok, RawFile} = file:open(Filename, [raw, read, binary]),
    {ok, SentBytes} = Transport:sendfile(Socket, RawFile, Offset, Bytes, Opts).

Upgrading a TCP socket to SSL::

    {ok, NewSocket} = ranch_ssl:handshake(Socket, SslOpts, 5000).

Protocols
--------------
Writing a protocol handler::

    -module(echo_protocol).
    -behaviour(ranch_protocol).

    -export([start_link/4]).
    -export([init/3]).

    start_link(Ref, _Socket, Transport, Opts) ->
      Pid = spawn_link(?MODULE, init, [Ref, Transport, Opts]),
      {ok, Pid}.

    init(Ref, Transport, _Opts = []) ->
      {ok, Socket} = ranch:handshake(Ref),
      loop(Socket, Transport).

    loop(Socket, Transport) ->
      case Transport:recv(Socket, 0, 5000) of
        {ok, Data} ->
          Transport:send(Socket, Data),
          loop(Socket, Transport);
        _ ->
          ok = Transport:close(Socket)
      end.

Using gen_statem::

  -module(my_protocol).
  -behaviour(gen_statem).
  -behaviour(ranch_protocol).

  -export([start_link/4]).
  -export([init/1]).
  %% Exports of other gen_statem callbacks here.

  start_link(Ref, _Socket, Transport, Opts) ->
    {ok, proc_lib:spawn_link(?MODULE, init, [{Ref, Transport, Opts}])}.

  init({Ref, Transport, _Opts = []}) ->
    %% Perform any required state initialization here.
    {ok, Socket} = ranch:handshake(Ref),
    ok = Transport:setopts(Socket, [{active, once}]),
    gen_statem:enter_loop(?MODULE, [], state_name, {state_data, Socket, Transport}).

Embedded mode
----------------
::

  init([]) ->
    RanchSupSpec = {ranch_sup, {ranch_sup, start_link, []},
      permanent, 5000, supervisor, [ranch_sup]},
    ListenerSpec = ranch:child_spec(echo, 100,
      ranch_tcp, [{port, 5555}],
      echo_protocol, []
    ),
    {ok, {{one_for_one, 10, 10}, [RanchSupSpec, ListenerSpec]}}.









.. [1] https://github.com/ninenines/ranch
.. [2] https://ninenines.eu/docs/

