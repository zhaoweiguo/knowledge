erl_syntax模块 [1]_
#########################
Abstract Erlang syntax trees.
all erl_parse trees are valid abstract syntax trees, but the reverse is not true


atom/1
''''''''''
格式::

  atom(Name::atom() | string()) 
    -> syntaxTree()



attribute/1/2
''''''''''''''''''
attribute/1::

  attribute(Name::syntaxTree()) 
    -> syntaxTree()
  等同于
  attribute(Name, none).

attribute/2::

  attribute(Name::syntaxTree(), Args::none | [syntaxTree()]) 
    -> syntaxTree()


实例::

  % -module(abc).
  erl_syntax:attribute(erl_syntax:atom(module), erl_syntax:atom(abc)).
  {tree,attribute,
      {attr,0,[],none},
      {attribute,{tree,atom,{attr,0,[],none},module},
                 {tree,atom,{attr,0,[],none},abc}}}

  % -export([get/1, info/2]).
  erl_syntax:attribute(erl_syntax:atom(export), erl_syntax:list([
    erl_syntax:arity_qualifier(erl_syntax:atom(get), erl_syntax:integer(1)),
    erl_syntax:arity_qualifier(erl_syntax:atom(info), erl_syntax:integer(2))
  ])).
  {tree,attribute,
    {attr,0,[],none},
    {attribute,
        {tree,atom,{attr,0,[],none},export},
        {tree,list,
            {attr,0,[],none},
            {list,
                [{tree,arity_qualifier,
                     {attr,0,[],none},
                     {arity_qualifier,
                         {tree,atom,{attr,0,[],none},get},
                         {tree,integer,{attr,0,[],none},1}}},
                 {tree,arity_qualifier,
                     {attr,0,[],none},
                     {arity_qualifier,
                         {tree,atom,{attr,0,[],none},info},
                         {tree,integer,{attr,0,[],none},2}}}],
                none}}}}

  % get(Name) -> Name.
  erl_syntax:function(erl_syntax:atom(get), erl_syntax:integer(1))







.. [1] http://erlang.org/doc/man/erl_syntax.html

