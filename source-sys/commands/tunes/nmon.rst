nmon命令
===============
http://nmon.sourceforge.net/pmwiki.php

常见命令::

  c       可显示CPU的信息
  m       对应内存
  n       对应网络
  d       可以查看磁盘信息
  t       可以查看系统的进程信息


采集数据::

  # nmon -s1 -c60 -f -m /tmp
  // -s1          每隔n秒抽样一次，这里为1秒
  // -c60         取出多少个抽样数量，这里为60，即监控=1*60/60=1分钟
  // -f           按标准格式输出文件名称：<hostname>_YYMMDD_HHMM.nmon
  // -m           指定监控文件的存放目录，-m后跟指定目录

生成图形化报表::

  1.将.nmon文件转化成.csv文件:
  $> sort chen _151014_1659.nmon > chen _151014_1659.csv
  2.打开nmon analyser工具（这是个xlsm文件）
  点击Analyse nmon data按钮，加载文件分析


其他软件::

  nmonmerge: 可以把多个nmon文件合并一起



