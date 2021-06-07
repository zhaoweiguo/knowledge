.. -*- coding: utf-8 -*-
.. _python_date:

python日期
########################

::

    import time
    >>> s="2006-1-2"
    >>> time.strptime(s,"%Y-%m-%d)

    d1 = datetime.datetime(2005, 2, 16)
    d2 = datetime.datetime(2004, 12, 31)
    print (d1 - d2).days

    starttime = datetime.datetime.now()

    date = time.strptime(date,"%Y-%m-%d")
    print type(date)
    print date[0]


Python关于时间日期有两个库datetime和time，于是我们要在四种格式之间转换::

    datetime.datetime对象 datetime.datetime.now()
    time.struct_time对象  time.localtime()
    字符串 "2010-12-04T10:30:53"
    时间戳 1291433453 


datetime与time之间的相互转换::

    >>> import time, datetime
    >>> t = time.time()
    >>> d_from_t = datetime.datetime.fromtimestamp(t)
    >>> d_from_t
    datetime.datetime(2008, 10, 31, 12, 50, 29, 578000)
    >>> tt = time.mktime(d_from_t.timetuple())
    >>> tt
    1225428629.0
    >>> t
    1225428629.5780001

日期格式串说明::

    %a 本地简化星期名称
    %A 本地完整星期名称
    %b 本地简化的月份名称
    %B 本地完整的月份名称
    %c 本地相应的日期表示和时间表示
    %d 月内中的一天（0-31）
    %H 24小时制小时数（0-23）
    %I 12小时制小时数（01-12）
    %j 年内的一天（001-366）
    %m 月份（01-12）
    %M 分钟数（00=59）
    %p 本地A.M.或P.M.的等价符
    %S 秒（00-59）
    %U 一年中的星期数（00-53）星期天为星期的开始
    %w 星期（0-6），星期天为星期的开始
    %W 一年中的星期数（00-53）星期一为星期的开始
    %x 本地相应的日期表示
    %X 本地相应的时间表示
    %y 两位数的年份表示（00-99）
    %Y 四位数的年份表示（000-9999）
    %Z 当前时区的名称
    %% %号本身

使用timedelta进行加减::

    d1 = datetime.datetime.now()
    d3 = d1 + datetime.timedelta(days =10)

    print str(d3)
    print d3.ctime()

    上例演示了计算当前时间向后10天的时间。
    如果是小时 days 换成 hours



time , datetime , string 类型互相转换::

    1. string -> time
    time.strptime(publishDate,"%Y-%m-%d %H:%M:%S")

    2. string -> datetime
    datetime.datetime.strptime(publishDate,"%Y-%m-%d %H:%M:%S")

    3. time -> string
    time.strftime("%y-%m-%d",time.localtime())

    date = '2007-01-01'
    t = time.strptime(date,"%Y-%m-%d") #struct_time类型
    d = datetime.datetime(date[0], date[1],date[2]) #datetime类型


将日期时间对象转成字符串::

    date = time.strftime("%y-%m-%d",d)
    d.strftime('%Y%m%d')


