queue模块
##############

Original API
---------------

.. function:: from_list/1

结构::

    from_list(L :: [Item]) -> queue(Item)
    返回包含与L这个items列表相同顺序的queue
    List前面的item就在队列的前面


Extended API
-----------------
.. function:: drop/1

::

  drop(Q1 :: queue(Item)) -> Q2 :: queue(Item)
  移除Q1最前面的item,然后返回此queue
  同tail/1

.. function:: get/1

::

    get(Q :: queue(Item)) -> Item
    返回队列Q的前面的item
    同: head/1

Okasaki API
----------------
.. function:: head/1

::

    head(Q :: queue(Item)) -> Item
    返回队列Q前面的item
    同: get/1

.. function:: tail/1

::

  tail(Q1 :: queue(Item)) -> Q2 :: queue(Item)
  移除Q1最前面的item,然后返回此queue
  同drop/1





