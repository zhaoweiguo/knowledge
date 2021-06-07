jiffy项目 [1]_
##############


实例::

  Eshell V5.8.2  (abort with ^G)
  1> jiffy:decode(<<"{\"foo\": \"bar\"}">>).
  {[{<<"foo">>,<<"bar">>}]}
  2> Doc = {[{foo, [<<"bing">>, 2.3, true]}]}.
  {[{foo,[<<"bing">>,2.3,true]}]}
  3> jiffy:encode(Doc).
  <<"{\"foo\":[\"bing\",2.3,true]}">>


Data Format::

    Erlang                          JSON            Erlang
    ==========================================================================

    null                       -> null           -> null
    true                       -> true           -> true
    false                      -> false          -> false
    "hi"                       -> [104, 105]     -> [104, 105]
    <<"hi">>                   -> "hi"           -> <<"hi">>
    hi                         -> "hi"           -> <<"hi">>
    1                          -> 1              -> 1
    1.25                       -> 1.25           -> 1.25
    []                         -> []             -> []
    [true, 1.0]                -> [true, 1.0]    -> [true, 1.0]
    {[]}                       -> {}             -> {[]}
    {[{foo, bar}]}             -> {"foo": "bar"} -> {[{<<"foo">>, <<"bar">>}]}
    {[{<<"foo">>, <<"bar">>}]} -> {"foo": "bar"} -> {[{<<"foo">>, <<"bar">>}]}
    #{<<"foo">> => <<"bar">>}  -> {"foo": "bar"} -> #{<<"foo">> => <<"bar">>}



.. [1] https://github.com/davisp/jiffy
