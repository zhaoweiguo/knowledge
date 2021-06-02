其他命令
------------
::

    show engines; //命令可以显示当前数据库支持的存储引擎情况


察看mysql版本、时间、用户::

    mysql> SELECT VERSION(), CURRENT_DATE, NOW(), USER();


使用LOAD DATA命令载入数据::

    mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet;
    -- 其中pet.txt文件中的数据各字段以tab分隔
    -- 对无数据可以用NULL或\N来代替

    mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet
        -> LINES TERMINATED BY '\r\n';
    -- 如在windows系统下，以\r\n为行结束符


模式匹配::

    右匹配: %right
    左匹配: left%
    两边匹配: %center%
    匹配长度为2的: __ (2个下划线)
    其他扩展使用正则: REGEXP、NOT REGEXP

常用查询::

    MAX(column) --最大值





