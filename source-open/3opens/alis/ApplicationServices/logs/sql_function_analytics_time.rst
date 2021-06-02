时间相关
============
日期时间类型::

    unixtime: 以int类型表示从1970年1月1日开始的秒数，例如1512374067 
      表示的时间是Mon Dec 4 15:54:27 CST 2017。
      日志服务每条日志中内置的时间__time__即这种类型。
    timestamp类型: 以字符串形式表示时间，例如2017-11-01 13:30:00。


日期函数
----------
::

    current_date    当天日期。   *| select current_date
    current_time    当前时间
    current_timestamp   结合current_date 和current_time的结果
    current_timezone()  返回时区
    from_unixtime(unixtime) 把unix时间转化为时间戳
    from_unixtime(unixtime,string)  以string为时区，把unixtime转化成时间戳。 如:
                *| select from_unixtime(1494985275,'Asia/Shanghai')
    localtime   本地时间
    localtimestamp  本地时间戳
    now()   等同于current_timestamp。   -
    to_unixtime(timestamp)  timestamp转化成unixtime。   如:
            *| select to_unixtime('2017-05-17 09:45:00.848 Asia/Shanghai')

    // @todo
    from_iso8601_timestamp(string)  把iso8601时间转化成带时区的时间。如:
        * | select from_iso8601_date("2019-05-03T17:30:08+08:00")
    from_iso8601_date(string)   把iso8601转化成天

时间函数
-----------
::

    date_format(timestamp, format)  把timestamp转化成以format形式表示。
    date_parse(string, format)  把string以format格式解析，转化成timestamp。 

    如:
        * | select date_format (
            date_parse('2017-05-17 09:45:00','%Y-%m-%d %H:%i:%S'), 
            '%Y-%m-%d')
       * |select date_format (
            date_parse(time,'%Y-%m-%d %H:%i:%S'), 
          '%Y-%m-%d')


.. csv-table:: Logtail支持的常见日志时间格式
    :header: 支持格式,  说明,  示例

    %a,  星期的缩写                         ,Fri
    %A,  星期的全称                         ,Friday
    %b,  月份的缩写                         ,Jan
    %B,  月份的全称                         ,January
    %d,  每月第几天;十进制格式;范围为01~31     ,07;31
    %e,  每月第几天;十进制格式;范围为1~31个位数字加空格, 7;31
    %h,  月份的缩写;与%b相同                 , Jan
    %H,  小时;24小时制                     ,22
    %I,  小时;12小时制                     ,11
    %m,  月份;十进制格式                    ,08
    %M,  分钟;十时制格式;范围为00~59        ,59
    %n,  换行符                           , 换行符
    %p,  本地的AM（上午）或PM（下午）        , AM/PM
    %r,  12小时制的时间组合;与%I:%M:%S %p相同  ,11:59:59 AM
    %R,  小时和分钟组合;与%H:%M相同           ,23:59
    %S,  秒数;十进制;范围为00~59             ,59
    %t,  TAB符                              ,TAB符
    %y,  年份;十进制;不带世纪;范围为00~99    ,04;98
    %Y,  年份;十进制                        ,2004;1998
    %C,  十进制世纪;范围为00~99              ,16
    %j,  一年天数的十进制表示;范围为00~366         , 365
    %u,  星期的十进制表示;范围为1~7;1 表示周一     , 2
    %U,  每年的第几周;星期天是一周的开始范围为00~53,  23
    %V,  每年的第几周;星期一是一周的开始;范围为01~53 , 24
    %w,  星期几;十进制格式 ;范围为0~6;0代表周日    ,  5
    %W,  每年的第几周;星期一是一周的开始范围为00~53,  23
    %c,  标准的日期、时间,
    %x,  标准的日期,
    %X,  标准的时间,
    %s,  Unix时间戳,  1476187251


