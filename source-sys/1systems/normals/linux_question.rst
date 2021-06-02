.. _linux_question:

linux问题汇总
#####################


/root挂载点没空间解决方案
-------------------------
::

    > dpkg –get-selections|grep linux
    > apt-get remove <soft_version>

64位ubuntu14.04运行32位程序::

    To run 32bit executable file in a 64 bit multi-arch Ubuntu system, 
    you have to add i386architecture and install libc6:i386,libncurses5:i386,libstdc++6:i386 these 3 lib packages.
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
    sudo apt-get install libz1:i386




.. _linux_question_dudf:

使用du与df命令查看磁盘容量不一致
--------------------------------

问题
^^^^

问题1:执行df -h查看文件系统的使用率，可以看到/dev/xvdb1磁盘占用了约27G，挂载目录为/opt::

    # df -h
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/vda1        99G   84G  9.8G  90% /
    ...

进入到/opt目录执行du -sh，显示空间总占用量约2.4G，即df与du命令查看到的结果不一致::

    $> du -hs
    14.7G  /

问题2:通过df -h命令查看磁盘使用情况显示的是负值，如下图所示::

    # df -h
    Filesystem      Size  Used    Avail   Use%    Mounted on
    /dev/vda1        99G   -5.4G  9.8G    90%      /
    ...

* 问题3:执行du和df命令显示的容量不一致，df比du命令显示的数据大很多

* 问题4:使用df命令查询磁盘占用率很高，但是用du命令统计目录时却发现很低，且查不到已删除的句柄文件
* 问题5:当前系统存在数据盘挂载点.使用df命令查看系统盘占用容量已满,但是在根目录下使用du命令统计各文件总容量,合计并达不到总容量

问题原因
^^^^^^^^^^^^

* 问题1的原因是用户删除了大量的文件后，du命令就不会在文件系统目录中统计这些文件::

    如果此时还在运行中的进程持有这个已经被删除的文件句柄，那么这个文件就不会真正在磁盘中被删除
      分区超级块中的信息也就不会更改，df命令仍会统计这个被删除的文件。
    通过lsof命令查询处于deleted状态的文件，被删除的文件在系统中被标记为deleted
    如果系统有大量deleted状态的文件，会导致du和df命令统计结果不一致。 

可在opt目录下执行如下命令查看::

    lsof |grep deleted

* 问题2的原因是Linux系统磁盘分区有保留区的概念,会给root或指定用户预留5%或更大的空间::

    当使用到这块保留区的空间时，fdisk命令的计算将会是负数
    ext文件系统（包括 ext2、ext3、ext4）都会默认预留5%的磁盘空间
        使用root用户维护系统或记录系统关键日志使用


* 问题3的原因是当用 ``du -sh *`` 命令来统计目录总容量时，如果该路径下包含隐藏文件，不会包含在统计结果里

* 问题4的原因是由于删除了大量小文件，导致inode释放出现问题
* 问题5的原因是由于数据盘挂载前该路径下就存在文件，挂载后用du无法查询到原路径文件


解决方案
^^^^^^^^

本文主要针对以上五种问题，提供以下解决方案::

    问题1的解决方法是根据lsof列出的进程号，终止相应进程或者重启相应的服务
      也可以重启实例，重启实例系统会退出现有的进程，开机后重新加载过程中，会释放调用的deleted文件的句柄
      提示：如果ECS实例正在运行业务进程，终止进程时请慎重操作。
    问题2的解决方法是通过rm命令删除磁盘中的大文件，释放预留空间的占用后，再通过df命令查询磁盘占用即可恢复正常
    问题3的解决方法是执行du -ah命令即可在统计结果中包含隐藏文件
    问题4的解决方法是执行fsck命令后即可恢复正常
    问题5的解决方法是卸载数据盘后再次使用du命令查询即可查到数据









