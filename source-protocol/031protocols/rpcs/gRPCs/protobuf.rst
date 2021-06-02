protobuf
###############

Protocol Buffer，是Google内部使用一种语言中立、平台中立和可扩展的序列化结构化数据的方式，并提供 Java、C++ 和 Python 这三种语言的实现，每一种实现都包含了相应语言的编译器以及库文件，而且它是一种二进制的格式，所以其速度是使用 XML 进行数据交换的10倍左右。它主要用于两个方面：其一是RPC通信，它可用于分布式应用之间或者异构环境下的通信。其二是数据存储方面，因为它自描述，而 且压缩很方便，所以可用于对数据进行持久化，比如存储日志信息，并可被Map Reduce程序处理。与Protocol Buffer比较类似的产品还有Facebook的 Thrift ，而且 Facebook 号称Thrift在速度上还有一定的优势。

proto3
======

* Developer Guide: https://developers.google.com/protocol-buffers/docs/proto3


proto2
======

* Developer Guide: https://developers.google.com/protocol-buffers/docs/proto




protoc
======

简介::

    protoc 是 protobuf 文件（.proto）的编译器
    可以借助这个工具把 .proto 文件转译成各种编程语言对应的源码，包含数据类型定义、调用接口等


设计::

    protoc 在设计上把 protobuf 和不同的语言解耦了
    底层用 c++ 来实现 protobuf 结构的存储，然后通过插件的形式来生成不同语言的源码

    可以把 protoc 的编译过程分成简单的两个步骤（如图所示）:
    1）解析.proto 文件，转译成 protobuf 的原生数据结构在内存中保存
    2）把 protobuf 相关的数据结构传递给相应语言的编译插件
        由插件负责根据接收到的 protobuf 原生结构渲染输出特定语言的模板

.. image:: /images/protocols/protobuf1.png

.. note:: 包含的插件有 csharp、java、js、objectivec、php、python、ruby 等(不包含golang)

实例::

    protoc --proto_path=IMPORT_PATH --cpp_out=DST_DIR --java_out=DST_DIR \
        --python_out=DST_DIR --go_out=DST_DIR --ruby_out=DST_DIR \
        --objc_out=DST_DIR --csharp_out=DST_DIR path/to/file.proto





参考
====


* Protocol Buffers - Google's data interchange format: https://github.com/protocolbuffers/protobuf

* protobuf's documentation on the Google Developers site: https://developers.google.com/protocol-buffers/
* gotutorial: https://developers.google.com/protocol-buffers/docs/gotutorial



