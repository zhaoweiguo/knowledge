删除索引
########


删除单个索引::

    db.COLLECTION_NAME.dropIndex("INDEX-NAME")


删除所有索引::

    db.collection.dropIndexes();

重建索引::

    一个表经过很多次修改后,导致表的文件产生空洞,索引文件也如此.
    可以通过索引的重建,减少索引文件碎片,并提高索引的效率.

    类似mysql中的optimize table
    db.collection.reIndex()






