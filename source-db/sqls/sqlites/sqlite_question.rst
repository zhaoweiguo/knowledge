常见问题
###########

Error: unknown command or invalid arguments:  "databases;". Enter ".help" for help::

    // 错误的
    sql> .databases;
    // 正确的
    sql> .databases


版本太低问题
============

现象::

    1. .table 命令显示为空
    2. .databases命令或select语句报以下错误:
    Error: malformed database schema (ix_stage_in_progress) - near "WHERE": syntax error


解决方案::

    sqlite版本太低, 要下载最新的sqlite
    下载地址:
    https://www.sqlite.org/download.html
    下载sqlite-autoconf-xxxxx，并安装
    说明:
    https://stackoverflow.com/questions/46083056/sqlite3-error-malformed-database-schema-mmapstatus-near-syntax-error







