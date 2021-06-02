日志文件
########

linux系统日志文件通常在/var/log目录中::

    /var/log/messages ---------系统启动后的信息和错误日志
    /var/log/secure ------------与安全相关的日志信息
    /var/log/maillog ------------与邮件相关的日志信息
    /var/log/cron ----------------与定时任务相关的日志信息
    /var/log/spooler ------------与UUCP和news设备相关的日志信息
    /var/log/boot.log -----------守护进程启动和停止相关的日志消息
    /var/log/wtmp ---------------永久记录每个用户登录、注销及系统的启动、停机的事件
    /var/run/utmp ---------------记录当前正在登录系统的用户信息；
    /var/log/btmp ----------------记录失败的登录尝试信息。



.. note:: 不同linux发行版文件名可能有稍许不同, 具体可以查看/var/log目录



.. toctree::
   :maxdepth: 1

   logs/messages







