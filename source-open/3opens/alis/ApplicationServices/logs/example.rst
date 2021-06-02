实例展示
===========


可用实例::

    统计过去1小时发生Error最多的3个位置:
      severity: ERROR | select module ,count(*) as count GROUP BY  module  ORDER BY count DESC LIMIT 30


    统计过去15分钟各种日志级别产生的日志条数:
      * | select severity ,count(*) as count GROUP BY severity ORDER BY count DESC

     对比不同时间段的聚类日志数量:
     *  | select 
                v.signature,  
                v.pattern, 
                coalesce(v.cmp[1],0) as count_now, 
                coalesce(v.cmp[2],0) as count_before, 
                coalesce(v.cmp[1],0) - coalesce(v.cmp[2],0) as count_diff 
          from (
              select 
                  p.signature as signature ,
                  arbitrary(p.pattern) as pattern , 
                  compare(p.count,300) as cmp 
              from 
                  (select log_reduce() as p from log) 
              group by p.signature
          )v  
          order by count_diff desc

Nginx日志分析::

    按小时统计PV/UV统计(pv_uv):
      * | select approx_distinct("__tag__:__client_ip__") as uv ,
         count(1) as pv , 
         date_format(date_trunc('hour', __time__), '%m-%d %H:%i')  as time
         group by date_format(date_trunc('hour', __time__), '%m-%d %H:%i')
         order by time
         limit 1000

    访问地域分析(ip_distribution):
       * | select ip_to_province(client_ip) as address, count(1) as c
         group by ip_to_province(client_ip)  
         order by c desc limit 100

       * | select ip_to_geo("c-ip") as country, count(1) as c group by ip_to_geo("c-ip") limit 100


    访问前十地址(top_page):
       * | select split_part(request_uri,'?',1) as path, count(1) as pv  
         group by split_part(request_uri,'?',1) 
         order by pv desc limit 10

    请求方法占比(http_method_percentage):
       * | select request_method, count(1) as pv
           group by request_method
           order by pv DESC

    请求状态占比(http_status_percentage):    
      * | select status, count(1) as pv
         group by status
         order by pv DESC

    请求UA占比(user_agent):
       * | select count(1) as pv,
         case when http_user_agent like '%Chrome%' then 'Chrome' 
         when http_user_agent like '%Firefox%' then 'Firefox' 
         when http_user_agent like '%Safari%' then 'Safari'
         else 'unKnown' end as http_user_agent
         group by  http_user_agent
         order by pv desc
         limit 10

    前十访问来源(top_10_referer):
       * | select http_referer, count(1) as pv
         group by http_referer
         order by pv desc limit 10

    浏览流入流出统计(net_in_net_out):
      *| select 
          sum("body_bytes_sent") as net_out, 
          sum("request_length") as net_in ,
          date_format(date_trunc('hour', __time__), '%m-%d %H:%i') as time 
      group by date_format(date_trunc('hour', __time__), '%m-%d %H:%i') 
      order by time 
      limit 10000



Nginx访问日志诊断及优化::

    统计平均延时和最大延时:
      * | select from_unixtime(__time__ -__time__% 300) as time, 
          avg(request_time) as avg_latency ,
          max(request_time) as max_latency  
          group by __time__ -__time__% 300

    统计最大延时对应的请求页面:
      * | select from_unixtime(__time__ - __time__% 60) , 
          max_by(request_uri,request_time)  
          group by __time__ - __time__%60

    统计请求延时的分布(分为10个桶进行近似分布直方统计):
      * |select numeric_histogram(10,request_time)

    统计最大的十个延时:
      * | select max(request_time,10)

    对延时最大的页面调优:
      request_uri:"/url2" | select count(1) as pv,
          approx_distinct(remote_addr) as uv,
          histogram(method) as method_pv,
          histogram(status) as status_pv,
          histogram(user_agent) as user_agent_pv,
          avg(request_time) as avg_latency,
          max(request_time) as max_latency


其他实例::

    统计过去1小时;登录次数最多的三个用户:
    login | SELECT regexp_extract(message, 'userID=(?<userID>[a-zA-Z\d]+)', 1) AS userID, count(*) as count GROUP BY userID ORDER BY count DESC LIMIT 3

    统计过去15分钟;每个用户的付款总额:
    order | SELECT regexp_extract(message, 'userID=(?<userID>[a-zA-Z\d]+)', 1) AS userID, sum(cast(regexp_extract(message, 'amount=(?<amount>[a-zA-Z\d]+)', 1) AS double)) AS amount GROUP BY userID

    在整个公司的人员中;获取每个人的薪水在部门内排名
      * | select department, persionId, sallary , 
        rank() over(PARTITION BY department order by sallary desc) as sallary_rank  
        order by department,sallary_rank

    在整个公司的人员中;获取每个人的薪水在部门内的占比
      * | select department, persionId, sallary *1.0 / sum(sallary) over(PARTITION BY department ) as sallary_percentage

    按天统计;获取每天UV相对前一天的增长情况
      * | select day ,uv, uv *1.0 /(lag(uv,1,0) over() ) as diff_percentage from
        (
          select approx_distinct(ip) as uv, date_trunc('day',__time__) as day 
          from log group by day order by day asc
        )


    统计每小时的PV、UV和最高延时对应的用户请求，延时最高的10个延时:
    *|select date_trunc('hour',from_unixtime(__time__)) as time, 
     count(1) as pv, 
     approx_distinct(userid)  as uv,
     max_by(url,latency) as top_latency_url,
     max(latency,10) as top_10_latency
     group by  1
     order by time











