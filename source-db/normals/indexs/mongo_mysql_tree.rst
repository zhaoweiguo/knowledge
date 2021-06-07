.. _mongo_mysql_tree:

为什么 MongoDB 索引选择B-树,而 Mysql 索引选择B+树
=================================================

:ref:`索引树 <b-b+_tree>`

关系型数据库是如何存储的：

.. image:: /images/dbs/normals/index_mysql1.png

聚合型数据库存储模型：

.. image:: /images/dbs/normals/index_mongo1.png

bson 的格式表示如下::

    // Customer
    {
        "id": 1,
        "name": Tom,
        "billingAddress": [{"city":"China"}]
    }

    // Orders
    {
        "id": 99,
        "orderItem": [
            "productId": 27,
            "price": 100,
            "productName": book
        ],
        "shippingAddress": [{"city": "china"}],
        "orderPayment": [
          ...
        ]
    }

为什么 MongoDB 使用B-树::

    MongoDB 是一种 nosql，也存储在磁盘上，被设计用在 数据模型简单，性能要求高的场合。

    性能要求高，看看B/B+树的区别第一点:
    B+树内节点不存储数据，所有 data 存储在叶节点导致查询时间复杂度固定为 log n。
    而B-树查询时间复杂度不固定，与 key 在树中的位置有关，最好为O(1)

为什么 Mysql 使用B+树::

    Mysql 是一种关系型数据库，区间访问是常见的一种情况，而 B-树并不支持区间访问
    而B+树由于数据全部存储在叶子节点，并且通过指针串在一起，这样就很容易的进行区间遍历甚至全部遍历。

    B/B+树的区别第二点:
    B+树叶节点两两相连可大大增加区间访问性，可使用在范围查询等
    而B-树每个节点 key 和 data 在一起，则无法区间查找。



