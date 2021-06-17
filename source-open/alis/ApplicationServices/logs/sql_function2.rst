较复杂函数
================


基础查询::

    子串命中
    * | select content where content like '%substring%' limit 100

    正则表达式匹配
    * | select content where regexp_like(content, '\d+m'）limit 100

    JSON内容解析与匹配
    * | select content where json_extract(content, '$.store.book')='mybook' limit 100
    如果设置json类型索引也可以使用：
    field.store.book='mybook'

1.同比和环比函数::

    * | select compare( pv , 86400) from (select count(1) as pv from log)


    *|select t, diff[1] as current, diff[2] as yestoday, diff[3] as percentage from(select t, compare( pv , 86400) as diff from (select count(1) as pv, date_format(from_unixtime(__time__), '%H:%i') as t from log group by t) group by t order by t) s

2.外部数据源联合查询::

    sql
    创建外表：
    * | create table user_meta ( userid bigint, nick varchar, gender varchar, province varchar, gender varchar,age bigint) with ( endpoint='oss-cn-hangzhou.aliyuncs.com',accessid='LTA288',accesskey ='EjsowA',bucket='testossconnector',objects=ARRAY['user.csv'],type='oss')

    使用外表
    * | select u.gender, count(1) from chiji_accesslog l join user_meta1 u on l.userid = u.userid group by u.gender

3.地理位置函数::

    * | SELECT count(1) as pv, ip_to_province(ip) as province WHERE ip_to_domain(ip) != 'intranet' GROUP BY province ORDER BY pv desc limit 10

    * | SELECT mobile_city(try_cast("mobile" as bigint)) as "城市", mobile_province(try_cast("mobile" as bigint)) as "省份", count(1) as "请求次数" group by "省份", "城市" order by "请求次数" desc limit 100


4. 安全分析函数








