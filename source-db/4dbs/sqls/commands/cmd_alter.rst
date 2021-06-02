alter修改表字段
----------------------
::

    //修改字段名
    ALTER TABLE <tablename> CHANGE <oldcol> <newcol> varchar(200) PRIMARY KEY COMMENT "<comment>";
    //增加字段
    ALTER TABLE <tablename> ADD <newcol> varchar(200) NOT NULL default <value> comment "<comment>";
    ALTER TABLE <tablename> ADD <newcol> varchar(200) NOT NULL default <value> comment "<comment>" AFTER <col>;
    //增加主键
    ALTER TABLE trb1 ADD PRIMARY KEY (id);
    //删除字段
    ALTER TABLE <table_name> DROP COLUMN <column_name>;

    //增加主键设置
    ALTER TABLE <table_name> ADD PRIMARY KEY (<column_name1>, <column_name2>...);
