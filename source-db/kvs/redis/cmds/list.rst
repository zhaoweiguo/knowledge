Redis 列表(List)
################

lists::

    blpop "key" [key ...] timeout:移除并得到列表的第一个元素，或者阻塞直到其中一个空闲
    brpop "key" [key ...] timeout:同上，相当于阻塞的rpop
    brpoplpush "source" "destination" "...":取出数据,然后把数据压入到另一个列表
    lindex "key" "index":得到列表下第index的值
    linsert "key" BEFORE｜AFTER:在一个元素前面｜后面插入一个元素
    llen "key":得到列表的长度
    lpop "key":移除列表中的第一个元素，然后返回它的值
    lpush "key" "value":把值压入到列表中
    lpushx "key" "value":只有当列表存在时，才把值压入列表中
    lrange "key" "start" "stop":得到列表中从"start"到"stop"的值
    lrem "key" "count" "value":从列表中移除元素

        "count"为正数时，从头到尾查询移除"count"个等于"value"的值
        "count"为负数时，从尾到头查询移除|count|个等于"value"的值
        "count"为零时，移除列表中所有等于"value"的值

    lset "key" "index" "value":设定列表中第"index"的值为"value"
    ltrim "key" "start" "stop":取出列表中从start到stop的值
    rpop:同上
    rpoppush:同上
    rpush:同上
    rpushx:同上


列表lpush, rpush, llen, lrange, lpop::

    rpush friends "simon"//右写列表
    lpush friends "bland"
    lpush friends "hopen"//左写列表
    lrange friends 0 -1 => ["hopen", "bland", "simon"]//取出从0到倒数第一位数据(-2:倒数据第二位)
    lrange friends 0 1 => ["hopen", "bland"]
    llen friends => 3//求列表长度
    lpop friends => "bland"//左取数据
    rpop friends => "simon"//右取数据




