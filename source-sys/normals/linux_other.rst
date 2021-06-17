.. _linux_other:

Linux其他
========================

使用nfsd远程共享目录::

    //1.本地:
    // 开启nfsd服务
    sudo nfsd enable
    // 设定共享目录
    sudo cat << EOF >> /etc/exports
        /<workspace>/www -alldirs -ro -network 192.168.0.0 -mask 255.255.0.0
    EOF
    // 更新配置
    sudo nfsd update

    // mac下使用这两个命令检查已启动的NFS共享目录：
    nfsd checkexports
    showmount -e <host>     //查看此host下的共享目录

    2.远程机器:
    sudo umount -l /disk
    sudo mount -t nfs -o rw <本地ip>:/<workspace>/www /disk


