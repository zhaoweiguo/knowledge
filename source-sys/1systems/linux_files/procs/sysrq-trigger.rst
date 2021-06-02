sysrq-trigger文件
#################

使用::

    # 立即重新启动计算机
    echo "b" > /proc/sysrq-trigger
    # 立即关闭计算机
    echo "o" > /proc/sysrq-trigger
    # 导出内存分配的信息 （可以用/var/log/message 查看）
    echo "m" > /proc/sysrq-trigger
    # 导出当前CPU寄存器信息和标志位的信息
    echo "p" > /proc/sysrq-trigger
    # 导出线程状态信息
    echo "t" > /proc/sysrq-trigger
    # 故意让系统崩溃
    echo "c" > /proc/sysrq-trigger
    # 立即重新挂载所有的文件系统
    echo "s" > /proc/sysrq-trigger
    # 立即重新挂载所有的文件系统为只读
    echo "u" > /proc/sysrq-trigger





