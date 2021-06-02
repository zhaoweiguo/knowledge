-module(demo_lager_server).

-lager_records([{state, []}]).

-author("zhaoweiguo").

-behaviour(gen_server).

-export([start_link/0, stop/0]).

-export([init/1, handle_call/3, handle_cast/2,
         handle_info/2, terminate/2, code_change/3]).

-record(state, {}).

start_link() ->
    gen_server:start_link(demo_lager_server, [], []).

stop() -> gen_server:call(self(), stop).

init([]) ->
    case {whereis(lager_event), whereis(lager_event),
          lager_config:get({lager_event, loglevel}, {0, []})}
        of
      {undefined, undefined, _} ->
          fun () -> {error, lager_not_running} end();
      {undefined, _, _} ->
          fun () -> {error, {sink_not_configured, lager_event}}
          end();
      {__Piddemo_lager_server37, _,
       {__Leveldemo_lager_server37,
        __Tracesdemo_lager_server37}}
          when __Leveldemo_lager_server37 band 64 /= 0 orelse
                 __Tracesdemo_lager_server37 /= [] ->
          lager:do_log(info,
                       [{application, demo_lager}, {module, demo_lager_server},
                        {function, init}, {line, 37},
                        {pid, pid_to_list(self())}, {node, node()}
                        | lager:md()],
                       "client process start", none, 4096, 64,
                       __Leveldemo_lager_server37, __Tracesdemo_lager_server37,
                       lager_event, __Piddemo_lager_server37);
      _ -> ok
    end,
    {ok, #state{}, 1000}.

handle_call(_Request, _From, State) ->
    case {whereis(lager_event), whereis(lager_event),
          lager_config:get({lager_event, loglevel}, {0, []})}
        of
      {undefined, undefined, _} ->
          fun () -> {error, lager_not_running} end();
      {undefined, _, _} ->
          fun () -> {error, {sink_not_configured, lager_event}}
          end();
      {__Piddemo_lager_server42, _,
       {__Leveldemo_lager_server42,
        __Tracesdemo_lager_server42}}
          when __Leveldemo_lager_server42 band 64 /= 0 orelse
                 __Tracesdemo_lager_server42 /= [] ->
          lager:do_log(info,
                       [{application, demo_lager}, {module, demo_lager_server},
                        {function, handle_call}, {line, 42},
                        {pid, pid_to_list(self())}, {node, node()}
                        | lager:md()],
                       "handle_call _Request = ~p", [_Request], 4096, 64,
                       __Leveldemo_lager_server42, __Tracesdemo_lager_server42,
                       lager_event, __Piddemo_lager_server42);
      _ -> ok
    end,
    {reply, ok, State}.

handle_cast(_Request, State) ->
    case {whereis(lager_event), whereis(lager_event),
          lager_config:get({lager_event, loglevel}, {0, []})}
        of
      {undefined, undefined, _} ->
          fun () -> {error, lager_not_running} end();
      {undefined, _, _} ->
          fun () -> {error, {sink_not_configured, lager_event}}
          end();
      {__Piddemo_lager_server46, _,
       {__Leveldemo_lager_server46,
        __Tracesdemo_lager_server46}}
          when __Leveldemo_lager_server46 band 64 /= 0 orelse
                 __Tracesdemo_lager_server46 /= [] ->
          lager:do_log(info,
                       [{application, demo_lager}, {module, demo_lager_server},
                        {function, handle_cast}, {line, 46},
                        {pid, pid_to_list(self())}, {node, node()}
                        | lager:md()],
                       "handle_cast _Request", [_Request], 4096, 64,
                       __Leveldemo_lager_server46, __Tracesdemo_lager_server46,
                       lager_event, __Piddemo_lager_server46);
      _ -> ok
    end,
    {noreply, State}.

handle_info(_Info, State) ->
    F = fun (_) ->
                case {whereis(lager_event), whereis(lager_event),
                      lager_config:get({lager_event, loglevel}, {0, []})}
                    of
                  {undefined, undefined, _} ->
                      fun () -> {error, lager_not_running} end();
                  {undefined, _, _} ->
                      fun () -> {error, {sink_not_configured, lager_event}}
                      end();
                  {__Piddemo_lager_server51, _,
                   {__Leveldemo_lager_server51,
                    __Tracesdemo_lager_server51}}
                      when __Leveldemo_lager_server51 band 64 /= 0 orelse
                             __Tracesdemo_lager_server51 /= [] ->
                      lager:do_log(info,
                                   [{application, demo_lager},
                                    {module, demo_lager_server},
                                    {function, handle_info}, {line, 51},
                                    {pid, pid_to_list(self())}, {node, node()}
                                    | lager:md()],
                                   "=======>> handle_info _Info=======>> "
                                   "handle_info _Info = ~p",
                                   [_Info], 4096, 64,
                                   __Leveldemo_lager_server51,
                                   __Tracesdemo_lager_server51, lager_event,
                                   __Piddemo_lager_server51);
                  _ -> ok
                end,
                ok
        end,
    lists:foreach(F, lists:seq(1, 100)),
    {noreply, State, 100}.

terminate(_Reason, _State) ->
    case {whereis(lager_event), whereis(lager_event),
          lager_config:get({lager_event, loglevel}, {0, []})}
        of
      {undefined, undefined, _} ->
          fun () -> {error, lager_not_running} end();
      {undefined, _, _} ->
          fun () -> {error, {sink_not_configured, lager_event}}
          end();
      {__Piddemo_lager_server67, _,
       {__Leveldemo_lager_server67,
        __Tracesdemo_lager_server67}}
          when __Leveldemo_lager_server67 band 64 /= 0 orelse
                 __Tracesdemo_lager_server67 /= [] ->
          lager:do_log(info,
                       [{application, demo_lager}, {module, demo_lager_server},
                        {function, terminate}, {line, 67},
                        {pid, pid_to_list(self())}, {node, node()}
                        | lager:md()],
                       "terminate", none, 4096, 64, __Leveldemo_lager_server67,
                       __Tracesdemo_lager_server67, lager_event,
                       __Piddemo_lager_server67);
      _ -> ok
    end,
    ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

