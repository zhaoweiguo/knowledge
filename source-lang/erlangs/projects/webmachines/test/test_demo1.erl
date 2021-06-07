-module(test_demo1).
-export([init/1]).
-export([to_html/2, to_json/2, to_text/2]).
-export([content_types_privided/2]).

-include_lib("webmachine/include/webmachine.hrl"). %% needed


init([]) ->
    {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"text/html", to_html},{"text/plain",to_text}, {"application/json", to_json}], ReqData, Context}.

to_html(ReqData, Context) ->
    {"Hello World!", ReqData, Context}.

to_json(ReqData, Context) ->
    Json = ok, %% need to be finished
    {Json, ReqData, Context}.

to_text(ReqData, Context) ->
    Path = wrq:disp_path(ReqData),
    Body = io_lib:format("Hello ~s from Webmachine.~n", [Path]),
    {Body, ReqData, Context}.
