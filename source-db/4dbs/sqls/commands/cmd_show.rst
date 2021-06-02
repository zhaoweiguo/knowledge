show查看相关命令
--------------------

* Show命令::

    我们可以通过show命令查看MySQL状态及变量，找到系统的瓶颈：
    Mysql> show status ——显示状态信息（扩展show status like ‘XXX’）
    Mysql> show variables ——显示系统变量（扩展show variables like ‘XXX’）
    show session variables;
    show global variables;
    select @@global.var_name;
    show global variables like "%var%";
    set session var_name = value;
    set @@session.var_name = value;
    set var_name = value;
    查看一个会话变量也有如下三种方式：
    select @@var_name;
    select @@session.var_name;
    show session variables like "%var%";

    set global var_name = value; //注意：此处的global不能省略。根据手册，set命令设置变量时若不指定GLOBAL、SESSION或者LOCAL，默认使用SESSION
    set @@global.var_name = value; //同上
    
    Mysql> show processlist ——查看当前SQL执行，包括执行状态、是否锁表等
    Shell> mysqladmin variables -u username -p password——显示系统变量
    Shell> mysqladmin extended-status -u username -p password——显示状态信息


Mysql> show engine innodb status ——显示InnoDB存储引擎的状态::

  INNODB MONITOR OUTPUT
  1.BACKGROUND THREAD
  
  2.SEMAPHORES
  主要显示系统的当前的信号等待信息及各种等待信号的统计信息，这部分对调整innodb_thread_concurrency参数有非常大的帮助。当等待信号量非常大的时候，可能就需要禁用并发线程检测设置innodb_thread_concurrency=0;
  3.LATEST DETECTED DEADLOCK
  主要展示系统的锁等待信息和当前活动事务信息，通过这部分，可以追踪到死锁的详细信息。
    3.1TRANSACTIONS
    3.2WAITING FOR THIS LOCK TO BE GRANTED
  4.FILE I/O
  文件I/O相关信息，主要是IO等待信息。
  5.INSERT BUFFER AND ADAPTIVE HASH INDEX
  显示插入缓存当前状态信息及自适应hash index的状态
  6.LOG
  Innodb 事务日志相关信息，包括当前的日志序列号（Log sequence number），已经刷新同步到那个序列号，最近的check point到那个序列号了。除此之外，还显示了系统从启动到现在已经做了多少次check point，多少次日志刷新
  7.BUFFER POOL AND MEMORY
  主要显示innodbbuffer pool相关的各种统计信息，以及其他一些内存使用情况。
  8.ROWOPERATIONS
  主要显示的是与客户端的请求query和query所影响的记录统计信息
  
  
  

* 查看状态变量及帮助::

    Shell> mysqld –verbose –help [|more #逐行显示]

* 比较全的Show命令的使用可参考： http://blog.phpbean.com/a.cn/18/

