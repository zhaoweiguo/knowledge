cowboy_websocket
#####################
init::

  init(Req, State) ->
    {cowboy_websocket, Req, State}.

Subprotocol::

  //client可解析基于Websocket的两种子协议STOMP和MQTT,提供header:
  sec-websocket-protocol: v12.stomp, mqtt
  //sever只能解析mqtt:
  sec-websocket-protocol: mqtt

  % 实例:
  init(Req0, State) ->
    case cowboy_req:parse_header(<<"sec-websocket-protocol">>, Req0) of
        undefined ->
            {cowboy_websocket, Req0, State};
        Subprotocols ->
            case lists:keymember(<<"mqtt">>, 1, Subprotocols) of
                true ->
                    Req = cowboy_req:set_resp_header(<<"sec-websocket-protocol">>,
                        <<"mqtt">>, Req0),
                    {cowboy_websocket, Req, State};
                false ->
                    Req = cowboy_req:reply(400, Req0),
                    {ok, Req, State}
            end
    end.

Post-upgrade initialization::

  websocket处理connection and requests的是两个不同进程
  @xinxi说: 其实这儿已经把websocket的连接了请求分开了
  init/2用于处理request
  websocket_用于处理connetction

  websocket_init/1:
  websocket_init(State) ->
    erlang:start_timer(1000, self(), <<"Hello!">>),
    {ok, State}.
  websocket_init(State) ->
    {reply, {text, <<"Hello!">>}, State}.

Receiving frames::

  websocket_handle/2:
  % text, binary, ping or pong
  websocket_handle(Frame = {text, _}, State) ->
    {reply, Frame, State};
  websocket_handle(_Frame, State) ->
    {ok, State}.

Receiving Erlang messages::

  websocket_info/2:
  websocket_info(Text, State) ->
    {reply, {text, Text}, State};
  websocket_info(_Info, State) ->
    {ok, State}.

Sending frames::

  所有websocket_回调共享返回值
  // 发送0帧(frame)
  websocket_info(_Info, State) ->
    {ok, State}.
  // 发送1帧
  websocket_info(_Info, State) ->
    {reply, {text, <<"Hello!">>}, State}.
  // 发送多帧
  websocket_info(_Info, State) ->
    {reply, [
        {text, "Hello"},
        {text, <<"world!">>},
        {binary, <<0:8000>>}
    ], State}.

Keeping the connection alive::

  cowboy会自动回应client发来的ping帧,但还是会把信息转发给handler,但不需要再处理

  % 设立连接超时,默认60000(60s)
  init(Req, State) ->
    {cowboy_websocket, Req, State, #{idle_timeout => 30000}}.

Limiting frame sizes::

  % 暂没有默认值
  init(Req, State) ->
    {cowboy_websocket, Req, State, #{max_frame_size => 8000000}}.

Saving memory::

  websocket_init(State) ->
    {ok, State, hibernate}.
  websocket_handle(_Frame, State) ->
    {ok, State, hibernate}.
  websocket_info(_Info, State) ->
    {reply, {text, <<"Hello!">>}, State, hibernate}.

  hibernate影响:
  1. reduce the memory usage
  2. increase in the CPU usage or latency can be observed instead, in particular for the more busy connections

Closing the connection::

  websocket_info(_Info, State) ->
      {stop, State}.
  % with reason
  websocket_info(_Info, State) ->
      {reply, {close, 1000, <<"some-reason">>}, State}.





