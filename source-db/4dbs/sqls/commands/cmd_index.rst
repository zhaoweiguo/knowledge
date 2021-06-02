index索引操作
----------------
* 唯一索引(UNIQUE)
* 主键索引
* 全文本索引(innodb不支持myisam支持)

查看索引::
  
    SHOW INDEX FROM <TAB>

创建索引::

    //普通索引
    CREATE INDEX <indexName> ON <tableName> (<tableColumn1>, <tableColumn2>...);      //创建索引
    ALTER table <tableName> ADD INDEX <indexName> (<tableColumn1>, <tableColumn2>...);    //修改表结构
    CREATE TABLE tableName ( [...], INDEX [indexName] (<tableColumn1>, <tableColumn2>...) //创建表的时候直接指定

    //唯一索引
    CREATE UNIQUE INDEX indexName ON <tableName> (<tableColumn1>, <tableColumn2>);
    ALTER <tableName> ADD UNIQUE <indexName> ON (<tableColumn1>, <tableColumn2>);

    // 新建表时创建索引
    CREATE TABLE tableName ( [...], UNIQUE <indexName> (<tableColumn1>, <tableColumn2>);

    // 索引某一些字段
    ALTER TABLE <tab> ADD KEY <indexName> (<column>(<Num>));  // 索引前<Num>长度的字段


删除索引::
  
    DROP INDEX <index_name> ON <tableName>;    //删除索引的语法
    ALTER TABLE <tab> DROP INDEX  <index_name>
    ALTER TABLE <tab> DROP PRIMARY KEY <key>

    
* mysql一次只使用一个索引来优化sql语句

