VMware
############




Installing VMware Tools::

    通过VMware菜单,点击Virtual Machine -> Install VMware Tools
    $ mkdir /mnt/cdrom
    $ mount /dev/cdrom /mnt/cdrom
    $ cp /mnt/cdrom/VMwareTools-<version>.tar.gz /tmp/
    $ cd /tmp
    $ tar -zxvf VMwareTools-version.tar.gz
    $ cd vmware-tools-distrib
    $ ./vmware-install.pl

    注: 无界面的好像安装上也没用


常见问题
==============

不能上网问题
------------

现象::

    // 没有ip地址
    $> ip a
    ens32: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500 
    ether 00:0c:29:68:22:e2  txqueuelen 1000  (Ethernet) 


解决方案 [1]_ ::

    dhclient –v


不能上网问题2 [2]_
------------------

现象::

    固定ip
    系统配置经过多次设置肯定没有问题，但就是不能上网
    原因在宿主机的问题

如何复制虚拟机 [3]_
-------------------
其实本质就是文件复制后再打开，并进行相关配置



.. [1] https://geekflare.com/no-internet-connection-from-vmware-with-centos-7/
.. [2] https://www.cnblogs.com/qiang-qiang/p/10411100.html
.. [3] https://blog.csdn.net/zbrj12345/article/details/81879455