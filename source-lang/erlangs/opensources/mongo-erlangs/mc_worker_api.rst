mc_worker_api 
==================



direct connection client::

    Database = <<"test">>.
    case mc_worker_api:connect([{database, Database}]) of
        {ok, Connection} ->
          ok;
        {error, Reason} ->
          error
    end.



Writing
-----------

::

    > Collection = <<"test">>.
    > mc_worker_api:insert(Connection, Collection, 
        [
         #{<<"name">> => <<"Yankees">>,
           <<"home">> => #{<<"city">> => <<"New York">>, <<"state">> => <<"NY">>},
           <<"league">> => <<"American">>},
         #{<<"name">> => <<"Mets">>,
           <<"home">> => #{<<"city">> => <<"New York">>, <<"state">> => <<"NY">>},
           <<"league">> => <<"National">>},
         #{<<"name">> => <<"Phillies">>,
           <<"home">> => #{<<"city">> => <<"Philadelphia">>, <<"state">> => <<"PA">>},
           <<"league">> => <<"National">>},
         #{<<"name">> => <<"Red Sox">>,
           <<"home">>=> #{<<"city">> => <<"Boston">>, <<"state">> => <<"MA">>},
           <<"league">> => <<"American">>}
       ]).

    > mc_worker_api:delete(Connection, Collection, Selector).
    如:
    > Collection = <<"test">>.
    > mc_worker_api:insert(Connection, Collection, 
        #{
          <<"name">> => <<"Yankees">>, 
          <<"home">> => #{
              <<"city">> => <<"New York">>, 
              <<"state">> => <<"NY">>}, 
              <<"league">> => <<"American">>
          }).

Reading
-----------

::

    > {ok, Cursor} = mc_worker_api:find(Connection, Collection, Selector)
    > Result = mc_cursor:next(Cursor),
    > mc_cursor:close(Cursor),

.. note::

    Important! Do not forget to close cursors after using them! 
    mc_cursor:rest closes the cursor automatically.

实例::

    mc_worker_api:find_one(Connection, Collection, #{<<"key">> => <<"123">>}).

    mc_worker_api:find_one(Connection, Collection, 
          #{<<"key">> => <<"123">>, <<"value">> => <<"built_in">>}).

    % 只读取_id和value字段
    mc_worker_api:find_one(Connection, Collection, {}, 
          #{projector => #{<<"value">> => true}).
    % 只读取_id字段
    mc_worker_api:find_one(Connection, Collection, {}, 
        #{projector => #{<<"key">> => false, <<"value">> => false}}).


Updating
---------------

实例::

    Command = #{<<"$set">> => #{
        <<"quantity">> => 500,
        <<"details">> => #{<<"model">> => "14Q3", <<"make">> => "xyz"},
        <<"tags">> => ["coats", "outerwear", "clothing"]
    }},
    mc_worker_api:update(Connection, Collection, #{<<"_id">> => 100}, Command),

    % 如没有expired字段，增加新字段
    Command = #{<<"$set">> => #{<<"expired">> => true}},
    mc_worker_api:update(Connection, Collection, #{<<"_id">> => 100}, Command),

    % 更新嵌套文档中的字段
    Command = #{<<"$set">> => #{<<"details.make">> => "zzz"}},
    mc_worker_api:update(Connection, Collection, #{<<"_id">> => 100}, Command),

    % 数组更新
    Command = #{<<"$set">> => #{
        <<"tags.1">> => "rain gear",
        <<"ratings.0.rating">> => 2
      }},
    mc_worker_api:update(Connection, Collection, #{'_id' => 100}, Command),


Creating indexes
---------------------

::

    mc_worker_api:ensure_index(Connection, Collection, #{
        <<"key">> => #{<<"index">> => 1}
      }).  %simple
    mc_worker_api:ensure_index(Connection, Collection, #{
        <<"key">> => #{<<"index">> => 1}, 
        <<"name">> => <<"MyI">>
      }).  %advanced
    mc_worker_api:ensure_index(Connection, Collection, #{
        <<"key">> => #{<<"index">> => 1}, 
        <<"name">> => <<"MyI">>, 
        <<"unique">> => true, 
        <<"dropDups">> => true
      }).  %full








