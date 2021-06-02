.. _request:

#######
request
#######

5, 所有有关請求的方法都被集成到wrq模块里了！其实wrq模块就是处理mochiweb_request和mochiweb_response对象的API,下面具体说下它对应的方法:
    5.1 client請求的 ``http method`` ::

        method(rd())-> 'DELETE', 'GET', 'HEAD', 'OPTIONS', 'POST', 'PUT', 'TRACE'

    5.2 client請求的http版本,一般是 ``{1, 1}`` 即http version 1.1 ::

        version(rd())-> {integer(), integer()}

    5.3 client的IP地址 ::

        peer(rd()): string()

    5.4 这个方法是三个路径方法之一,剩下两个就是下面俩. 这个方法前面介绍过(Dispatching部分)!它的意思是指前面dispatching匹配完成之后,剩下的部分!dispatching改变,它也跟着变化::

        disp_path(rd())-> string()

    5.5 这个方法是得到URI中host:port之后,但不包括query字符串的部分 ::

        path(rd): string()

    5.6 得到全部的請求URI ::

        raw_path(rd()): string()

    5.7 得到在dispatching配置{pathspec, resource, args} 中, pathspec中对应atom格式对应的值::

        path_info(atom(), rd())->'undefined', string()

    5.8 得到在dispatching配置{pathspec, resource, args} 中, pathspec中对应atom格式对就的所有值::

        path_info(atom()) ->any()

    5.9 得到把disp_path(rd())所出数据按"/"split后的列表::

        path_tokens(rd()) ->list()

    5.10 查询incoming request header的值::

        get_req_header(string(), rd()) ->'undefined', string()

    5.11 得到incoming HTTP headers::

        req_headers(rd()) ->mochiheaders()

    5.12 得到incoming request body::

        req_body(rd()) ->'undeinfed', binary()

    5.13 以streamed格式返回incoming request body,最大不能超过integer()参数对应的值::

        stream_req_body(rd(), integer()) ->streambody()

    5.14 得到对应cookie的值::

        get_cookie_value(string(), rd()) ->string()

    5.15 得到所有cookie的值::

        req_cookie(rd()) -> string()

    5.16 得到根据key得到query string中value的值::

            get_qs_value(string(), rd()) ->'undefined', string()

    5.17 和上面函数一样， 不过它的第二个参数是当得值为'undefined'时的默认值::

         get_qs_value(string(), string(), rd()) ->string()

    5.18 得到query string的key/value列表::

         req_qs(rd()) ->[string(), string()].

    5.19 Look up the current value of an outgoing request header ::

         get_resp_header(string(), rd()) ->string()

    5.20 the last value passed to do_redirect, false otherwise – if true, then some responses will be 303 instead of 2xx where applicable::

         resp_redirect(rd()) ->bool()

    5.21 The outgoing HTTP headers. 和get_resp_header/2对应::

         resp_header(rd()) ->mochiheaders()

    5.22 The outgoing response body, if one has been set. Usually, append_to_response_body is the best way to set this::

        resp_body(rd()) ->'undefined', binary()

    5.23 Indicates the “height” above the requested URI that this resource is dispatched from. Typical values are “.” , “..” , “../..” and so on::

        app_root(rd()) ->string()

6, Requst Modification functions
    6.1 Given a header name and value, set an outgoing request header to that value::

        set_req_header(string(), string(), rd()) ->rd()

    6.2 Append the given value to the body of the outgoing response::

        append_to_response_body(binary(), rd()) ->rd()

    6.3 see resp_redirect/1, this function is to set that value::

        do_redirect(bool(), rd()) ->rd()

    6.4 the disp_path is the only path that can be changed during the request. This function will do it ::

        set_disp_path(string(), rd()) ->rd()

    6.5 Replace the incoming request body with this for the rest of  the processing ::

        set_req_body(binary(), rd()) -> rd()

    6.6 set the outgoing response body to this value::

        set_resp_body(binary(), rd()) ->rd()

    6.7 use this streamed body to produce the outgoing response body on demand::

        set_resp_body(streambody(), rd()) ->rd()

    6.8 Given a list of two-tuples of {headername, value}, set those outgoing response headers ::

        set_resp_headers([{string(), string()}, rd()] -> rd()

    6.9 Removed the named outgoing response header ::

        remove_resp_header(string(), rd()) -> rd()



