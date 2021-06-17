watch命令
###############

实例1：每隔一秒高亮显示网络链接数的变化情况::

  watch -n 1 -d netstat  -ant 

实例2：每隔一秒高亮显示命令链接数的变化情况::

  watch -n 1 -d ' pstree | grep http '
  每隔一秒高亮显示http 链接数的变化情况，后面接的命令若带有管道符，需要加“将命令区域归整”。

实例3：实时查看模拟攻击客户机建立起来的链接数::

  watch 'netstat -an | grep:21 | grep <模拟攻击客户机的IP> | wc -l'

实例4：检测当前目录中含 log 的文件的变化::

  watch -d  ' ls -l | grep log '

实例5:10秒一次输出系统的平均负载::

  watch -n  10 ' cat /proc/loadavg'

 






