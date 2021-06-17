.. _useradd:

useradd命令
============

简介::

    create a new user or update default new user information

概要SYNOPSIS::

       useradd [options] LOGIN

       useradd -D

       useradd -D [options]

DESCRIPTION::

      -m, --create-home:
      创建home目录
      -s, --shell SHELL
      指定shell脚本，如 ``/bin/bash``
       -d <home目录>
      -G, --groups GROUP1[,GROUP2,...[,GROUPN]]]





如何增加一个有root权限的用户::

  //修改/etc/sudoers文件，修改命令必须为visudo才行(为安全用此命令):
    sudo visudo

  修改里面的内容完成，可以使用如下命令查看你具有何权利:
    sudo -l
  /etc/sudoers文件


**举例说明**

实例一::

  useradd -m -s /bin/bash gordon
  useradd -G test -d /tmp/usr1 usr1

  adduser --disabled-login --gecos 'GitLab' git    // 禁止登录


::

    useradd -m -s /bin/bash $1
    usermod -a -G adm $1

