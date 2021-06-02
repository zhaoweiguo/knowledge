jsx项目 [1]_
#################



to convert a utf8 binary containing a json string into an erlang term::

    1> jsx:decode(<<"{\"library\": \"jsx\", \"awesome\": true}">>).
    [{<<"library">>,<<"jsx">>},{<<"awesome">>,true}]

    2> jsx:decode(<<"{\"library\": \"jsx\", \"awesome\": true}">>, [return_maps]).
    #{<<"awesome">> => true,<<"library">> => <<"jsx">>}

    3> jsx:decode(<<"[\"a\",\"list\",\"of\",\"words\"]">>).
    [<<"a">>, <<"list">>, <<"of">>, <<"words">>]

to convert an erlang term into a utf8 binary containing a json string::

    1> jsx:encode([{<<"library">>,<<"jsx">>},{<<"awesome">>,true}]).
    <<"{\"library\": \"jsx\", \"awesome\": true}">>

    2> jsx:encode(#{<<"library">> => <<"jsx">>, <<"awesome">> => true}).
    <<"{\"awesome\":true,\"library\":\"jsx\"}">>

    3> jsx:encode([<<"a">>, <<"list">>, <<"of">>, <<"words">>]).
    <<"[\"a\",\"list\",\"of\",\"words\"]">>

to check if a binary or a term is valid json::

    1> jsx:is_json(<<"[\"this is json\"]">>).
    true
    2> jsx:is_json("[\"this is not\"]").
    false
    3> jsx:is_term([<<"this is a term">>]).
    true
    4> jsx:is_term([this, is, not]).
    false

to minify some json::

    1> jsx:minify(<<"{
      \"a list\": [
        1,
        2,
        3
      ]
    }">>).
    <<"{\"a list\":[1,2,3]}">>

to prettify some json::

    1> jsx:prettify(<<"{\"a list\":[1,2,3]}">>).
    <<"{
      \"a list\": [
        1,
        2,
        3
      ]
    }">>



.. [1] https://github.com/talentdeficit/jsx



