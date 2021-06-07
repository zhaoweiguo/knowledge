
.. _entop:

entop [1]_
'''''''''''''''''''''


编译::

  ./rebar3 clean
  ./rebar3 compile

Usage::

  ./entop <TARGETNODE> <COOKIE>

使用方法::

  [0-9]: Sort on column number 0 through 9. Starts with first column (0) and up to the last column (9).

  r: Toggles the sorting order from ascending to descending and vice versa.

  q: Quits entop and return to the shell.

  Ctrl-C: Same as 'q'.

  '<' and '>': Moves the sorting column to the left or right respectively (these are the lower/greater-than-tags; not arrow keys).

依赖库:

entop [1]_ -> cecho [2]_ -> pc [3]_





.. [1] https://github.com/mazenharake/entop
.. [2] https://github.com/mazenharake/cecho
.. [3] https://github.com/blt/port_compiler

