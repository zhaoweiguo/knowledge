外键
-------

::

    FOREIGN KEY( <key_name> ) REFERENCES <tableName> (<paramName>)
    -- example
    create table <tab1> (
       <col1> int,
       foreign key(<col1>) references <tab2>(<tabCol2>)
    ) engine=innodb;


    InnoDB支持外键
    MyISAM不支持外键


