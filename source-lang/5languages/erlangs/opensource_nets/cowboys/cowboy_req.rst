cowboy Req & Response
############################

Direct access::

  init(Req0=#{method := <<"GET">>}, State) ->
    Req = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, <<"Hello world!">>, Req0),
    {ok, Req, State};
  init(Req0, State) ->
    Req = cowboy_req:reply(405, #{
        <<"allow">> => <<"GET">>
    }, Req0),
    {ok, Req, State}.

Request method::

  #{method := Method} = Req.
  等同于
  Method = cowboy_req:method(Req).

  包括: GET, HEAD, OPTIONS, PATCH, POST, PUT or DELETE.

HTTP version::

  #{version := Version} = Req.
  =>
  Version = cowboy_req:version(Req).

  值: 'HTTP/1.0', 'HTTP/1.1' and 'HTTP/2'

Effective request URI::

  #{
      scheme := Scheme,
      host := Host,
      port := Port,
      path := Path,
      qs := Qs
  } = Req.
  =>
  Scheme = cowboy_req:scheme(Req),
  Host = cowboy_req:host(Req),
  Port = cowboy_req:port(Req),
  Path = cowboy_req:path(Req).
  Qs = cowboy_req:qs(Req).

  scheme: <<"http">> and <<"https">>

cowboy_req:uri::

  %% scheme://host[:port]/path[?qs]
  URI = cowboy_req:uri(Req).

  %% /path[?qs]
  URI = cowboy_req:uri(Req, #{host => undefined}).

  %% //host[:port]/path[?qs]
  URI = cowboy_req:uri(Req, #{scheme => undefined}).

  URI = cowboy_req:uri(Req, #{qs => undefined}).

  URI = cowboy_req:uri(Req, #{host => <<"example.org">>}).

Bindings::

  % binding
  Value = cowboy_req:binding(userid, Req).
  % 增加默认值
  Value = cowboy_req:binding(userid, Req, 42).
  % 获取所有binding的值
  Bindings = cowboy_req:bindings(Req).

  % 获得...对应的值
  % 没有...返回undefined
  HostInfo = cowboy_req:host_info(Req).
  PathInfo = cowboy_req:path_info(Req).


Query parameters::
  
  % 查询所有参数
  QsVals = cowboy_req:parse_qs(Req),
  {_, Lang} = lists:keyfind(<<"lang">>, 1, QsVals).
  实例:
  key=1&key=2   => key[]=1&key[]=2      => [1 2]
  key           => [{<<"key">>, true}]  => true

  % 实例:

  #{id := ID, lang := Lang} = cowboy_req:match_qs([id, lang], Req).
  % 指定Constraints
  QsMap = cowboy_req:match_qs([{id, int}, {lang, nonempty}], Req).
  % 设定默认值
  #{lang := Lang} = cowboy_req:match_qs([{lang, [], <<"en-US">>}], Req).


Headers::

  HeaderVal = cowboy_req:header(<<"content-type">>, Req).
  % 默认值
  HeaderVal = cowboy_req:header(<<"content-type">>, Req, <<"text/plain">>).

  #{headers := AllHeaders} = Req.
  =>
  AllHeaders = cowboy_req:headers(Req).

  ParsedVal = cowboy_req:parse_header(<<"content-type">>, Req).
  % 指定默认值
  ParsedVal = cowboy_req:parse_header(<<"content-type">>, Req,
                            {<<"text">>, <<"plain">>, []}).

Peer::

  #{peer := {IP, Port}} = Req.
  =>
  {IP, Port} = cowboy_req:peer(Req).


body::

  cowboy_req:has_body(Req).
  Length = cowboy_req:body_length(Req).
  % 读body数据
  % 默认读15s, 8M数据
  {ok, Data, Req} = cowboy_req:read_body(Req0).
  % 指定最多只读5s,1M数据
  {ok, Data, Req} = cowboy_req:read_body(Req0,
      #{length => 1000000, period => 5000}).
  % 指定读15s,无限长的数据
  {ok, Data, Req} = cowboy_req:read_body(Req0, #{length => infinity}).

  % Reading a form urlencoded body
  {ok, KeyValues, Req} = cowboy_req:read_urlencoded_body(Req0).


Streaming the body::

  % 未读完返回{more ...
  read_body_to_console(Req0) ->
    case cowboy_req:read_body(Req0) of
        {ok, Data, Req} ->
            io:format("~s", [Data]),
            Req;
        {more, Data, Req} ->
            io:format("~s", [Data]),
            read_body_to_console(Req)
    end.

Reply::

  结构: 
  reply(Code, Header, Body, Req).
  Body = Header = binary() | iolist()
  iolist() = [binaries | characters | strings | iolists]

  实例:
  % reply/2
  Req = cowboy_req:reply(200, Req0).

  % reply/3,指定header
  Req = cowboy_req:reply(303, #{
      <<"location">> => <<"https://ninenines.eu">>
  }, Req0).

  % reply/4,指定body
  Title = "Hello world!",
  Body = <<"Hats off!">>,
  Req = cowboy_req:reply(200, #{
      <<"content-type">> => <<"text/html">>
  }, ["<html><head><title>", Title, "</title></head>",
      "<body><p>", Body, "</p></body></html>"], Req0).


Stream reply::

  两个函数:
  stream_reply/2
  stream_body/3

  实例1:
  % stream_reply/2
  Req = cowboy_req:stream_reply(200, Req0),

  cowboy_req:stream_body("Hello...", nofin, Req),
  cowboy_req:stream_body("chunked...", nofin, Req),
  cowboy_req:stream_body("world!!", fin, Req).
  % fin: final flag
  % nofin: not final

  实例2:
  % stream_reply/3
  Req = cowboy_req:stream_reply(200, #{
      <<"content-type">> => <<"text/html">>
  }, Req0),

  cowboy_req:stream_body("<html><head>Hello world!</head>", nofin, Req),
  cowboy_req:stream_body("<body><p>Hats off!</p></body></html>", fin, Req).

  实例3:
  Req = cowboy_req:stream_reply(200, #{
      <<"content-type">> => <<"text/html">>,
      <<"trailer">> => <<"expires, content-md5">>
  }, Req0),

  cowboy_req:stream_body("<html><head>Hello world!</head>", nofin, Req),
  cowboy_req:stream_body("<body><p>Hats off!</p></body></html>", nofin, Req),

  cowboy_req:stream_trailers(#{
      <<"expires">> => <<"Sun, 10 Dec 2017 19:13:47 GMT">>,
      <<"content-md5">> => <<"c6081d20ff41a42ce17048ed1c0345e2">>
  }, Req).

Preset response headers::

  % 设置
  Req = cowboy_req:set_resp_header(<<"allow">>, "GET", Req0).
  % 检查response header是否已经被设置
  cowboy_req:has_resp_header(<<"allow">>, Req).
  % 删除
  Req = cowboy_req:delete_resp_header(<<"allow">>, Req0).

Overriding headers::

  Headers有5种来源(按先后顺序)
  1. Protocol-specific headers (for example HTTP/1.1's connection header)
  2. Other required headers (for example the date header)
  3. Preset headers
  4. Headers given to the reply function
  5. Set-cookie headers

  注:
  1. Protocol-specific headers不允许被overriding
  2. Set-cookie headers通常在发送response前附加
  3. 如出现多次Overriding,后面覆盖前面

  例:
  % cowboy默认server使用Cowboy,这儿改为yaws
  Req = cowboy_req:reply(200, #{
      <<"server">> => <<"yaws">>
  }, Req0).

Preset response body::

  Req = cowboy_req:set_resp_body("Hello world!", Req0).
  % check
  cowboy_req:has_resp_body(Req).

Sending files::

  cowboy_req:reply/4
  {sendfile, Offset, Length, Filename}

  实例:
  Req = cowboy_req:reply(200, #{
      <<"content-type">> => "image/png"
  }, {sendfile, 0, 12345, "path/to/logo.png"}, Req0).


Informational responses::

  Req = cowboy_req:inform(103, #{
      <<"link">> => <<"</style.css>; rel=preload; as=style, </script.js>; rel=preload; as=script">>
  }, Req0).

