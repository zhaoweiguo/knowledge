Redis 集合(Set)
###############

sadd
====

::

    sadd sets "a"//增加
    sadd sets "b"
    sadd sets "c"

srem
====

::

    srem sets "c"//移除

sismember
=========

::

    sismember sets "a" => 1//查看有无些元素
    sismember sets "d" => 0

smembers
========

::

    smembers sets =>["a", "b"]//查看所有元素

sunion
======

::

    sadd anothers "a"//新增一个set
    sadd anothers "d"
    sunion sets anothers => ["a", "b","d"]//把两set合并





