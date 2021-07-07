select命令
-------------
::

        SELECT * FROM [tabName];//
        SELECT * FROM [table name] WHERE [field name] = "whatever";
        SELECT * FROM [table name] WHERE [field name] <> "whatever";  //不等于
        SELECT * FROM [table name] WHERE name = "Bob" AND phone_number = '3444444';

        // 模糊查询
        SELECT * FROM [table name] WHERE name like "Bob%";

        //取出满足条件的5条记录
        SELECT * FROM [table name] limit 1,5;
        select top 5 * from <tableName>; //不是sql92标准

        //索引相关
        // 选择使用索引"PRI和ziduan1_index"
        select * from table USE index(PRI,ziduan1_index) limit 2;
        // 强制使用索引"PRI和ziduan1_index"
        select * from table force index(PRI,ziduan1_index) limit 2;
        // 禁止使用索引"PRI,ziduan1_index"
        select * from table ignore index(PRI,ziduan1_index) limit 2;

        //特殊处理——消重、排序
        SELECT DISTINCT [column name] FROM [table name];//得到結果并消重
        SELECT [col1],[col2] FROM [table name] ORDER BY [col1, col2] DESC;//对結果按降序排列(升序用ASC)

        //一些常用内置函数
        SELECT COUNT(*) FROM [table name];//得到记录的得条数
        SELECT SUM([column name]) FROM [table name];//得到这列所有数的和.注:此列为数字

连表查询::

        // example 1
        select * from (
          select <column> count(<column> as <column2> 
          from <tab> group by <column>
        ) as <tab2>
        where <tab2>.<column>=<???>

        // example 2
        SELECT * FROM <tab1> LEFT JOIN <tab2> ON <tab1>.<field1> = <tab2>.<field2>



做一个简单的计算器::

        mysql> SELECT SIN(PI()/4), (4+1)*5;
        mysql> SELECT CURDATE(), YEAR(CURDATE()), RIGHT(CURDATE(), 5), MOD(MONTH(CURDATE()), 12);
        说明> | 当前时间 | 当前时间年份 | 从右数5位数 | 用前面的值除后面的取余数
        result> | 2012-05-30 |            2012 | 05-30               | 5    |
        mysql> SELECT PASSWORD('password');

时间处理::

        select timestampdiff(YEAR, '2010-04-01','2013-09-01');
        -- 3
        select timestampdiff(YEAR, '2010-04-01','2013-09-01');
        -- 41
        select timestampdiff(DAY, '2013-04-01','2013-09-01');
        -- 153
        select unix_timestamp('2013-05-26 14:42:24')-unix_timestamp('2013-05-26 14:39:44');
        -- 160(s)

正则处理::

    // 指定列是否含有手机号
    SELECT COUNT(1) FROM t_user WHERE user_name REGEXP ".[1][35678][0-9]{9}.";
    // 指定列是否是手机号
    SELECT COUNT(1) FROM t_user WHERE user_name REGEXP "^[1][35678][0-9]{9}$";









