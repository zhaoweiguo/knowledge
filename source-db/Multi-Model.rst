多模 DB
#######


ArangoDB
========

* 官网: https://www.arangodb.com
* GitHub: https://github.com/arangodb/arangodb/ ::

    源码: JavaScript/C++
    开源协议: Apache 2.0
    star: 11.3k(2021-07-07)


ArangoDB 数据库模型::

    1. Document 文档
        您可以在文档中存储海量数据（文件大小默认最大值为 32MB，但可以根据实际需要进行配置）。
        ArangoDB 功能强大，应用范围广泛，可用于查询和处理诸如 JOINs、辅助索引或 ACID 事物之类的文档。
        您还可以在 JOIN 连接上实现水平扩展。
    2. key/value 键 / 值
        每个 document 文档里均有唯一的键和与其对应的值（键 / 值对）。
        如果您在 document 文件中存储一个值，那么 ArangoDB 可用作经典的、高度可扩展的键 / 值对存储，
        例如用户在电子商务平台上将商品临时存储在购物车里或物联网应用程序中的传感数据等。
    3. Graph 图
        ArangoDB 包含了 graph 图形存储的完整功能集。
        例如模式匹配、最短路径、完全遍历等。与当前许多主流的图形处理方法相比，ArangoDB 可以快速执行图形查询。














