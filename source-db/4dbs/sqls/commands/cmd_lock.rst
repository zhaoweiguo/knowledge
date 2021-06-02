lock锁相关
-------------
::

   // 特殊操作
   select * from <TAB> where <COL> > 0 for update;  // 加读锁(X锁)
   select * from <TAB> where <COL> > 0 lock in share mode;   // 加S锁

   tx_isolation: 事务的隔离级别
   1. read-uncommitted, 2. repleatable-read(默认) 3. read-committed
   select @@tx_isolation; //查询
   set @@tx_isolation='read-uncommitted';  //设定值

