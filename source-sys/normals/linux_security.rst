linux安全
------------------

限制root用户登录::

    方法一：修改/etc/ssh/sshd_config文件，将其中的PermitRootLogin改成no，然后重新启动ssh服务就可以了
    /etc/rc.d/sshd restart

    方法二：在/etc/default/login 文件，增加一行设置命令
    CONSOLE = /dev/tty01   设置后立即生效,无需重新引导
    以后，用户只能在控制台（/dev/tty01）root登录，从而达到限制root远程登录
    不过，同时也限制了局 域网用户root登录，给管理员的日常维护工作带来诸多不便

ssh暴力破解::

    // 有多少个IP在暴利破解我的root
    grep "Failed password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more
    // 有多少个IP在暴利ssh破解
    grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

安全模块::

    Ubuntu 和 SuSE 默认使用 AppArmour
    RedHat 一直以来都支持 SELinux
    一个新的选择是 GrSSecurity



    
