简单介绍
==============

a remote procedure call framework for "scalable cross-languages services development"

网址
-------

    http://thrift.apache.org/

架构设计
------------

.. figure:: /images/protocols/thrift_architecture.png
   :width: 70%

Thrift的网络栈:

.. figure:: /images/protocols/thrift_netstack.jpg
   :width: 70%


支持的数据传输格式
--------------------
::

    TBinaryProtocol – 二进制格式.
    TCompactProtocol – 压缩格式
    TJSONProtocol – JSON格式
    TSimpleJSONProtocol –提供JSON只写协议, 生成的文件很容易通过脚本语言解析。
    TDebugProtocol – 使用易懂的可读的文本格式，以便于debug

支持的数据传输方式
------------------------
::

    TSocket -阻塞式socker
    TFramedTransport – 以frame为单位进行传输，非阻塞式服务中使用
    TFileTransport – 以文件形式进行传输
    TMemoryTransport – 将内存用于I/O. java实现时内部实际使用了简单的ByteArrayOutputStream
    TZlibTransport – 使用zlib进行压缩， 与其他传输方式联合使用。当前无java实现

支持的服务模型
------------------
::

    TSimpleServer – 简单的单线程服务模型，常用于测试
    TThreadPoolServer – 多线程服务模型，使用标准的阻塞式IO
    TNonblockingServer – 多线程服务模型，使用非阻塞式IO(需使用TFramedTransport数据传输方式)




