event事件调度器
---------------------
* 基本操作::

    // 查看是否已开启事件调度器
    SHOW VARIABLES LIKE 'event_scheduler';
    或
    SELECT @@event_scheduler;
    或
    SHOW PROCESSLIST;

    // 设定事件调度器
    SET GLOBAL event_scheduler = 1;
    SET GLOBAL event_scheduler = ON;

    // 查看
    SHOW EVENTS;
    // 查看具体事件
    SHOW CREATE EVENT <eventName>;

* 创建语法::

    CREATE EVENT [IF NOT EXISTS] event_name
    ON SCHEDULE <schedule>
    [ON COMPLETION [NOT] PRESERVE]
    [ENABLE | DISABLE]
    [COMMENT 'comment']
    DO sql_statement;

    <schedule>:
    AT TIMESTAMP [+ INTERVAL INTERVAL]    // 多长时间后执行
    | EVERY INTERVAL [STARTS TIMESTAMP] [ENDS TIMESTAMP]    // 在设定时间内,每隔多长时间执行一次

    INTERVAL:
    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
            WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
            DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}

* 实例(每秒插入一条记录)::

    CREATE EVENT e_test_insert
    ON SCHEDULE EVERY 1 SECOND 
    COMMENT '测试事件调试'
    DO INSERT INTO <db>.<table> VALUES (<id>, <name>);

* 实例(5天后清空test.aaa表)::

    CREATE EVENT e_test
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 5 DAY
    DO TRUNCATE TABLE test.aaa;

* 修改事件(ALTER EVENT)::

    ALTER EVENT event_name
    [ON SCHEDULE schedule]
    [RENAME TO new_event_name]
    [ON COMPLETION [NOT] PRESERVE]
    [COMMENT 'comment']
    [ENABLE | DISABLE]
    [DO sql_statement]

    临时关闭事件
    ALTER EVENT e_test DISABLE;
    开启事件
    ALTER EVENT e_test ENABLE;
    将每天清空test表改为5天清空一次：
    ALTER EVENT e_test
    ON SCHEDULE EVERY 5 DAY;

* 删除事件(DROP EVENT)::

    DROP EVENT [IF EXISTS] event_name

