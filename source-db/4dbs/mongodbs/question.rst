常见问题
########


todo
====

* Mongo索引正序、反序创建索引有什么区别
* 分片表，不分片的话，一个db使用一个shard，另一个db使用另一个shard?

done
====

Why does Mongo hint make a query run up to 10 times faster? [1]_ ::

    Mongo uses an algorithm to determine which index to be used when no hint is provided and then caches the index used for the similar query for next 1000 calls

    But whenever you explain a mongo query it will always run the index selection algorithm, thus the explain() with hint will always take less time when compared with explain() without hint.

    Similar question was answered here Understanding mongo db explain


db.collection.explain().find()方法与db.collection.find().explain()类似，但是存在以下关键差异 [2]_ ::

    The db.collection.explain() method wraps the explain command and 
        is the preferred way to run explain.
    db.collection.explain().find() is similar to db.collection.find().explain() 
        with the following key differences:

    1. The db.collection.explain().find() construct allows for 
        the additional chaining of query modifiers. 

    2. The db.collection.explain().find() returns a cursor, 
        which requires a call to .next(), or its alias .finish(), 
        to return the explain() results. 

    3. If run interactively in the mongo shell, 
        the mongo shell automatically calls .finish() to return the results. 
    4. For scripts, however, you must explicitly call .next(), or .finish(), 
        to return the results. 

    For list of cursor-related methods, see db.collection.explain().find().help().

    db.collection.explain().aggregate() is equivalent 
        to passing the explain option to the db.collection.aggregate() method.

创建索引时注意不要有空格::

    当使用db.<table>.createIndex({"user_id ":1}, {background: true})
    [
        {
            v: 2,
            key: {
                user_id: 1
            },
            name: "user_id_ 1",
            ns: "db.<table>",
            background: true
        }
    ]

    这样索引使用的key是"user_id "而不是"user_id"





.. [1] https://stackoverflow.com/questions/7730591/why-does-mongo-hint-make-a-query-run-up-to-10-times-faster
.. [2] MongoDB 执行计划获取: https://blog.csdn.net/leshami/article/details/53521990