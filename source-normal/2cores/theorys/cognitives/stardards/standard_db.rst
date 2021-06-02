DB规范
============


命令规范::

    数据库都以db结尾,如:
      zgmaindb, zgotherdb
      zg: 项目简称
      main/other:具体数据库名
      db:统一结尾名
    
    表名都加s,建议使用名词,如:
      users, goods
      复杂的以「下划线(_)」分隔

    索引都以idx_<tablename>_<param1>_<param2>...为格式,如:
      idx_users_uid, idx_goods_uid_gid
    
    表字段全用小写,中间可以下划线(_)分隔,如:
      user_name
      last_login_id

其他注意事项::

    数据表中数据不允许有NULL数据
    表建立完成需要审核
    表的修改要慎重、讨论并审核