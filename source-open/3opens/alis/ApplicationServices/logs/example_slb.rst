slb实例
############

地理位置相关::

    % 省
    * | select 
        ip_to_province(client_ip) as ip_province, count(*) as pv 
      group by ip_province 
      order by pv desc 
      limit 500

    % 国
    * | select 
        ip_to_country(client_ip) as ip_country, count(*) as pv 
      group by ip_country 
      order by pv desc 
      limit 500

top ip::

    * | select 
        client_ip as "客户端ip" , 
        count(*) as pv, 
        ip_to_province(client_ip) as "区域", 
        ip_to_city(client_ip) as "城市", 
        ip_to_provider(client_ip) as "运营商", 
        round(sum(request_length) / 1024.0 / 1024, 2) as "请求报文流量(MB)", 
        round(sum(body_bytes_sent) / 1024.0 / 1024, 2) as "返回客户端流量(MB)" 
      group by client_ip 
      order by pv desc 
      limit 100

按分钟查看状态码PV趋势::

    * | select 
        date_format(date_trunc('minute', __time__),'%m-%d %H:%i') as t, 
        status, 
        count(*) as pv 
      group by t, status 
      order by t asc 
      limit 2000

各slb下各host请求汇总::

    * | select 
        slbid as "SLB实例ID", 
        host, 
        count(*) as pv, 
        round(sum(request_length) / 1024.0 / 1024, 2) as "请求报文流量(MB)", 
        round(sum(body_bytes_sent) / 1024.0 / 1024, 2) as "返回客户端流量(MB)", 
        round(
            sum(
                case when status>=200 and status < 300 then 1 else 0 end 
              ) * 100.0 / count(1), 6
          ) as "2xx比例(%)", 
        round(
            sum(
                case when status>=300 and status < 400 then 1 else 0 end 
              ) * 100.0 / count(1), 6
          ) as "3xx比例(%)", 
        round(
            sum(
                case when status >= 400 and status < 500 then 1 else 0 end 
              ) * 100.0 / count(1), 6
          ) as "4xx比例(%)", 
        round(
            sum(
                case when status >= 500 and status < 600 then 1 else 0 end 
              ) * 100.0 / count(1), 6
          ) as "5xx比例(%)" 
      group by "SLB实例ID", host 
      order by pv desc 
      limit 100

请求报文流量拓扑::

    * | select 
        COALESCE(client_ip, vip_addr, upstream_addr) as source, 
        COALESCE(upstream_addr, vip_addr, client_ip) as dest, 
        sum(request_length) as inflow 
      group by grouping sets( (client_ip, vip_addr), (vip_addr, upstream_addr))

















