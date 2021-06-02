Mnesia实用操作
===================

::

  // 复制表
  1> [tab1, tab2, tab3],
  2> [mnesia:add_table_copy(T, node(), ram_copies)||T<-L].




