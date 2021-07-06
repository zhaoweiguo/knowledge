.. _sqlite_command:

sqlite基本命令
####################

创建、进入指定db::

    // 进入指定目录
    $> cd xxxx
    // 创建/进入指定db
    $> sqlite3 test.db   // 代替create database和use db命令

基本命令::

    .databases
    .tables
    .exit/.quit

    .header on/off          --开启/关闭头显示
    .echo ON|OFF            --
    .timer ON|OFF 
    .schema <tableName>     --查看表结构

    .read <fileName>        --运行<fileName>里的sql

    .dbinfo ?DB?            -- 查看数据库情况


表相关::

    -- 创建表
    CREATE TABLE company(
      # 注意1: mysql是AUTO_INCREMENT
      # 注意2:AUTOINCREMENT is only allowed on an INTEGER PRIMARY KEY
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      NAME           TEXT    NOT NULL,
      AGE            INT     NOT NULL,
      ADDRESS        CHAR(50),
      SALARY         REAL
      KEY idx_name(name));
    
    -- 删除表
    DROP TABLE database_name.table_name;




增删改查::
    
    select * from company where type="table";
    select * from company where type="table" and name="<tableName>";

    update users set user_admin=1 where id=123;

数据导出::

    .output <fileName>       --設定输出到<fileName>
    select * from <tableName>   --输出会写入到<fileName>文件中
    .output stdout              --恢复

数据库清理::

    VACUUM
    VACUUM 命令通过复制主数据库中的内容到一个临时数据库文件，然后清空主数据库，并从副本中重新载入原始的数据库文件
    这消除了空闲页，把表中的数据排列为连续的，另外会清理数据库文件结构。

    // 手动 VACUUM
    1. 在命令提示符中对整个数据库发出 VACUUM 命令
    $sqlite3 database_name "VACUUM;"
    2.  SQLite 提示符中运行 VACUUM
    sqlite> VACUUM;
    3. 在特定的表上运行 VACUUM
    sqlite> VACUUM table_name;

    // 自动 VACUUM
    SQLite 的 Auto-VACUUM 与 VACUUM 不大一样，它只是把空闲页移到数据库末尾，从而减小数据库大小
    通过这样做，它可以明显地把数据库碎片化，而 VACUUM 则是反碎片化。所以 Auto-VACUUM 只会让数据库更小
    1. 在 SQLite 提示符中，您可以通过下面的编译运行，启用/禁用 SQLite 的 Auto-VACUUM:
    sqlite> PRAGMA auto_vacuum = NONE;  -- 0 means disable auto vacuum
    sqlite> PRAGMA auto_vacuum = INCREMENTAL;  -- 1 means enable incremental vacuum
    sqlite> PRAGMA auto_vacuum = FULL;  -- 2 means enable full auto vacuum
    2. 从命令提示符中运行下面的命令来检查 auto-vacuum 设置
    $sqlite3 database_name "PRAGMA auto_vacuum;"

    // 脚本自动执行
    sqlite3 /var/lib/grafana/grafana.db << EOF
    VACUUM;
    .quit
    EOF






