.. _tsung_report:

tsung参考文档——报告图表含义说明
================================

可用属性::

    * request:每次请求的请求时间
    * page:一系列请求的请求时间(一个页面是不包含“思考时间“的一系列请求)
    * connect:连接建立的过程
    * reconnect:重新连接的数量
    * size_rcv:反应的大小(单位是byte)
    * size_sent:请求的大小(单位是byte)
    * session:一个用户会话的持续时间
    * users:同步用户的数量
    * connected:同步连接用户的数量
    * custom transaction:

生成报告::

    * 进入测试的log日志目录(“~/.tsung/log/yyyyMMdd-hhmm/”)
    * 执行: ``tsung_stats.pl`` (完整命令 ``/usr/lib/tsung/bin/tsung_stats.pl`` )

tsung摘要::

    Available options::
    [--help] (this help text)
    [--verbose]
    [--debug]
    [--noplot] (don’t make graphics)
    [--gnuplot <command>] (path to the gnuplot binary)
    [--nohtml] (don’t create HTML reports)
    [--logy] (logarithmic scale for Y axis)
    [--tdir <template_dir>] (Path to the HTML tsung templates)
    [--noextra (don’t generate graphics from extra data (os monitor, etc)
    [--stats <file>] (stats file to analyse, default=tsung.log)

