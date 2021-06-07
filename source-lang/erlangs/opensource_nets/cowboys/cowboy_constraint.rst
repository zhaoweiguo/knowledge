Cowboy Constrains
#####################

约束是应用于用户输入的验证和转换函数。

语法::

  field
  {field, Constraints}
  {field, Constraints, Default}

实例::

  PositiveFun = fun
      (_, V) when V > 0 ->
          {ok, V};
      (_, _) ->
          {error, not_positive}
  end,
  {my_value, [int, PositiveFun]}.

内置函数::

  int
  nonempty


自定义函数::

  % forward
  int(forward, Value) ->
    try
        {ok, binary_to_integer(Value)}
    catch _:_ ->
        {error, not_an_integer}
    end;

  % reverse
  int(reverse, Value) ->
    try
      {ok, integer_to_binary(Value)}
    catch _:_ ->
      {error, not_an_integer}
    end;

  % format_error
  int(format_error, {not_an_integer, Value}) ->
    io_lib:format("The value ~p is not an integer.", [Value]).