Push::

  HTTP/2
  cowboy_req:push/3,4

  实例:push/3
  cowboy_req:push("/static/style.css", #{
      <<"accept">> => <<"text/css">>
  }, Req0),
  Req = cowboy_req:reply(200, #{
      <<"content-type">> => <<"text/html">>
  }, ["<html><head><title>My web page</title>",
      "<link rel='stylesheet' type='text/css' href='/static/style.css'>",
      "<body><p>Welcome to Erlang!</p></body></html>"], Req0).

  实例:push/4
  cowboy_req:push("/static/style.css", #{
      <<"accept">> => <<"text/css">>
  }, #{host => <<"cdn.example.org">>}, Req),

Setting cookies::

  % defined for the duration of the session
  SessionID = generate_session_id(),
  Req = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, Req0).

  % be set for a duration in seconds
  SessionID = generate_session_id(),
  Req = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, Req0,
      #{max_age => 3600}).

  % delete cookies
  SessionID = generate_session_id(),
  Req = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, Req0,
      #{max_age => 0}).
  
  % restrict cookies to a specific domain and path
  Req = cowboy_req:set_resp_cookie(<<"inaccount">>, <<"1">>, Req0,
    #{domain => "my.example.org", path => "/account"}).

  % 使用安全通道(https)
  SessionID = generate_session_id(),
  Req = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, Req0,
      #{secure => true}).

  % 禁止client-side scripts
  SessionID = generate_session_id(),
  Req = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, Req0,
      #{http_only => true}).


Reading cookies::

  % 读全部cookies
  Cookies = cowboy_req:parse_cookies(Req),
  {_, Lang} = lists:keyfind(<<"lang">>, 1, Cookies).

  % 读指定key的cookie
  #{id := ID, lang := Lang} = cowboy_req:match_cookies([id, lang], Req).

  % 限定读取类型
  CookiesMap = cowboy_req:match_cookies([{id, int}, {lang, nonempty}], Req).

  % 设定默认值
  #{lang := Lang} = cowboy_req:match_cookies([{lang, [], <<"en-US">>}], Req).

Multipart requests::

  multipart/form-data
  multipart/byteranges

  结构:
  multipart message = [part]
  part = {[header], body}
  body = [media type | contain text | binary data | multipart media type]

  application/x-www-form-urlencoded
  multipart/form-data

  {<<"multipart">>, <<"form-data">>, _}
    = cowboy_req:parse_header(<<"content-type">>, Req).

Reading a multipart message::

  cowboy_req:read_part/1,2
  cowboy_req:read_part_body/1,2
  // 实例:
  multipart(Req0) ->
    case cowboy_req:read_part(Req0) of
        {ok, _Headers, Req1} ->
            {ok, _Body, Req} = cowboy_req:read_part_body(Req1),
            multipart(Req);
        {done, Req} ->
            Req
    end.

  cow_multipart:form_data/1
  实例:
  multipart(Req0) ->
    case cowboy_req:read_part(Req0) of
        {ok, Headers, Req1} ->
            Req = case cow_multipart:form_data(Headers) of
                {data, _FieldName} ->
                    {ok, _Body, Req2} = cowboy_req:read_part_body(Req1),
                    Req2;
                {file, _FieldName, _Filename, _CType} ->
                    stream_file(Req1)
            end,
            multipart(Req);
        {done, Req} ->
            Req
    end.

  stream_file(Req0) ->
    case cowboy_req:read_part_body(Req0) of
        {ok, _LastBodyChunk, Req} ->
            Req;
        {more, _BodyChunk, Req} ->
            stream_file(Req)
    end.


  cowboy_req:read_part(Req, #{length => 128000}).
  cowboy_req:read_part_body(Req, #{length => 1000000, period => 7000}).

Skipping unwanted parts::

  multipart(Req0) ->
    case cowboy_req:read_part(Req0) of
        {ok, _Headers, Req} ->
            multipart(Req);
        {done, Req} ->
            Req
    end.


















