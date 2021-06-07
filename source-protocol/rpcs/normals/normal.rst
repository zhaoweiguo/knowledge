常用
####

* :ref:`关联：分布式系统 <distributed_sys>`

.. note:: RPC 出现的最初目的，就是为了让计算机能够跟调用本地方法一样，去调用远程方法。在RPC初期确实是奔着这个目标去做的，但这种透明的调用形式反而让程序员们误以为通信是无成本的，从而被滥用，以至于显著降低了分布式系统的性能。经过多年的教训，最后总结出了『 `通过网络进行分布式运算的八宗罪（8 Fallacies of Distributed Computing） <https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing>`_ 』

原理
====

RPC 协议，通过各种手段来解决以下三个基本问题::

    1. 如何表示数据？
    2. 如何传递数据？
    3. 如何表示方法？

如何表示数据::

    远程方法调用遇到的问题:
      面临交互双方分属不同程序语言的情况
      同一种语言的 RPC 协议，在不同硬件指令集、不同操作系统下，也完全可能有不一样的表现细节，比如:
        数据宽度、字节序的差异等

    行之有效的做法:
      是将交互双方涉及的数据，转换为某种事先约定好的中立数据流格式来传输，
      将数据流转换回不同语言中对应的数据类型来使用。
      即：序列化与反序列化

    各RPC 协议对应的序列化协议:
      ONC RPC 的 External Data Representation （XDR）
      CORBA 的 Common Data Representation（CDR）
      Java RMI 的 Java Object Serialization Stream Protocol
      gRPC 的 Protocol Buffers
      Web Service 的 XML Serialization
      众多轻量级 RPC 支持的 JSON Serialization


如何传递数据::

    在计算机科学中，专门有一个 “Wire Protocol”，用来表示两个 Endpoint 之间交换这类数据的行为
    https://en.wikipedia.org/wiki/Wire_protocol

    常见的 Wire Protocol:
    Java RMI 的 Java Remote Message Protocol（JRMP，也支持 RMI-IIOP）
    CORBA 的 Internet Inter ORB Protocol（IIOP，是 GIOP 协议在 IP 协议上的实现版本）
    DDS 的 Real Time Publish Subscribe Protocol（RTPS）
    Web Service 的 Simple Object Access Protocol（SOAP）
    如果要求足够简单，双方都是 HTTP Endpoint，直接使用 HTTP 也可以（如 JSON-RPC）

如何表示方法::

    考虑到不同语言，如何表示方法的问题:
      因为每门语言的方法签名都可能有所差别，
      所以，针对 “如何表示一个方法” 和 “如何找到这些方法” 这两个问题，我们还是得有个统一的标准。

    解决方法——使用如下标准:
      给程序中的每个方法，都规定一个通用的又绝对不会重复的编号；
      在调用的时候，直接传这个编号就可以找到对应的方法。

      DCE 还是弄出了一套跟语言无关的接口描述语言（Interface Description Language，IDL），
      成为了此后许多 RPC 参考或依赖的基础（如 CORBA 的 OMG IDL），

    并产生了应用广泛的: 唯一的 “绝不重复” 的编码方案 UUID
    https://en.wikipedia.org/wiki/Universally_unique_identifier

    用于表示方法的协议还有:
      Android 的 Android Interface Definition Language（AIDL）
      CORBA 的 OMG Interface Definition Language（OMG IDL）
      Web Service 的 Web Service Description Language（WSDL）
      JSON-RPC 的 JSON Web Service Protocol（JSON-WSP）

各类RPC
=======

几个RPC典型的发展方向::

    RPC 的一些典型发展方向，分布式对象、提升调用效率、简化调用复杂性

    1. 朝着面向对象发展
        别名叫作分布式对象（Distributed Object）
        如:
          RMI、.NET Remoting
          以前的CORBA 和 DCOM

    2. 朝着性能发展
        RPC 性能主要就两个因素：序列化效率和信息密度
        a. 序列化效率: 序列化输出结果的容量越小，速度越快，效率自然越高；
        b. 信息密度: 则取决于协议中有效荷载（Payload）所占总传输数据的比例大小，
            使用传输协议的层次越高，信息密度就越低
        
        代表: gRPC 和 Thrift
        gRPC 和 Thrift 都有自己优秀的专有序列化器，
        而在传输协议方面:
            gRPC 是基于 HTTP/2 的，支持多路复用和 Header 压缩
            Thrift 则直接基于传输层的 TCP 协议来实现，省去了额外的应用层协议的开销。

    3. 朝着简化发展
        代表为 JSON-RPC。
        它牺牲了功能和效率，换来的是协议的简单。
        也就是说，JSON-RPC 的接口与格式的通用性很好，
          尤其适合用在 Web 浏览器这类一般不会有额外协议、客户端支持的应用场合。


历史出现过的 RPC 协议 / 框架::

    RMI（Sun/Oracle）、
    Thrift（Facebook/Apache）、
    Dubbo（阿里巴巴 /Apache）、
    gRPC（Google）、
    Motan2（新浪）、
    Finagle（Twitter）、
    brpc（百度）、
    .NET Remoting（微软）、
    Arvo（Hadoop）、
    JSON-RPC 2.0（公开规范，JSON-RPC 工作组）







