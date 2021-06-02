partition分区表相关
==============================

range分区创建实例::

  create table <tab> (
     c1 int auto_increment primary key,
     c2 varchar(30) default "",
     c3 date default "2000-01-01"
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8
  PARTITION BY RANGE (to_days(c3))
  (
     PARTITION p1 VALUES LESS THAN (to_days('2014-09-01')),
     PARTITION p2 VALUES LESS THAN (to_days('2014-10-01')),
     PARTITION p3 VALUES LESS THAN (to_days('2014-11-01')),
     PARTITION p11 VALUES LESS THAN MAXVALUE
  )

增加分区::

  alter table <tab>
     add partition (partition <p4> values less than (to_days('2014-12-01')))

删除分区::

  alter table <tab> drop partition <p4>    --删除<p4>分区，则分区的数据也删除
  ALTER TABLE <tab> REMOVE PARTITION;    -- 删除分区(?待测)

非分区表转换为分区表::

  alter table temp_justin partition by range(to_days(create_time))
  (
     partition p14 values less than (to_days('2015-01-01')),
     partition p1501 values less than (to_days('2015-02-01')),
     partition p1502 values less than (to_days('2015-03-01')),
     partition p1503 values less than (to_days('2015-04-01')),
     partition p1504 values less than (to_days('2015-04-01')),
     PARTITION p11 VALUES LESS THAN MAXVALUE
  );

增加分区::

  // 1. 没有设定MAXVALUE的情况
  alter table wishwells add PARTITION(
      PARTITION p1607 values less than (to_days('2016-08-01'))
  );
  // 2. 设定MAXVALUE的情况
  alter table wishwells REORGANIZE PARTITION pmax into(
      PARTITION p1607 values less than (to_days('2016-08-01')),
      PARTITION p1608 values less than (to_days('2016-09-01')),
      PARTITION pmax VALUES LESS THAN MAXVALUE
  );

  

非分区表转换为分区表实例(224.6w条数据)::

  1. 为原来的主键对应字段增加索引：INDEX  （6s）——为删除主键做准备（自增字段）
     alter table exchanges add index `idx_exchange_id` (`id`);
  2. 把日期对应字段改为date类型（1 min 46.32 sec）——partition需要是date类型
     alter table exchanges CHANGE created_at created_at datetime NOT NULL DEFAULT '0000-00-00 00:00:00’;
  3. 删除主键（1 min 30.12 sec）
     alter table exchanges drop primary key;
  4. 增加新主键（3 min 2.86 sec）——主键要改成(时间+原主键为新主键)
     alter table exchanges add primary key(`id`, `created_at`);
  5. 修改为分区表（1 min 48.79 sec）
     alter table kxmaindb.exchanges
     PARTITION BY RANGE (to_days(`created_at`)) (
       PARTITION p2013 VALUES LESS THAN (to_days('2014-01-01')),
       PARTITION p2014 VALUES LESS THAN (to_days('2015-01-01')),
       PARTITION p201501 VALUES LESS THAN (to_days('2015-02-01')),
       PARTITION pmax VALUES LESS THAN MAXVALUE
     );




List分区创建::

  CREATE TABLE m (
  a INT,
  b INT)ENGINE=innnodb
  PARTITION BY LIST (b)(
  PARTITION p0 VALUES IN (1,2,3,4,5),
  PARTITION p1 VALUES IN (6,7,8,9,10));

  -- 插入的值(3,11)不符合
  -- 如果是innodb引擎,后面(4,9)符合条件不会插入表中，
  -- 如果是myisam引擎,后面(4,9)符合条件则会插入表中
  insert into m values (1,6),(2,7),(3,11),(4,9)

Hash分区创建::

  CREATE TABLE m_hash (
    a INT,
    b DATETIME
  )ENGINE=innnodb
  PARTITION BY HASH (YEAR(b))    --"partition by hash (expr)" expr是一个返回整数的表达式
  PARTITIONS 4;     --表示要被分割成分区的数量，没有则默认是1

  -- 加入分区的算法mod(expr,分区数量4)=0 则加入p0
  PARTITION BY LINEAR HASH (YEAR(b))
  --与hash只是算法不同，返回是值是一样的

COLUMNS分区::

  CREATE TABLE t_columns_range(
    a INT,
    b DATETIME
  ) ENGINE=INNODB
  PARTITION BY RANGE COLUMNS (b) --也可以PARTITION BY LESS COLUMNS (b)
  (
     PARTITION p0 VALUES LESS THAN('2009-01-01'),
     PARTITION p1 VALUES LESS THAN('2010-01-01')
  );


分析分区情况::

  explain partitions
      select count(*) from part_date3
      where c3> date '2014-01-01' and c3 <date '2014-10-31'\G

查看分区情况::

  select * from information_schema.partitions where table_name='<tabname>';
  
