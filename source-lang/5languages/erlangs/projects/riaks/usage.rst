.. _usage:

riak使用
===========

用法::

    {ok, C} = riak:local_client().
    C:get_bucket(<<"call_lists">>).
    {ok, Object} = C:get(<<"call_list">>, <<key>>).
    riak_search_kv_hook:prcommit(Object).

    search:search(<<"phones">>, <<"id 1 TO 9">>).
    search:search(<<"phones">>, <<"tel:15101167666">>).
    search:search_doc(<<"phones">>, <<"tel:4006123456">>).
    C:delete(<<"phone">>, <<"15101167666">>).


