优秀分析案例
###############


5分钟错误率超过40%时触发报警::

    status:500 | select 
        __topic__, 
        max_by(error_count, window_time)/1.0/sum(error_count) as error_ratio, 
        sum(error_count) as total_error  
    from (
        select __topic__, count(*) as error_count , 
            __time__ - __time__ % 300  as window_time  
        from log 
        group by __topic__, window_time
    ) 
    group by __topic__  
    having  max_by(error_count, window_time)/1.0/sum(error_count)   > 0.4  
        and sum(error_count) > 500 
    order by total_error desc limit 100

当流量暴跌时，触发报警::

    统计每分钟的流量，当最近的流量出现暴跌时，触发报警。 
    由于在最近的一分钟内，统计的数据不是一个完整分钟的，所以，
        需要除以(max( time) - min( time)) 进行归一化，统计每个分钟内的流量均值。
    * | 
    SELECT 
        SUM(inflow) / (max(__time__) - min(__time__))  as inflow_per_minute, 
        date_trunc('minute',__time__)  as minute 
    group by minute

按照数据区间分桶，在每个桶内计算平均延时::

    * | 
    select 
        avg(latency) as latency , 
        case 
            when originSize < 5000 then 's1' 
            when originSize < 20000 then 's2' 
            when originSize < 500000 then 's3' 
            when originSize < 100000000 then 's4' 
            else 's5' 
        end as os 
    group by os

在group by的结果中，返回百分比::

    不同部门的count结果，及其所占百分比。该
    query结合了子查询、窗口函数。
    其中sum(c) over() 表示计算所有行的和。
    * |  
    select   
        department, c*1.0/sum(c) over ()  
    from(
        select count(1) as c, department   
        from log 
        groupby department
    )

统计满足条件的个数::

    在URL路径中，我们需要根据URL不同的特征，来计数，这种情况，可以使用CASE WHEN语法，
    但还有个更简单的语法是count_if。
    * | 
    select  
        count_if(uri like '%login') as login_num, 
        count_if(uri like '%register') as register_num, 
        date_format(date_trunc('minute', __time__), '%m-%d %H:%i') as time  
    group by time 
    order by time limit 100
















