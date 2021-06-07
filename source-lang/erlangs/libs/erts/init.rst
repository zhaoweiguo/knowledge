init模块 [1]_
##############

get_argument/1::

  get_argument(Flag) -> {ok, Arg} | error
  % erl -a b c -a d
  1> init:get_argument(a).
  {ok,[["b","c"],["d"]]}
  
  % 以下是几个自动赋值的
  2> init:get_argument(root).
  {ok,[["/usr/local/lib/erlang"]]}
  3> init:get_argument(progname).
  {ok,[["erl"]]}
  4> init:get_argument(home).
  {ok,[["/home/gordon"]]}





.. [1] http://erlang.org/doc/man/init.html