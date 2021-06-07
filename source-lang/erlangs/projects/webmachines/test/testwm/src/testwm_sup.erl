%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Supervisor for the testwm application.

-module(testwm_sup).
-author('author <author@example.com>').

-behaviour(supervisor).

%% External exports
-export([start_link/0, upgrade/0]).

%% supervisor callbacks
-export([init/1]).

%% @spec start_link() -> ServerRet
%% @doc API for starting the supervisor.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @spec upgrade() -> ok
%% @doc Add processes if necessary.
upgrade() ->
    {ok, {_, Specs}} = init([]),

    Old = sets:from_list(
            [Name || {Name, _, _, _} <- supervisor:which_children(?MODULE)]),
    New = sets:from_list([Name || {Name, _, _, _, _, _} <- Specs]),
    Kill = sets:subtract(Old, New),

    sets:fold(fun (Id, ok) ->
                      supervisor:terminate_child(?MODULE, Id),
                      supervisor:delete_child(?MODULE, Id),
                      ok
              end, ok, Kill),

    [supervisor:start_child(?MODULE, Spec) || Spec <- Specs],
    ok.

%% @spec init([]) -> SupervisorTree
%% @doc supervisor callback.
init([]) ->
    Ip = case os:getenv("WEBMACHINE_IP") of false -> "0.0.0.0"; Any -> Any end,
%%    {ok, Dispatch} = file:consult(filename:join([filename:dirname(code:which(?MODULE)), "..", "priv", "dispatch.conf"])),
%%  把原来的注释增加成下面这个,实现从.app文件中读取到dispatch文件的目录
%%  在.app文件中增加如下代码：{dispatch, "/home/gordon/work/work/mobte/etc/api_dispatch.conf"}
    File = case application:get_env(testwm, dispatch) of
        undefined -> 
            filename:join([filename:dirname(code:which(?MODULE)), "..", "priv", "dispatch.conf"]);
        {ok, D2} ->
            D2
    end,
    {ok, Dispatch} = file:consult(File),
%% 增加对端口的設定
%% 在.app文件中增加如下代码： {port, 8000}，增加对商品的設定
    Port = case application:get_env(testwm, port) of
       undefined ->
           8000;
       {ok, P} ->
           P
    end,
%%增加对log日志目录的設定
%%在.app文件中增加代码：{log_dir, /home/gordon/log/webmachine}
    LogDir = case application:get_env(testwm, log_dir) of
        undefined ->
            "priv/log";
        {ok, Dir} ->
            Dir
    end,
    WebConfig = [
                 {ip, Ip},
                 {port, Port},
                 {log_dir, LogDir},
                 {dispatch, Dispatch}],
    Web = {webmachine_mochiweb,
           {webmachine_mochiweb, start, [WebConfig]},
           permanent, 5000, worker, [mochiweb_socket_server]},
    Processes = [Web],
    {ok, { {one_for_one, 10, 10}, Processes} }.
