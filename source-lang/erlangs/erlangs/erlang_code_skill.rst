Erlang code skill
#########################

实例1::

  function greet(Gender,Name)
    if Gender == male then
      print("Hello, Mr. %s!", Name)
    else if Gender == female then
      print("Hello, Mrs. %s!", Name)
    else
      print("Hello, %s!", Name)
  end

  =>

  greet(male, Name) ->
    io:format("Hello, Mr. ~s!", [Name]);
  greet(female, Name) ->
    io:format("Hello, Mrs. ~s!", [Name]);
  greet(_, Name) ->
    io:format("Hello, ~s!", [Name]).


guard::

  % if ( X>=16 and X=<104)
  right_age(X) when X >= 16, X =< 104 ->
    true;
  right_age(_) ->
    false.

  % if (X < 16 or X > 104)
  wrong_age(X) when X < 16; X > 104 ->
    true;
  wrong_age(_) ->
    false.

[orelse]与[;]的区别::

  % 打印:a
  do1(A) when A/0==1 ; true ->
    io:format("a~n");
  do1(_A) ->
    io:format("b~n").

  % 打印:b
  do1(A) when A/0==1 orelse true ->
    io:format("a~n");
  do1(_A) ->
    io:format("b~n").

  说明: orelse在前一guard抛错时,继续判断下一guard
  而「;」则抛错时，忽略之后的guard




代码技巧::

    if State =/= locked ->
      do_lock().
    =>
    State =/= locked andalso do_lock().





