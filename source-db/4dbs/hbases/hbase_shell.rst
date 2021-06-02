HBase Shell
################

HBase Shell 入门
-----------------------

连接到HBase::

    $ ./bin/hbase shell

2. 帮助::

    hbase(main):001:0>help

3. 创建表::

    // 必须输入表的名称和ColumnFamily的名称
    hbase(main):001:0> create 'test', 'cf'
    0 row(s) in 0.4170 seconds
    => Hbase::Table - test

4. 查询表信息::

    // 使用list命令来查询表
    hbase(main):002:0> list 'test'
    TABLE
    test
    1 row(s) in 0.0180 seconds
    => ["test"]

5. 往表里面插入记录::

    // 在hbase中，往表里面写一行记录的命令叫做put
    hbase(main):003:0> put 'test', 'row1', 'cf:a', 'value1'
    0 row(s) in 0.0850 seconds
    hbase(main):004:0> put 'test', 'row2', 'cf:b', 'value2'
    0 row(s) in 0.0110 seconds
    hbase(main):005:0> put 'test', 'row3', 'cf:c', 'value3'
    0 row(s) in 0.0100 seconds

    说明:
    这里我们写入了三条数据，
    前面的rowx，代表写入的表的rowkey，也就是主键。
    后面的cf:x，是我们的自定义列，可以有无数多个，这里写了3个。
    我们叫这个a，b，c为qualifier，也就是列名。

6. 查询表中的所有数据::

    hbase(main):006:0> scan 'test'
    ROW            COLUMN+CELL
    row1          column=cf:a, timestamp=1421762485768, value=value1
    row2          column=cf:b, timestamp=1421762491785, value=value2
    row3          column=cf:c, timestamp=1421762496210, value=value3
    3 row(s) in 0.0230 seconds

7. 查询单条记录::

    hbase(main):007:0> get 'test', 'row1'
    COLUMN          CELL
    cf:a           timestamp=1421762485768, value=value1
    1 row(s) in 0.0350 seconds

8. 禁用一张表::

    hbase(main):008:0> disable 'test'
    0 row(s) in 1.1820 seconds
    hbase(main):009:0> enable 'test'
    0 row(s) in 0.1770 seconds

    说明:
    如果你想要删除一张表，或者改变一张表的设置，或者其他类似的场景。
    你需要先禁用这张表，使用disable命令能够禁用一张表，使用enable命令能够取消禁用，恢复禁用的表。

9. 删除一张表::

    hbase(main):011:0> drop 'test'
    0 row(s) in 0.1370 seconds




