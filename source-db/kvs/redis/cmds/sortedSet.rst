Redis 有序集合(sorted set)
##########################

* Redis 有序集合和集合一样也是string类型元素的集合,且不允许重复的成员。
* 不同的是每个元素都会关联一个double类型的分数。redis正是通过分数来为集合中的成员进行从小到大的排序。
* 有序集合的成员是唯一的,但分数(score)却可以重复。
* 集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1)。 集合中最大的成员数为 232 - 1 (4294967295, 每个集合可存储40多亿个成员)。


Zadd
----

说明::

    Available since 1.2.0.
    Time complexity: O(log(N)) for each item added, 
        where N is the number of elements in the sorted set.

* Redis Zadd 命令用于将一个或多个成员元素及其分数值加入到有序集当中。
* 如果某个成员已经是有序集的成员，那么更新这个成员的分数值，并通过重新插入这个成员元素，来保证该成员在正确的位置上。
* 分数值可以是整数值或双精度浮点数。
* 如果有序集合 key 不存在，则创建一个空的有序集并执行 ZADD 操作。
* 返回被成功添加的新成员的数量，不包括那些被更新的、已经存在的成员。
* 当 key 存在但不是有序集类型时，返回一个错误。

语法::

    redis> ZADD KEY_NAME SCORE1 VALUE1.. SCOREN VALUEN

实例::

    redis> ZADD myzset 1 "one"
    (integer) 1
    redis> ZADD myzset 1 "uno"
    (integer) 1
    redis> ZADD myzset 2 "two" 3 "three"
    (integer) 2
    redis> ZRANGE myzset 0 -1 WITHSCORES
    1) "one"
    2) "1"
    3) "uno"
    4) "1"
    5) "two"
    6) "2"
    7) "three"
    8) "3"


Zincrby
-------

* Redis Zincrby 命令对有序集合中指定成员的分数加上增量 increment
* 可以通过传递一个负数值 increment ，让分数减去相应的值，比如 ZINCRBY key -5 member ，就是让 member 的 score 值减去 5 。
* 当 key 不存在，或分数不是 key 的成员时， ZINCRBY key increment member 等同于 ZADD key increment member 。
* 当 key 不是有序集类型时，返回一个错误。
* 分数值可以是整数值或双精度浮点数。

说明::

    Available since 1.2.0.
    Time complexity: O(log(N)) where N is the number of elements in the sorted set.


语法::

    redis> ZINCRBY key increment member

实例::

    redis> ZADD myzset 1 "one"
    (integer) 1
    redis> ZADD myzset 2 "two"
    (integer) 1
    redis> ZINCRBY myzset 2 "one"
    "3"
    redis> ZRANGE myzset 0 -1 WITHSCORES
    1) "two"
    2) "2"
    3) "one"
    4) "3"


Zrevrange
---------

* 命令返回有序集中，指定区间内的成员
* 其中成员的位置按分数值递减(从大到小)来排列。
* 具有相同分数值的成员按字典序的逆序(reverse lexicographical order)排列。
* 除了成员按分数值递减的次序排列这一点外， ZREVRANGE 命令的其他方面和 ZRANGE 命令一样。

说明::

    Available since 1.2.0.
    Time complexity: O(log(N)+M) with 
        N being the number of elements in the sorted set 
        and
        M the number of elements returned.

语法::

    redis> ZREVRANGE key start stop [WITHSCORES]

实例::

    redis> ZRANGE salary 0 -1 WITHSCORES        # 递增排列
    1) "peter"
    2) "3500"
    3) "tom"
    4) "4000"
    5) "jack"
    6) "5000"

    redis> ZREVRANGE salary 0 -1 WITHSCORES     # 递减排列
    1) "jack"
    2) "5000"
    3) "tom"
    4) "4000"
    5) "peter"
    6) "3500"

实操::

    1. 插入几条数据
    redis> ZADD myzset 1 "one"
    (integer) 1
    redis> ZADD myzset 2 "two"
    (integer) 1
    redis> ZADD myzset 3 "three"
    (integer) 1

    2. 打印全部数据
    redis> ZREVRANGE myzset 0 -1
    1) "three"
    2) "two"
    3) "one"

    3. 打印第2到3条
    redis> ZREVRANGE myzset 2 3
    1) "one"

    4. 打印倒数第2条到倒数第1条
    redis> ZREVRANGE myzset -2 -1
    1) "two"
    2) "one"



Zrange
------
格式::

    ZRANGE key start stop [WITHSCORES]

说明::

    Available since 1.2.0.
    Time complexity: O(log(N)+M) with 
        N being the number of elements in the sorted set 
        and 
        M the number of elements returned.

实操::

    redis> ZADD myzset 1 "one"
    (integer) 1
    redis> ZADD myzset 2 "two"
    (integer) 1
    redis> ZADD myzset 3 "three"
    (integer) 1
    redis> ZRANGE myzset 0 -1
    1) "one"
    2) "two"
    3) "three"
    redis> ZRANGE myzset 2 3
    1) "three"
    redis> ZRANGE myzset -2 -1
    1) "two"
    2) "three"

实例::

    zadd ordersets 1 "a" =>1//插入数据
    zadd ordersets 4 "d" =>1
    zadd ordersets 3 "c" =>1
    zadd ordersets 5 "e" =>1
    zrange ordersets 2 4 => ["d", "e"]//得到2-4的数据(从0开始)
    zrange ordersets 0 3 => ["a", "c", "d", "e"]//得到全部数据
    zadd order set 5 "e" => 0//插入重复数据失败
    zrange ordersets 0 4 => ["a", "c", "d", "e"]





