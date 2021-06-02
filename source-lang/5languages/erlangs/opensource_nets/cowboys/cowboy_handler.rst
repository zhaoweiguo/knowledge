Handlers
###################
Plain HTTP handlers::

  init(Req, State) ->
    {ok, Req, State}.

  % 立即返回请求
  init(Req0, State) ->
    Req = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, <<"Hello World!">>, Req0),
    {ok, Req, State}.

Other handlers::

  可有选项:
    1. cowboy_rest
    2. cowboy_websocket
    3. cowboy_loop
  如:
  init(Req, State) ->
    {cowboy_websocket, Req, State}.

Cleaning up::

  terminate(_Reason, _Req, _State) ->
    ok.

Loop handlers::

  循环处理程序用于响应可能无法立即可用的请求，但您希望在响应到达时保持连接打开一段时间。
  这种做法最着名的例子被称为长轮询。
  也适用 server-sent events,用于响应partially available请求

  % Initialization,初使化
  init(Req, State) ->
    {cowboy_loop, Req, State}.
  init(Req, State) ->
    {cowboy_loop, Req, State, hibernate}.

  % Receive loop,收到消息后处理
  info({reply, Body}, Req, State) ->
      cowboy_req:reply(200, #{}, Body, Req),
      {stop, Req, State};
  info(_Msg, Req, State) ->
      {ok, Req, State, hibernate}.

  % Streaming loop
  init(Req, State) ->
    Req2 = cowboy_req:stream_reply(200, Req),
    {cowboy_loop, Req2, State}.

  info(eof, Req, State) ->
      {stop, Req, State};
  info({event, Data}, Req, State) ->
      cowboy_req:stream_body(Data, nofin, Req),
      {ok, Req, State};
  info(_Msg, Req, State) ->
      {ok, Req, State}.

Static files::

  PS:最好使用cdn解决此问题
  % 文件
  {"/", cowboy_static, {priv_file, my_app, "static/index.html"}}
  {"/", cowboy_static, {file, "/var/www/index.html"}}

  % 目录
  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets"}}
  {"/assets/[...]", cowboy_static, {dir, "/var/www/assets"}}

  Customize the mimetype detection:
  % 默认mimetype
  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
                            [{mimetypes, cow_mimetypes, web}]}}

  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
                            [{mimetypes, cow_mimetypes, all}]}}

  % 此函数的返回值参见下一条
  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
                            [{mimetypes, Module, Function}]}}

  {"/", cowboy_static, {priv_file, my_app, "static/index.html",
                            [{mimetypes, {<<"text">>, <<"html">>, []}}]}}


  Generate an etag:
  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
                            [{etag, Module, Function}]}}

  {"/assets/[...]", cowboy_static, {priv_dir, my_app, "static/assets",
                            [{etag, false}]}}







