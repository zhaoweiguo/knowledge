htpasswd命令
############

建一个密码文件.passwd并添加一个用户,不提示直接输入用户名密码::

    htpasswd -bc .passwd username passwd

在原有的密码文件.passwd下在添加一个用户::

    htpasswd -b .passwd user2 pwd2

删除用户::

    htpassdw -D .passwd user


不更新密码文件，只显示加密后的用户名和密码::

    htpasswd -bn user

修改用户密码::

    先删除
    htpassdw -D .passwd user
    再添加
    htpasswd -b .passwd username passwd

