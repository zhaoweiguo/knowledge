ibrowser
#################

::

    ibrowse有两种许可证:LGPL或BSD license
    % 启动app
    5> ibrowse:start().

发送一个json类型的html請求::

    erl>>ibrowse:send_req("http://<url>", [{"Accept","application/json"}], get, [], []).
    注意:
    url地址必须以 ``http://`` 开头
    用 ``{"Accept", "application/json"}`` 来表示json类型的請求,默认是 ``text/html`` 类型


实例::

    ibrowse:send_req("http://<url>", [{"Accept","application/json"}], post, ["{\"id\":\"1234567890\", \"timestamp\":\"23421321421532143\"}"], []). 


* 一个简单的get应用::

    6> ibrowse:send_req("http://intranet/messenger/", [], get).
    {ok,"200",
        [{"Server","Microsoft-IIS/5.0"},
        {"Content-Location","http://intranet/messenger/index.html"},
        {"Date","Fri, 17 Dec 2004 15:16:19 GMT"},
        {"Content-Type","text/html"},
        {"Accept-Ranges","bytes"},
        {"Last-Modified","Fri, 17 Dec 2004 08:38:21 GMT"},
        {"Etag","\"aa7c9dc313e4c41:d77\""},
        {"Content-Length","953"}],
        "<html>\r\n\r\n<head>\r\n<title>Messenger</title></head><body>......"
    }

* 一个代理的get应用::

    7> ibrowse:send_req("http://www.google.com/", [], get, [],
        [{proxy_user, "XXXXX"},
        {proxy_password, "XXXXX"},
        {proxy_host, "proxy"},
        {proxy_port, 8080}], 1000
    ).

    {ok,"302",
         [{"Date","Fri, 17 Dec 2004 15:22:56 GMT"},
         {"Content-Length","217"},
         {"Content-Type","text/html"},
         {"Set-Cookie", "PREF=ID=f58155c797f96096; expires=Sun, 17-Jan-2038 19:14:07 GMT;"},
         {"Server","GWS/2.1"},
         {"Location", "http://www.google.co.uk/cxfer?c=PREF%3D:TM%3D1103296999:S%3Do8bEY2FIHwdyGenS&prev=/"},
         {"Via","1.1 netapp01 (NetCache NetApp/5.5R2)"}],
         "<HTML><HEAD><TITLE>302 Moved</TITLE></HEAD><BODY>\n<H1>302 Moved</H1>\r\n</BODY></HTML>\r\n"}


* 把get請求后的結果存放到文件中::

    创建一个临时文件, 返回这个刚创建的临时文件的文件名
    只有返回状态是200区间的才把請求的結果写入到这个临时文件中
    下载的目录可以用应用环境变量 `download_dir` ,默认是当前工作目录

    8> ibrowse:send_req("http://www.747.cn/", [], get, [], 
                              [{save_response_to_file, true}], 1000).
    {ok,"200",
        [{"Server","nginx/0.8.46"},
        {"Date","Thu, 01 Mar 2012 10:10:40 GMT"},
        {"Content-Type","text/html"},
        {"Content-Length","3796"},
        {"Last-Modified","Mon, 27 Feb 2012 11:20:36 GMT"},
        {"Connection","keep-alive"},
        {"Vary","Accept-Encoding"},
        {"Accept-Ranges","bytes"}],
        {file,"/home/gordon/tmp/ibrowser_test/ibrowse_tmp_file_1330597007674127"}}


* 设置连接池与管道大小,下面这个例子設定连接到服务的最大连接数到10,并把管道大小设置为1::

    Connections are setup a required
    11> ibrowse:set_dest("www.hotmail.com", 80, [{max_sessions, 10},
                                         {max_pipeline_size, 1}]).
    ok

* 使用HEAD方法的实例::

    56> ibrowse:send_req("http://www.erlang.org", [], head).
    {ok,"200",
       [{"Date","Mon, 28 Feb 2005 04:40:53 GMT"},
       {"Server","Apache/1.3.9 (Unix)"},
       {"Last-Modified","Thu, 10 Feb 2005 09:31:23 GMT"},
       {"Etag","\"8d71d-1efa-420b29eb\""},
       {"Accept-ranges","bytes"},
       {"Content-Length","7930"},
       {"Content-Type","text/html"}],
    []}

* 使用OPTIONS方法的实例::

    62> ibrowse:send_req("http://www.sun.com", [], options).   
      {ok,"200",
        [{"Server","Sun Java System Web Server 6.1"},
        {"Date","Mon, 28 Feb 2005 04:44:39 GMT"},
        {"Content-Length","0"},
        {"P3p",
            "policyref=\"http://www.sun.com/p3p/Sun_P3P_Policy.xml\", CP=\"CAO DSP COR CUR ADMa DEVa TAIa PSAa PSDa CONi TELi OUR  SAMi PUBi IND PHY ONL PUR COM NAV INT DEM CNT STA POL PRE GOV\""},
        {"Set-Cookie",
            "SUN_ID=X.X.X.X:169191109565879; EXPIRES=Wednesday, 31-Dec-2025 23:59:59 GMT; DOMAIN=.sun.com; PATH=/"},
        {"Allow",
              "HEAD, GET, PUT, POST, DELETE, TRACE, OPTIONS, MOVE, INDEX, MKDIR, RMDIR"}],
      []}


* 使用Asynchronous請求的实例::

    18> ibrowse:send_req("http://www.google.com", [], get, [], [{stream_to, self()}]).
    {ibrowse_req_id,{1115,327256,389608}}
    19> flush().
    ... ...


* 用async选项請求失败的实例::

    这儿没有返回 {ibrowse_req_id, ReqId}格式，而是返回错误代码:
    68> ibrowse:send_req("http://www.earlyriser.org", [], get, [], [{stream_to, self()}]).
    {error,conn_failed}

* 即有代理又有用户认证的实例::

    17> ibrowse:send_req("http://www.erlang.se/lic_area/protected/patches/erl_756_otp_beam.README", 
         [], get, [], 
         [{proxy_user, "XXXXX"}, 
          {proxy_password, "XXXXX"}, 
          {proxy_host, "proxy"}, 
          {proxy_port, 8080}, 
          {basic_auth, {"XXXXX", "XXXXXX"}}]).
          ... ...


ibrowse是一个HTTP客户端,下面是ibrowse的特性::

        - RFC2616 compliant (AFAIK) 
        - 支持 GET, POST, OPTIONS, HEAD, PUT, DELETE, TRACE, MKCOL, PROPFIND, PROPPATCH, LOCK, UNLOCK, MOVE and COPY
        - 支持 HTTP/0.9, HTTP/1.0 and HTTP/1.1
        - 支持 chunked encoding
        - Can generate requests using Chunked Transfer-Encoding
        - Pools of connections to each webserver
        - Pipelining support
        - 下载到文件
        - Asynchronous requests. Responses are streamed to a process
        - 基本的认证
        - 支持代理认证
        - 可以用SSL与安全webservers交互
        - 其他特性





