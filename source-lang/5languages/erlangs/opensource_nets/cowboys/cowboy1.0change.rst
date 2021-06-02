cowboy1.0
#############
改变1.0->2.0::

  2.0要求Erlang/OTP 19.0+
  移除SPDY,支持HTTP/2
  移除Hooks,使用stream handlers替代
  Sub protocols仍然支持,但以后没有文档支持

  handler behaviors有:cowboy_handler, cowboy_loop, cowboy_rest and cowboy_websocket
  Plain HTTP, loop, REST and Websocket都有各自的init/2和terminate/3回调方法

  cowboy:start_http/4   => cowboy:start_clear/3
  cowboy:start_https/4  => cowboy:start_tls/3


websocket的handlers::

    更新connection为Websocket protocol:
      init({tcp, http}, Req, Opts) ->
          {upgrade, protocol, cowboy_websocket}

    % upgrade the handler to my_protocol
    init(_Any, _Req, _Opts) ->
        {upgrade, protocol, my_protocol}.
    upgrade(Req, Env, Handler, HandlerOpts) ->
    % ...

    % 方法
    websocket_handle/3: 
      receive data from the client
    websocket_info/3: 
      receive data from the server
    websocket_terminate/3:
      websocket终止时
    websocket_init/3:
      websockt开始时


websock实例::

    -module(my_ws_handler).
    -behavior(cowboy_websocket_handler).

    -export([init/3]).
    -export([websocket_handle/3, websocket_info/3]).
    -export([websocket_init/3, websocket_terminate/3]).

    init({tcp, http}, Req, Opts) ->
        {upgrade, protocol, cowboy_websocket}.

    websocket_init(TransportName, Req, _Opts) ->
        erlang:start_timer(1000, self(), <<"hello">>,
        {ok, Req, undefined_state}.

    websocket_handle({text, Msg}, Req, State) ->
        {reply, {text, <<"That's what she said!", Msg/binary>>}, Req, State};
    websocket_handle(_Data, Req, State) ->
        {ok, Req, State}.

    websocket_info({timeout, _Ref, Msg}, Req, State) ->
        erlang:start_timer(1000, self(), <<"How' you doin'?">>),
        {reply, {text, Msg}, Req, State};
    websocket_info(_Info, Req, State) ->
        {ok, Req, State}.

    websocket_terminate(_Reason, _Req, _State) ->
        ok.

