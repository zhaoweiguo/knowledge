常用
####


* db排名: https://db-engines.com/en/ranking


NoSQL数据库大致可以分为四类::

    键值(key/value)数据库
    列存储数据库
    文档型数据库
    图数据库



.. image:: /images/dbs/nosql-databases-overview.png


.. figure:: /images/dbs/history-of-db.jpg

   A history of databases in No-tation


MongoDB 和 Elasticsearch 对比
=============================

使用场景::

        MongoDB 创立的初衷是为了干掉关系型数据库，和 RDBMS 算是竞争关系。
        Elasticsearch 起初就是以检索查询为主要应用场景出道，和 RDBMS 有点互相协助的意思。

相同点::

    1. 数据存储格式为 json
    2. 聚合和全文检索
    3. CRUD
    4. 分片和复制
    5. 简单的 join 操作
    6. 适用于大数据量的处理
    7. 不支持事务

不同点::

    1. 开发语言不同
        ES 的 Java 语言 (restful)
        Mongo 是 C++ 语言 (driver)
        从开发角度来看，ES 对 Java 更方便
    2. 分片方式
        ES 是 hash
        Mongo 是 range 和 hash
    3. 分布式
        ES 的主副分片自动组合和配置
        Mongo 需要手动配置集群 “路由 + 服务配置 + sharding”
    4. 索引
        ES 自建倒排索引，检索力度强
        Mongo 手动创建索引（B 树），不支持倒排索引，这点和 RDBMS 类似
    5. 检索字段
        ES 全文检索，可用的检索插件较多
        Mongo 对索引字段个数有限制，全文检索效率低乃至不采用
    6. 时效性
        ES 非实时，有丢数据的风险
        Mongo 实时，理论上无丢数据的风险

总结::

    ES 偏向于检索、查询和数据分析，适用于 OLAP（on-line Analytical Processing）系统
    Mongo 偏向于大数据下的 CRUD，适用于 OLTP（on-line Transaction Processing）系统









