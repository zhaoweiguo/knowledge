cowboy简介
--------------------

* Webmachine-based REST::

    Dispatch = cowboy_router:compile([
        %% {URIHost, list({URIPath, Handler, Opts})}
        {'_', [{'_', my_handler, []}]}
    ]),
    %% Name, NbAcceptors, TransOpts, ProtoOpts
    cowboy:start_http(my_http_listener, 100,
        [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ).


handler types::

  cowboy_rest
  cowboy_websocket
  cowboy_loop

  // 方法
  init(Req, State) ->
    {cowboy_websocket, Req, State}.


mimetype::

  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
    [{mimetypes, cow_mimetypes, web}]}}

  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
    [{mimetypes, cow_mimetypes, all}]}}

  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
    [{mimetypes, Module, Function}]}}

  {"/", cowboy_static, {priv_file, my_app, "static/index.html",
    [{mimetypes, {<<"text">>, <<"html">>, []}}]}}



普通实例::

    -module(my_handler).
    -behaviour(cowboy_http_handler).

    -export([init/3]).
    -export([handle/2]).
    -export([terminate/3]).

    init({tcp, http}, Req, Opts) ->
        {ok, Req, undefined_state}.

    handle(Req, State) ->
        {ok, Req2} = cowboy_req:reply(200, [], <<"Hello World!">>, Req),
        {ok, Req2, State}.

    terminate(Reason, Req, State) ->
        ok.




.. figure:: /images/languages/erlangs/cowboy_http_req_resp.png
   :width: 30%



