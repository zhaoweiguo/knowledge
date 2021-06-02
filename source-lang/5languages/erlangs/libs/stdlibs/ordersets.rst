ordsets模块
####################
Functions for manipulating sets as ordered lists.

基本用法
'''''''''''''

add_element/2::

  add_element(Element, Ordset1) -> Ordset2
  类型:
  Element = E
  Ordset1 = ordset(T)
  Ordset2 = ordset(T | E)
  实例:


del_element/2::

  del_element(Element, Ordset1) -> Ordset2
  类型:
  Element = term()
  Ordset1 = Ordset2 = ordset(T)
  Returns Ordset1, but with Element removed.
  实例:

new/0::

  new() -> []
  Returns a new empty ordered set.


is_element/2::

  is_element(Element, Ordset) -> boolean()
  Types
  Element = term()
  Ordset = ordset(term())
  Returns true if Element is an element of Ordset, otherwise false.













