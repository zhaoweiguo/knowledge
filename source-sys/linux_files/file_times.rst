时区
####

::

  找到相应的时区文件 /usr/share/zoneinfo/Asia/Shanghai 
  替换当前的/etc/localtime
  修改/etc/sysconfig/clock文件的内容为:
        ZONE="Asia/Shanghai" 
        UTC=false 
        ARC=false 

  //时区设置:
  /etc/timezone
  /etc/localtime

  //配置时区的命令是
  $sudo dpkg-reconfigure tzdata
   
   第一个文件写的是系统的时区, 我的是: Asia/Shanghai
   第二个文件还可以这样改:
   ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

   是否用UTC时间可以改这个文件: /etc/default/rcS
   UTC=no 或者 UTC=yes

日期::

  时间设定成2008年9月10日的命令如下:
  date -s 09/10/2008

  将系统时间设定成上午10点25分0秒的命令如下:
  date -s 10:25:00 

  同步biso时间:
  同步BIOS时钟，强制把系统时间写入CMOS，命令如下:
    clock -w

