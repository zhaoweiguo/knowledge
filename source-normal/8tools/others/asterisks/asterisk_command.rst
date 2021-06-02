.. _asterisk_command:

asterisk命令
######################

::

    asterisk start      # 开启asterisk
    asterisk -r         # 在控制台直接启动
    asterisk -cvvv      # 启动并连接到CLI, 使用3级复杂度调试
    asterisk -vvvr      # 连接到CLI，使用3级复杂度调试
    asterisk -x         # 

有用的CLI命令::

    core show help      # 帮助
    core restart now    # 重启asterisk
    core stop now       # 
    core restart now    # 

    sip show peers      # 列出所有的sip设备
    dialplan show       # 显示所有激活的dialplan(包含但不限于extensions.conf中的配置)
    

