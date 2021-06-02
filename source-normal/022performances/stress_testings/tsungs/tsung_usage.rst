.. _tsung_usage:

简单用法
==========
安装::

  ./configure
  make
  make install


执行步骤::

  1. 配置录制或者编写
     tsung-recorder
  2. 执行压测
     tsung <options> start|stop|debug|status
  3. 统计报告
     tsung_stats.pl


tsung-recorder——录制::

    //用法
    tsung-recorder [-l log file][-r command][-p plugin][-L listenport]
             [-I IP][-P port][-u][start|stop|restart|record_tag ]

    //说明:
    PLUGIN可以是http, webdav或 pgsql，默认是http
    -L <portNumber>:代理监听的商品号，默认是8090
    tsung-recorder stop:用于停止录制
    会创建文件~/.tsung/tsung_recorderYYYMMDD-HH:MM.xml
    出现错误可以去 ~/.tsung/log/tsung.log-tsung_recorder@hostname察看出错原因
    在录制的过程中，你也可以在xml文件中增加自定义标签，这在设定事务或评论时十分有用，
    例如:tsung-recorder record_tag “<transaction name=’login’>”

tsung——执行压测::

    用法: tsung <options> start|stop|debug|status
    Options:
      * -f <file>: 设定配置文件(默认是 ~/.tsung/tsung.xml)
      * -l <logfile>: 设定日志文件 (默认是 ~/.tsung/log/tsung.log)
      * -i <id>: 设定控制id (默认是空)
      * -r <command>: 定远程连接器 (默认是 ssh)
      * -F: 在erlang结点用一个长名字
      * -v: 本信息然后退出
      * -h: 助信息然后退出

tsung_stats.pl——统计报告::

    * 进入步骤2生成的日期为名的文件夹中
    * 执行:
      >>/usr/lib/tsung/bin/tsung_stats.pl
    * 打开report.html文件，可以看相应的统计数据






