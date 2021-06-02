insert命令
-----------
::

    insert into <DB>.<Table> values (<value1>, <value2>, ...);
    INSERT INTO <tbl_name> (<col1>, <col2>) VALUES(15,col1*2); 

    insert into <DB>.<table> (<col1>, <col2>)
        select <column1>, <column2>
        from <table2>
        where ...
    ;

    INSERT INTO <DB>.<TABLE> SELECT 1, REPEAT('a', 7);

    // 批量插入
    INSERT INTO <DB>.<TABLE> (<col1>, <col2> ... )
    VALUES
       (<value1.1>, <value1.2> ... ),
       (<value2.1>, <value2.2> ... ),
       ...