时间段对齐函数
----------------
::

    date_trunc(unit, x)
    x 可以是一个timestamp类型，也可以是unix time。

    Unit        转化后结果
    ======      ===============
    second      2001-08-22 03:04:05.000
    minute      2001-08-22 03:04:00.000
    hour        2001-08-22 03:00:00.000
    day         2001-08-22 00:00:00.000
    week        2001-08-20 00:00:00.000
    month       2001-08-01 00:00:00.000
    quarter     2001-07-01 00:00:00.000
    year        2001-01-01 00:00:00.000

date_trunc只能在按照一些固定时间间隔统计，如果需要按照灵活的时间维度进行统计（例如统计每5分钟数据），需要按照数学取模方法进行GROUP BY::

    % 上述公式中的%300表示按照5分钟进行取模对齐
    * | SELECT 
        count(1) as pv,  __time__ - __time__% 300 as minute5 
      group by minute5 limit 100

以下为使用时间格式的一个综合样例::

    *|select  date_trunc('minute' ,  __time__)  as t,
       truncate (avg(latency) ) ,
       current_date  
       group by   t
       order by t  desc 
       limit 60

时间间隔函数
-----------------

时间间隔函数用来执行时间段相关的运算，如在日期中添加或减去指定的时间间隔、计算两个日期之间的时间::

    date_add(unit, value, timestamp)  
      在timestamp上加上value个unit。如果要执行减法，value使用负值。 如:
        date_add('day', -7, '2018-08-09 00:00:00') 表示8月9号之前7天
    date_diff(unit, timestamp1, timestamp2) 
      表示timestamp1和timestamp2之间相差几个unit。
        date_diff('day', '2018-08-02 00:00:00', '2018-08-09 00:00:00') = 7

该函数支持以下区间单位::

    单位          说明
    =====       =========
    millisecond   毫秒
    second        秒
    minute        分钟
    hour          小时
    day           天
    week          周
    month         月
    quarter       季度，即三个月
    year          年

时序补全函数
---------------

时序补全函数time_series用于处理某些时间缺少的情况::

    % 函数格式:
    time_series(time_column, window, format, padding_data)
    % 参数说明:
    参数            说明
    ======        ========
    time_column   时间列，例如日志服务提供的默认时间字段__time__
                    格式为long类型或timestamp类型。
    window        窗口大小，由一个数字和单位组成。单位:
                    s（秒）、m（分）、H （小时）、或d（天）。例如2h、5m、3d。
    format        MySQL时间格式，表示最终输出的格式。
    padding_data  表示补全的内容，包括:
                    0：补零。
                    null：补null。
                    last：补上一个值。
                    next：补下一个值。
                    avg：补前后的平均值。

按照每两个小时进行格式化::

    * | select 
        time_series(__time__, '2h', '%Y-%m-%d %H:%i:%s', '0')  as stamp, 
        count(*) as num 
      from log 
      group by stamp 
      order by stamp





.. csv-table:: Logtail支持的常见日志时间格式
    :header: 日志时间格式,  示例,  时间表达式

    自定义,        2017-12-11 15:05:07,                  %Y-%m-%d %H:%M:%S
    自定义,        [2017-12-11 15:05:07.012],            [%Y-%m-%d %H:%M:%S]
    RFC822,       01 Jan 06 15:04 MST, %d %b            %y %H:%M
    RFC822Z,      02 Jan 06 15:04 -0700, %d %b          %y %H:%M
    RFC850,       Monday, 02-Jan-06 15:04:05 MST,       %A, %d-%b-%y %H:%M:%S
    RFC1123,      Mon, 02 Jan 2006 15:04:05 MST,        %A, %d-%b-%y %H:%M:%S
    RFC3339,      2006-01-02T15:04:05Z07:00,            %Y-%m-%dT%H:%M:%S
    RFC3339Nano,  2006-01-02T15:04:05.999999999Z07:00,  %Y-%m-%dT%H:%M:%S









