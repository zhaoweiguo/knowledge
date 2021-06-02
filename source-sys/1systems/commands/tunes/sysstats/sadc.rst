sadc命令
##############

用法::

  /usr/lib64/sa/sadc [ options... ] [ <interval> [ <count> ] ] [ <outfile> ]
  Options are:
  [ -d ] [ -F ] [ -I ] [ -V ]

  -d 报告硬盘设置的相关统计；
  -F 强制把数据写入文件；
  -I 报告所有系统中断数据；
  interval 表示时间间隔，单位是秒，比如3
  count 统计数据的次数，也是一个数字
  outfile 输出统计到outfile文件

说明::

  参数都是可选的,如果没有指定任何参数,如:
  /usr/lib/sa/sadc - 
  则会输出数据到 /var/log/sa/，通过sadf 或sar工具来查看
  sar -f /var/log/sa/sa11
  或
  sadf /var/log/sa/sa11

实例::

  /usr/lib/sa/sadc  1 10 sa000
  sar -f sa000