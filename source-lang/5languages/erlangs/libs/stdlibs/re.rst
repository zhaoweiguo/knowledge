re
#########


replace/3/4
'''''''''''''''''
结构::

  replace(Subject, RE, Replacement, Options) ->
           iodata() | unicode:charlist()

类型::

  Option = 
      anchored |
      global   |
      notbol   |
      noteol   |
      notempty |
      notempty_atstart |
      {offset, integer() >= 0} |
      {newline, NLSpec} |
      bsr_anycrlf |
      {match_limit, integer() >= 0} |
      {match_limit_recursion, integer() >= 0} |
      bsr_unicode |
      {return, ReturnType} |
      CompileOpt
  NLSpec = cr | crlf | lf | anycrlf | any

实例::

  $> re:replace("abcd","c","[&]",[{return,list}]).
  "ab[c]d"
  $> re:replace("abcd","c","[\\&]",[{return,list}]).
  "ab[&]d"

run/2/3
----------


实例::

    1> re:run("xyzabc","(*COMMIT)abc",[{capture,all,list}]).
    {match,["abc"]}
    2> re:run("xyzabc","(*COMMIT)abc",[{capture,all,list},no_start_optimize]).
    nomatch

    36> re:run("Erlang","\\.").
    nomatch
    37> re:run("Erla.ng","\\.").
    {match,[{4,1}]}
    38> re:run("Erlang","\.").
    {match,[{0,1}]}
    39> re:run("Erla.ng","\.").
    {match,[{0,1}]}


split/2/3
-------------

实例::

    erl> re:split("Erlang","[ln]",[{return,list}]).
    ["Er","a","g"]
    erl> re:split("Erlang","([ln])",[{return,list}]).
    ["Er","l","a","n","g"]

    erl> re:split("Erlang","[n]",[{return,list}]).
    ["Erla","g"]
    erl> re:split("Erlang","([n])",[{return,list}]).
    ["Erla","n","g"]

    erl> re:split("Erlang","[lg]",[{return,list}]).
    ["Er","an",[]]

    erl> re:split("er.lan.g","[.]",[{return,list}]).
    ["er","lan","g"]







