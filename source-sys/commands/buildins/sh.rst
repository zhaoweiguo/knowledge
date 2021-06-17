sh命令
######


::

   sh -c "ls /"   # 执行字符串的命令



Bourne shell启动脚本相关
========================

相关文件::

    ~/.profile
    ~/.history
    ~/.logout
    ~/.login


可继承的环境变量
----------------

* Bourne shell登陆时使用 ~/.profile 来设置环境变量::

    ~/.profile

别名和函数
----------

* 在Bash当中，~/.bashrc 是交互式子shell启动时执行的脚本
* 在登录式shell中使用 ~/.bashrc 定义的函数::

    // 可以在 ~/.bash_login 的环境变量后面加上这样一行
    . ~/.bashrc

登录与退出时执行的命令
----------------------

最初登录时，csh 执行::

    ~/.login
    // 可以执行一些只在登录时执行的操作，例如显示系统负载、硬盘状态、是否收到新邮件、在日志中记录登录时间，等等

Bourne shell 可以在 ~/.bash_profile 文件中手工模拟这种行为::

    可以在 ~/.bash_profile 文件的环境变量设置和函数定义的后面添加这样一行

