%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 七月 2018 下午1:17
%%%-------------------------------------------------------------------
-module(demo_lager_server).
-author("zhaoweiguo").

-behaviour(gen_server).

%% API
-export([start_link/0, stop/0]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).


-record(state, {}).
-define(DELAY, 750).

start_link() ->
  gen_server:start_link(?MODULE, [], []).

stop() -> gen_server:call(self(), stop).



init([]) ->
  lager:info("client process start"),
  {ok, #state{},1000}.  % 1秒执行一次gen_info()
  %{ok, #state{}}.

handle_call(_Request, _From, State) ->
  lager:info("handle_call _Request = ~p",[_Request]),
  {reply, ok, State}.

handle_cast(_Request, State) ->
  lager:info("handle_cast _Request",[_Request]),
  {noreply, State}.

handle_info(_Info, State) ->
  F = fun(_)->
    lager:info("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:debug("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:error("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:notice("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:warning("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:critical("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:alert("=======>> handle_info _Info = ~p",[_Info]),
%%    lager:emergency("=======>> handle_info _Info = ~p",[_Info]),
    ok
      end,
  % F2 = spawn(F),  % 并发执行用这个
  lists:foreach(F,lists:seq(1,100)),
  {noreply, State,100}.


terminate(_Reason, _State) ->
  lager:info("terminate"),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.






