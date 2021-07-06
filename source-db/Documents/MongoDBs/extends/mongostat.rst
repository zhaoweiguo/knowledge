
mongostat
=========

说明::

    查看实时的运行状况

格式::

    > mongostat [--host {ip}:{port}] [-u {user} -p {password} --authenticationDatabase {dbName}]

.. image:: /images/dbs/mongodbs/mongostat1.png

说明::

    insert、delete、update 和 query 指示了该时段每秒执行的次数，可以粗略评估数据库压力
    其它字段也可以作为参考，比如:
      vsize（占用多少兆的虚拟内存）
      res（占用多少兆的物理内存）
      net_in（入网流量）
      net_out（出网流量
      conn（当前连接数）


