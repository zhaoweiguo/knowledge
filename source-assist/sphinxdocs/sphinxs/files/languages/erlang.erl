%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc calllist analysis startup code

-module(ca).
-author('author <author@example.com>').
-export([start/0]).

start(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

