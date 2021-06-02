%% @author author <author@example.com>
%% @copyright YYYY author.
%% @doc Example webmachine_resource.

%%这是最简单的资源模块写法！
%%1，加上资源文件webmachine.hrl文件
%%2, 实现init/2和to_html／2方法
%%

-module(testwm_resource).
-export([init/1, to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->    
    {[{"text/html", to_html},{"text/plain",to_text}], ReqData, Context}.

to_text(ReqData, Context) ->    
    Path = wrq:disp_path(ReqData),
        Body = io_lib:format("Hello ~s from webmachine.~n", [Path]),
        {Body, ReqData, Context}.


to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>", ReqData, State}.

is_authorized(ReqData, Context) ->
    case wrq:disp_path(ReqData) of
        "authdemo" ->             
            case wrq:get_req_header("authorization", ReqData) of
                "Basic "++Base64 ->                    
                    Str = base64:mime_decode_to_string(Base64),
                    case string:tokens(Str, ":") of
                        ["authdemo", "demo1"] ->
                            {true, ReqData, Context};
                        _ ->
                            {"Basic realm=webmachine", ReqData, Context}
                    end;
                _ ->
                    {"Basic realm=webmachine", ReqData, Context}
            end;
        _ -> {true, ReqData, Context}
    end.

