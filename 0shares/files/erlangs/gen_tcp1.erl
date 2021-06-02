-module(tcp_test).
-export([
    start_server/0,
    start_client_unpack/0, start_client_packed/0
    ]).

-define(PORT, 8888).
-define(PORT2, 8889).

start_server()->
  {ok, ListenSocket} = gen_tcp:listen(?PORT, [binary,{active,false}]),
  {ok, ListenSocket2} = gen_tcp:listen(?PORT2, [binary,{active,false},{packet,2}]),
  spawn(fun() -> accept(ListenSocket) end),
  spawn(fun() -> accept(ListenSocket2) end),
  receive
    _ -> ok
  end.

accept(ListenSocket)->
  case gen_tcp:accept(ListenSocket) of
    {ok, Socket} ->
      spawn(fun() -> accept(ListenSocket) end),
      loop(Socket);
    _ ->
      ok
  end.

loop(Socket)->
  case gen_tcp:recv(Socket,0) of
    {ok, Data}->
      io:format("received message ~p~n", [Data]),
      gen_tcp:send(Socket, "receive successful"),
      loop(Socket);
    {error, Reason}->
      io:format("socket error: ~p~n", [Reason])
  end.

start_client_unpack()->
  {ok,Socket} = gen_tcp:connect({127,0,0,1},?PORT,[binary,{active,false}]),
  gen_tcp:send(Socket, "1"),
  gen_tcp:send(Socket, "2"),
  gen_tcp:send(Socket, "3"),
  gen_tcp:send(Socket, "4"),
  gen_tcp:send(Socket, "5"),
  sleep(1000).

start_client_packed()->
  {ok,Socket} = gen_tcp:connect({127,0,0,1},?PORT2,[binary,{active,false},{packet,2}]),
  gen_tcp:send(Socket, "1"),
  gen_tcp:send(Socket, "2"),
  gen_tcp:send(Socket, "3"),
  gen_tcp:send(Socket, "4"),
  gen_tcp:send(Socket, "5"),
  sleep(1000).

sleep(Count) ->
  receive
  after Count ->
    ok
  end.
