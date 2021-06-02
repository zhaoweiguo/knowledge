.. _os_ubuntu_dpkg:

dpkg使用快速参考
======================

查看是否安装包::

    dpkg -l | grep xxx

安装.deb文件::

    dpkg -i ****.deb

察看glibc版本号::

    dpkg-query -l glibc*

修改时区::

     dpkg-reconfigure tzdata.


例::

    sudo dpkg -i wiznote_1.0-1_i386.deb