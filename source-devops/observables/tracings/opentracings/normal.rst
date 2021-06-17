基本
####

Data Model
==========

Span
----

Span是一条追踪链路中的基本组成要素，一个span表示一个独立的工作单元，比如可以表示一次函数调用，一次http请求等等。span会记录如下基本要素::

    服务名称(operation name)
    服务的开始时间和结束时间
    K/V形式的Tags
    K/V形式的Logs
    SpanContext
    References：该span对一个或多个span的引用（通过引用SpanContext）

Tags
````

Tags以K/V键值对的形式保存用户自定义标签，主要用于链路追踪结果的查询过滤。例如::

    http.method="GET",http.status_code=200
    其中key值必须为字符串，value必须是字符串，布尔型或者数值型

span中的tag仅自己可见，不会随着 SpanContext传递给后续span。例如::

    span.SetTag("http.method","GET")
    span.SetTag("http.status_code",200)

Logs
``````

Logs与tags类似，也是K/V键值对形式。与tags不同的是，logs还会记录写入logs的时间，因此logs主要用于记录某些事件发生的时间。logs的key值同样必须为字符串，但对value类型则没有限制。例如::

    span.LogFields(
      log.String("event", "soft error"),
      log.String("type", "cache timeout"),
      log.Int("waited.millis", 1500),
    )

`Opentracing列举了一些惯用的Tags和Logs <https://github.com/opentracing/specification/blob/master/semantic_conventions.md>`_

SpanContext
```````````

SpanContext携带着一些用于跨服务通信的（跨进程）数据，主要包含::

    足够在系统中标识该span的信息，比如：span_id,trace_id
    Baggage Items，为整条追踪连保存跨服务（跨进程）的K/V格式的用户自定义数据

Baggage Items
`````````````

Baggage Items与tags类似，也是K/V键值对。与tags不同的是::

    其key跟value都只能是字符串格式
    Baggage items不仅当前span可见，其会随着SpanContext传递给后续所有的子span
    注意: 要小心谨慎的使用baggage items——因为在所有的span中传递这些K,V会带来不小的网络和CPU开销

References
----------

* Opentracing定义了两种引用关系:ChildOf和FollowFrom
* ChildOf::
  
    父span的执行依赖子span的执行结果时，此时子span对父span的引用关系是ChildOf
    比如对于一次RPC调用，服务端的span（子span）与客户端调用的span（父span）是ChildOf关系

* FollowFrom::
  
    父span的执行不依赖子span执行结果时，此时子span对父span的引用关系是FollowFrom
    FollowFrom常用于异步调用的表示，例如消息队列中consumerspan与producerspan之间的关系

Trace
-----

Trace表示一次完整的追踪链路，trace由一个或多个span组成。下图示例表示了一个由8个span组成的trace::


            [Span A]  ←←←(the root span)
                |
         +------+------+
         |             |
     [Span B]      [Span C] ←←←(Span C is a `ChildOf` Span A)
         |             |
     [Span D]      +---+-------+
                   |           |
               [Span E]    [Span F] >>> [Span G] >>> [Span H]
                                           ↑
                                           ↑
                                           ↑
                             (Span G `FollowsFrom` Span F)

时间轴的展现方式会更容易理解::

    ––|–––––––|–––––––|–––––––|–––––––|–––––––|–––––––|–––––––|–> time

     [Span A···················································]
       [Span B··············································]
          [Span D··········································]
        [Span C········································]
             [Span E·······]        [Span F··] [Span G··] [Span H··]





参考
----

* `水立方——Go集成Opentracing <https://juejin.im/post/5d7ed711e51d4562165535ab>`_
* `opentracing-tutorial <https://github.com/yurishkuro/opentracing-tutorial/tree/master/go>`_
* `opentracing/specification <https://github.com/opentracing/specification>`_
* `Opentracing规范文档v1.1 <https://github.com/opentracing/specification/blob/master/specification.md>`_
* `Opentracing语义习惯 <https://github.com/opentracing/specification/blob/master/semantic_conventions.md>`_