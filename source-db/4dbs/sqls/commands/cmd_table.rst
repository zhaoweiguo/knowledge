表级操作
------------
::

    //查看本DB的所有表
    show tables;
    //查看表的创建信息
    show create table <tablename>;

    //显示表的当前状态值
    show table status\G
    show table status like '<tablename>'\G

    //查看数据表的详细结构
    describe(desc) [table name];

    //修改表属性
    alter table <tableName> type=innodb;
    //修改表名
    alter table <tableName> rename to <newTableName>

    // 修改表的自增id
    alter table tablename auto_increment=1

创建表时指定类型(MyISAM, InnoDB)::

    create table <tableName>  ( 
        id int(11)  unsigned AUTO_INCREMENT PRIMARY KEY COMMENT "主键id",       -- 自增主键
        userId varchar(20) NOT NULL COMMENT "用户id",        -- 非空
        date  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 时间类型，非空，默认是当前时间
        <field> <type> comment "<comment>"
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

    
    // 创建一个新表<table1>具有<table2>结构
    CREATE TABLE <table1> LIKE <table2>;
