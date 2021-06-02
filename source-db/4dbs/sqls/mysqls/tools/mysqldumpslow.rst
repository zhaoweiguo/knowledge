.. _mysqldumpslow:

mysqldumpslow——MySQL自带慢查询工具
##############################################

命令::

    Usage: mysqldumpslow [ OPTS... ] [ LOGS... ]
    Parse and summarize the MySQL slow query log

选项::

  -v(--verbose)
   verbose
  -d(--debug)
    查错

  -s ORDER
    what to sort by (t, at, l, al, r, ar etc), 'at' is default //排序方式query次数，时间，lock的时间和返回的记录数来排序

  -r
    reverse the sort order (largest last instead of first) //倒排序

  -t NUM
    just show the top n queries //显示前N多个

  -a
   don't abstract all numbers to N and strings to 'S'

  -n NUM
   abstract numbers with at least n digits within names //抽象的数字，至 少有n位内的名称

  -g PATTERN
   grep: only consider stmts that include this string  //配置模式

  -h HOSTNAME
   hostname of db server for *-slow.log filename (can be wildcard), //mysql所以机器名或者IP
   default is '*', i.e. match all

  -i NAME
   name of server instance (if using mysql.server startup script)

  -l
   don't subtract lock time from total time//总时间中不减去锁定时间



实例::

    # ./mysqldumpslow -s r -t 20 /usr/local/mysql/mysql-slow.log
    # ./mysqldumpslow -s r -t 20 -g 'count' /usr/local/mysql/mysql-slow.log




