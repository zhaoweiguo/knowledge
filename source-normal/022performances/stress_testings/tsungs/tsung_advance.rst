.. _tsung_advance:

高级配置
=========

多用户进行tsung测试::

  这儿要注意：
    1. 所有clients中的用户都必须相同(可新建用户tsung专门用于测试)
    2. 所有的client和server之间必须建立ssh免登录认证(ssh免登录操作)
    3. erlang版本必须相同
    4. tsung.xml文件存放目录相同，并且文件内容也相同

  需要做的操作:
    1. 增加用户并加入管理员群组，命令：useradd -g admin username(这个用户名就是你想要的用户名)，(其他用户命令详见这儿)
    2. 在所有clients下这一用户的主目录下新建文件夹.tsung、.ssh
    3. ssh免登录操作
    4. 把tsung.xml文件复制到.tsung目录下
