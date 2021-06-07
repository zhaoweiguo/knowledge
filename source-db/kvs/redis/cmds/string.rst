Redis 字符串(String)
####################

Get
===

格式::

    GET key

说明::

    Available since 1.0.0.
    Time complexity: O(1)

实例::

    redis> GET nonexisting
    (nil)
    redis> SET mykey "Hello"
    "OK"
    redis> GET mykey
    "Hello"

其他
====

简单的赋值、取值set, get, getset::

    set server:name "fido"//设值
    get server:name => "fido"//取值
    getset server:name "change" => "fido"//先取值，再设值
    get server:name => "change"

自增，自减:incr, incrby, decr, decrby, del::

    set num 10
    incr num => 11//自增1
    incr num => 12
    incrby num 10 => 22//自增10
    decr num =>21
    decrby num 10 =>11
    del num//删除变量
    incr num => 1

有生命周期的变量::

    set source "redis"
    expire source 120//把变量source生命周期设为120秒
    ttl source => 119,118...//剩余生命时间





