.. _simple:

临时命令
=============

* hostname::

    得到当前os的hostname::

        hostname

    临时修改hostname::

        hostname <newhostname>

* hostnamectl::
  
    查看hostname
    [root@client ~]#  hostnamectl
       Static hostname: n/a
    Transient hostname: hello.hostname
             Icon name: computer-vm
               Chassis: vm
            Machine ID: b4ffb57ff9244fc8b0caf9e4dd397d86
               Boot ID: 66c004e580264e0cb54d733e11e8cfab
        Virtualization: vmware
      Operating System: CentOS Linux 7 (Core)
           CPE OS Name: cpe:/o:centos:centos:7
                Kernel: Linux 3.10.0-957.21.3.el7.x86_64
          Architecture: x86-64

    设置hostname
    [root@client ~]# hostnamectl set-hostname client
    [root@client ~]# hostname
    client
    [root@client ~]# cat /etc/hostname
    client







