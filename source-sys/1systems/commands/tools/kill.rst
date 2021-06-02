.. _kill:

kill命令使用
====================
用法::

    kill [信号代码] <进程 PID>

根据 PID 向进程发送信号,常用来结束进程,默认信号为 -9::

     -l [信号数字] 显示、翻译信号代码
     -9 , -KILL 发送 kill 信号退出
     -6 , -ABRT 发送 abort 信号退出
     -15 , -TERM 发送 Termination 信号
     -1 , -HUP 挂起
     -2 , -INT 从键盘中断,相当于 Ctrl+c
     -3 , -QUIT 从键盘退出,相当于 Ctrl+d
     -4 , -ILL 非法指令
     -11 , -SEGV 内存错误
     -13 , -PIPE 破坏管道
     -14 , -ALRM
     -STOP 停止进程,但不结束
     -CONT 继续运行已停止的进程
     -9 -1 结束当前用户的所有进程

