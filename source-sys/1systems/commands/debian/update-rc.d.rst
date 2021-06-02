.. _update-rd.d:

update-rd.d命令
====================

* 用法::

       update-rc.d [-n] [-f] <basename> remove
       update-rc.d [-n] <basename> defaults [NN | SS KK]
       update-rc.d [-n] <basename> start|stop NN runlvl [runlvl] [...] .
       update-rc.d [-n] <basename> disable|enable [S|2|3|4|5]
                   -n: not really
                   -f: force

* 实例::

    // nginx已经在/etc/init.d下面了
    update-rc.d -f nginx defaults # 新增服务
    update-rc.d -f nginx remove   # 删除服务



