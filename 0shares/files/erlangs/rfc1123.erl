%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%     Get from cowboy
%%% @end
%%% Created : 06. Jun 2019 3:51 PM
%%%-------------------------------------------------------------------
-module(rfc1123).
-author("zhaoweiguo").

%% API
-export([convert/0]).

convert() ->
    _T = {Date = {Y, Mo, D}, {H, M, S}} = erlang:universaltime(),
    Wday = calendar:day_of_the_week(Date),
    << (weekday(Wday))/binary, ", ", (pad_int(D))/binary, " ",
        (month(Mo))/binary, " ", (integer_to_binary(Y))/binary,
        " ", (pad_int(H))/binary, $:, (pad_int(M))/binary,
        $:, (pad_int(S))/binary, " GMT" >>.


-spec weekday(1..7) -> <<_:24>>.
weekday(1) -> <<"Mon">>;
weekday(2) -> <<"Tue">>;
weekday(3) -> <<"Wed">>;
weekday(4) -> <<"Thu">>;
weekday(5) -> <<"Fri">>;
weekday(6) -> <<"Sat">>;
weekday(7) -> <<"Sun">>.


-spec month(1..12) -> <<_:24>>.
month( 1) -> <<"Jan">>;
month( 2) -> <<"Feb">>;
month( 3) -> <<"Mar">>;
month( 4) -> <<"Apr">>;
month( 5) -> <<"May">>;
month( 6) -> <<"Jun">>;
month( 7) -> <<"Jul">>;
month( 8) -> <<"Aug">>;
month( 9) -> <<"Sep">>;
month(10) -> <<"Oct">>;
month(11) -> <<"Nov">>;
month(12) -> <<"Dec">>.



%% Following suggestion by MononcQc on #erlounge.
-spec pad_int(0..59) -> binary().
pad_int(X) when X < 10 ->
    << $0, ($0 + X) >>;
pad_int(X) ->
    integer_to_binary(X).




