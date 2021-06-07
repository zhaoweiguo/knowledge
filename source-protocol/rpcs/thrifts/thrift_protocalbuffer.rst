与protocal buffer的比较
=============================

两者的不同::

    thrift胜在“丰富的特性“上，而protocal buffer胜在“文档化”非
    最大区别是thrift支持完整的client/server RPC框架，而protocal buffer只会产生接口，具体实现，还需要用户做大量工作
    从序列化性能上比较，Protocal Buffer要远远优于thrift(见: http://www.ibm.com/developerworks/cn/linux/l-cn-gpb/?ca=drs-tp4608)


相同点::

    在具体实现上，它们非常类似，都是使用唯一整数标记字段域，这就使得增加和删除字段与不会破坏已有的代码


