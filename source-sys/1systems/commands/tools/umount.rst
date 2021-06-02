umount命令
==============


::

   umount <挂载点|设备>
   $ umount /mnt
   or
   $ umount /dev/hdb1
   

实践-网络磁盘强制umount [1]_ ::

    $> umount -f /opt/IOT
    umount.nfs4: /opt/IOT: device is busy
    $> cat /proc/mounts
    10.140.2.5:/opt/IOT /opt/IOT nfs4 rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=10.140.2.19,local_lock=none,addr=10.140.2.5 0 0

    $ umount –lf  /home/lanyang/nfs_mount
    # -f Force unmount (in case of an unreachable NFS system). (Requires kernel 2.1.116 or later.)
    # -l Lazy unmount. Detach the filesystem from the filesystem hierarchy now, and cleanup all references to the filesystem as soon as it is not busy anymore. (Requires kernel 2.4.11 or later.)


    kill占用进程:
    $ fuser –m –v /home/lanyang/nfs_mount
    USER        PID ACCESS COMMAND
    /home/lanyang/nfs_mount:
    ….
    lanyang   21691 .rce. ls

    // kill掉占用进程后，就可以保证顺利重新mount
    $ kill -9 21691


.. note:: 
    有同学可能会有疑问，为什么不是先kill占用进程，再强制umount？ 
    原因是如果首先执行fuser命令会一直卡住，无法操作，必须强制umount后，才可以继续执行fuser命令。



.. [1] https://blog.csdn.net/lanyang123456/article/details/55001333