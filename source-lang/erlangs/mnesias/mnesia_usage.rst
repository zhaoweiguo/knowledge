.. _mnesia_usage:

Mnesia基本用法
######################

查看表结构::

    //查看mnesia表的结构:
    mnesia:info().

    //查看此表的基本信息:
    mnesia:table_info(<tableName>, all).


Mnesia初使化::

    mnesia:stop(),
    mnesia:create_schema([node()]),
    mnesia:start().

创建表::

    mnesia:create_table(<tableName>, [{attributes, record_info(fields,<tableName>)}, {disc_copies, [node()]}]).

读表记录::

    //读出表的所有key列表:
    mnesia:dirty_all_keys(<tableName>).

    // 根据key读表记录::
    mnesia:dirty_read(<tableName>, <Key>).

写表记录::

    mnesia:dirty_write(<tableName>, {<tableName>, <ColumnValue1>, <ColumnValue2>, ...}).

删除表记录::

    mnesia:dirty_delete(<tableName>, <Key>).

其他实用操作::

    //把表<table>的存储方式改成disc_copies:
    mnesia:change_table_copy_type(dictionary, node(), disc_copies).









