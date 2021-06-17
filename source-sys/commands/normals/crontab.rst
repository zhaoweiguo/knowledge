.. _crontab:

crontab命令简析
================


**简介**

    crontab命令常见于Unix和类Unix的操作系统之中，用于设置周期性被执行的指令。
    通常，crontab储存的指令被守护进程激活， crond常常在后台运行，每一分钟检查是否有预定的作业需要执行。这类作业一般称为cron jobs。
    crontab文件包含送交cron守护进程的一系列作业和指令。每个用户可以拥有自己的crontab文件；同时，操作系统保存一个针对整个系统的crontab文件，该文件通常存放于/etc或者/etc之下的子目录中，而这个文件只能由系统管理员来修改。

**使用说明**

    * 使用权限:root用户和crontab文件的所有者
    * 语法::

        crontab [-e [UserName]|-l [UserName]|-r [UserName]|-v [UserName]|File]

    * 说明:
        crontab 是用来让使用者在固定时间或固定间隔执行程序之用。 ``-u user`` 是指设定指定 user 的时程表，这个前提是你必须要有其权限(比如说是 root)才能够指定他人的时程表。如果不使用 ``-u user`` 的话，就是表示设定自己的时程表。
    * 参数说明:
        * ``-e [UserName]`` : 执行文字编辑器来设定时程表，内定的文字编辑器是 VI，如果你想用别的文字编辑器，则请先设定 VISUAL 环境变数来指定使用那个文字编辑器(比如说 setenv VISUAL joe)
        * ``-r [UserName]`` : 删除目前的时程表
        * ``-l [UserName]`` : 列出目前的时程表
        * ``-v [UserName]`` :列出用户cron作业的状态

    * 时程表的格式如下::

        f1 f2 f3 f4 f5 program

    * 如图:

      .. figure:: /images/linuxs/linux_command_crontab1_file_format.jpg
         :width: 50%

    * 具体说明:

      * f1 是表示分钟，f2 表示小时，f3 表示一个月份中的第几日，f4 表示月份，f5 表示一个星期中的第几天。program 表示要执行的程式
      * 当 f1 为 ``*`` 时表示每分钟都要执行 program，f2 为 ``*`` 时表示每小时都要执行程式，其余类推
      * 当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其余类推
      * 当 f1 为 ``*`` /n 时表示每 n 分钟个时间间隔执行一次，f2 为 ``*`` /n 表示每 n 小时个时间间隔执行一次，其余类推
      * 当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其余类推


**使用方法**

    步骤:
        * 编辑一文件(cronfile),按上面的格式编辑完成并退出
        * 命令行输入 ``crontab cronfile``
        * 这时就把cronfile文件中的任务提交给cron进程，同时在目录 ``/var/spool/cron/`` 目录，文件名是用户名。
    实例:
        * 每月每天每小时的第 0 分钟执行一次 时间同步::

            0 * * * * ntpdate asia.pool.ntp.org

        * 在12月内, 每天的早上6点到12点中，每隔20分钟执行一次 ``/usr/bin/backup``::

            */20 6-11 * 12 * /usr/bin/backup

        * 周一到周五每天下午 5:00 寄一封信给 alex_mail_name::

            0 17 * * 1-5 mail -s "hi" alex_mail_name < /tmp/maildata

        * 每月每天的午夜 0 点 20 分, 2 点 20 分, 4 点 20 分....执行 echo "haha"::

            20 0-23/2 * * * echo "haha"

        * 晚上11点到早上8点之间每两个小时，早上8点::

            0 23-7/2，8 * * * date


**注意**

    * 当程式在你所指定的时间执行后，系统会寄一封信给你，显示该程式执行的内容，若是你不希望收到这样的信，请在每一行空一格之后加上 > /dev/null 2>&1 即可。
    * %在crontab中被认为是newline，要用\来escape才行。比如crontab执行行中，如果有"date +%Y%m%d"，必须替换为："date +\%Y\%m\%d"

**如何创建crontab**

    * 设置环境变量EDITOR::

         select-editor


    * 列出crontab文件::

         $crontab -l

    * 编辑crontab文件::

        $ crontab -e

    * 删除crontab文件::

        $ crontab -r

    * 恢复丢失的crontab文件::

        $ crontab <filename>


