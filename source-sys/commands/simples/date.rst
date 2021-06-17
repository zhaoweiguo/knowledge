.. _date:

date命令
=========

**简介**

    print or set the system date and time

**概述**

    date [OPTION]... [+FORMAT]
    date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]


**描述**





实例::

    一、察看日期

    date "+%y%m%d": 120503
    date "+%W": 一年的第几周
    date "+%w": 一周的第几天

    date "+%y": 哪年(两位)
    date "+%Y": 哪年(四位)
    date "+%m": 第几月
    date "+%d": 一月的第几天
    date "+%H": 第几小时
    date "+%M": 第几分钟
    date "+%S": 第几秒

    二、设置日期::

    date -s 06/22/12    //设置日期为2012年6月22日
    date -s 13:53:00    //设置时间为13:53:00
    hwclock -w          //将当前时间写入BIOS为避免重启失效



时区::

    一、察看当前时区::

    date -R

    二、修改时区:

    1. 方法一:
        tzselect

    2. 方法二(仅限RedHat Centos):
        timeconfig

    3. 方法三(Debian):
        dpkg-reconfigure tzdata

    三、复制相应时区文件，替换系统时区文件；或创建链接文件::

    cp /usr/share/zoneinfo/$主时区/$次时区   /etc/localtime

    例(中国可使用):
    cp /usr/share/zoneinfo/Asia/Shanghai   /etc/localtime



定时同步::

    启动同步服务器:
    /etc/init.d/ntpd start
    or
    /usr/local/ntp/bin/ntpd -c /etc/ntp.conf -p /tmp/ntpd.pid

    配置文件:
    vi /etc/ntp.conf

    crontab内容:
    * * * * * /usr/sbin/ntpdate 210.72.145.44 > /dev/null 2>&1 &
    or
    * * * * * /usr/sbin/ntpdate asia.pool.ntp.org > /dev/null 2>&1 &







