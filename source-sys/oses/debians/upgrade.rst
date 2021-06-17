版本升级
#####################

Ubuntu版本升级
==============

::

    查看Ubuntu 版本指令:
    $ lsb_release -a

    执行更新命令
    $ apt-get update && apt-get dist-upgrade

    升级
    $ do-release-upgrade

    重启服务器
    $ reboot

Debian升级
==========

Debian 8 直接升级到 Debian 9::

  // 方法1
  1.更新Debian 8到最新
  aptitude update && aptitude upgrade
  2.将软件源改为Debian 9的stretch
  sed s/jessie/stretch/ /etc/apt/sources.list | tee /etc/apt/sources.list
  3.升级系统版本
  aptitude update && aptitude dist-upgrade

  // 方法2：利用iso文件
  1.挂载iso，通常是U盘，利用fdisk -l 查看U盘分区，比如我的U盘为/dev/sdc1，将iso挂载到 /cdrom 文件夹
  mount /dev/sdc1 /mnt
  mount -t iso9660 -o loop /mnt/debian-9.0.0-amd64-cd-1.iso /cdrom/
  2.修改源
  emacs /etc/apt/sources.list
  3.添加cdrom apt源:
  apt-cdrom -m -d /cdrom/ add
  4.更新系统
  aptitude update && sudo aptitude dist-upgrade











