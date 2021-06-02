SQL分析语法与功能 [1]_
##########################

通用聚合函数 ::

    arbitrary(x)    随机返回x列中的一个值
    avg(x)          计算x列的算数平均值
    checksum(x)     计算某一列的checksum，返回base64编码
    count(*)        表示所有的行数
    count(x)        计算某一列非null的个数
    count(数字)      count(数字)，如count(1)，等同于count(*)，表示所有的行数
    count_if(x)     计算x=true的个数,如:latency > 100 | count_if(url like ‘%abc’) 
    geometric_mean(x)   计算某一列的几何平均数
    max_by(x,y)     返回当y取最大值时，x当前的值。如:
        查询延时最高的时候，对应的method：latency>100 | select max_by(method,latency)
    max_by(x,y,n)   返回y最高的n行，对应的x的值。
    min_by(x,y)     返回当y取最小值时，x当前的值。
    min_by(x,y,n)   返回y最小的n行，对应的x的值。
    max(x)          返回最大值。
    min(x)          返回最小值。 
    sum(x)          返回x列的和。
    bitwise_and_agg(x)  对某一列的所有数值做and计算。 
    bitwise_or_agg(x)   对某一列的数值做or计算。

安全检测函数::

    security_check_ip   检查IP是否安全，其中：
                返回1：命中，表示不安全
                返回0：未命中
    security_check_domain   检查Domain是否安全，其中：
                返回1：命中，表示不安全
                返回0：未命中
    security_check_url  检查URL是否安全，其中：
                返回1：命中，表示不安全
                返回0：未命中

    实例:
    1.检查外部可疑访问行为并生成报表:
    * | select 
            ClientIP, 
            ip_to_country(ClientIP) as country, 
            ip_to_provider(ClientIP) as provider, 
            count(1) as PV 
        where security_check_ip(ClientIP) = 1 
        group by ClientIP 
        order by PV desc
    2.检查内部可疑访问行为
    * | select 
            client_ip, 
            count(1) as PV 
        where 
            security_check_ip(remote_addr) = 1 
            or security_check_site(site) = 1 
            or security_check_url(concat(site, url)) = 1 
        group by client_ip 
        order by PV desc

Map映射函数::

    https://help.aliyun.com/document_detail/63446.html

字符串函数::

    chr(x)          把int类型转化成对应的ASCII码，例如chr(65)结果为’A’。
    codepoint (x)   把一个ASCII码转化成int类型的编码，例如codepoint('A') 结果为65。
    length(x)       字段长度。
    levenshtein_distance(string1, string2)  
                    返回两个字符串的最小编辑距离。
    lower(string)   转化成小写。
    upper(string) 转化为大写字符。
    lpad(string, size, padstring) 
                    把string对齐到size大小，
                        如果小于size，用padstring，从左侧补齐到size；
                        如果大于size，则截取到size个。
    rpad(string, size, padstring) 
                    类似lpad,从右侧补齐string
    ltrim(string)   删掉左侧的空白字符。
    rtrim(string)   删掉字符串结尾的空白字符。
    trim(string)  删掉字符串开头和结尾的空白字符。
    replace(string, search)       把字符串中string中的search删掉。
    replace(string, search,rep)   把字符串中string中的search替换为rep。
    reverse(string)   翻转string。
    split(string,delimeter,limit) 
                    把字符串分裂成array，最多取limit个值。生成的结果为数组，下标从1开始
    split_part(string,delimeter,offset) 
                    把字符串分裂成array，取第offset个字符串
    split_to_map(string, entryDelimiter, keyValueDelimiter) → map<varchar, varchar> 
              把string按照entryDelemiter分割成多个entry，
              每个entry再按照keyValueDelimiter划分成key value。最终返回一个map。
    position(substring IN string)   获取string中，substring最先开始的位置。
    strpos(string, substring)       查找字符串中的子串的开始位置。
                          返回结果从1开始，如果不存在则返回0
    substr(string, start)       返回字符串的子串，start下标从1开始
    substr(string, start, length) 
    concat(string,string......) 把两个或多个字符串拼接成一个字符串。
    hamming_distance (string1,string2)  获得两个字符串的海明距离。
    


窗口函数::

    窗口函数用来跨行计算普通的SQL聚合函数只能用来计算一行内的结果;或者把所有行聚合成一行结果
    窗口函数;可以跨行计算;并且把结果填到到每一行中

    语法:
    SELECT key1, key2, value,
           rank() OVER (PARTITION BY key2
                        ORDER BY value DESC) AS rnk
    FROM orders
    ORDER BY key1,rnk

    % rank()是一个聚合函数,可以使用分析语法中的任何函数,也可以使用本文档列出的函数
    % PARTITION BY 是值按照哪些桶进行计算

    特殊聚合函数:
    函数                          含义
    rank()              在窗口内;按照某一列排序;返回在窗口内的序号
    row_number()        返回在窗口内的行号
    first_value(x)      返回窗口内的第一个value;一般用法是窗口内数值排序;获取最大值
    last_value(x)       含义和first value相反
    nth_value(x, offset)  窗口内的第offset个数
    lead(x,offset,defaut_value) 窗口内x列某行之后offset行的值;如果不存在该行;则取default_value
    lag(x,offset,defaut_value)  窗口内x列某行之前offset行的值;如果不存在该行;则取default_value

URL函数::

    一个标准的URL如下：
    [protocol:][//host[:port]][path][?query][#fragment]

    % 常见URL函数
    url_extract_fragment(url)   提取出URL中的fragment
    url_extract_host(url)       提取出URL中的host
    url_extract_parameter(url, name)  提取出URL中的query中name对应的参数值
    url_extract_path(url)       提取出URL中的path
    url_extract_port(url)       提取出URL中的端口，结果为bigint类型
    url_extract_protocol(url)   提取出URL中的协议
    url_extract_query(url)      提取出URL中的query，结果为varchar类型。
    url_encode(value)           对url进行转义编码
    url_decode(value)           对url进行解码

正则函数::

    regexp_extract_all(string, pattern)   返回字符串中命中正则式的所有子串，返回结果是字符串数组
    regexp_extract_all(string, pattern, group)  返回命中正则的第group个()内部分,返回字符串数组
    regexp_extract(string, pattern)       返回字符串命中的正则式的第一个子串。
    regexp_extract(string, pattern,group) 返回字符串命中的正则式的第group个()内的第1个子串
    regexp_like(string, pattern)        判断字符串是否命中正则式，返回bool类型
    regexp_replace(string, pattern, replacement)  把字符串中命中正则式的部分替换成replacement
    regexp_replace(string, pattern)     相当于regexp_replace(string,patterm,'')
    regexp_split(string, pattern)       使用正则式把字符串切分成数组

    实例:
    *| SELECT regexp_extract_all('5a 67b 890m', '\d+')，
        结果为['5','67','890']，
    *|SELECT regexp_extract_all('5a 67a 890m', '(\d+)a') 
        结果为['5a','67a']。
    *| SELECT regexp_extract_all(‘5a 67a 890m’, ‘(\d+)a’, 1) 
        结果为[‘5’,’67’]
    *|SELECT regexp_extract('5a 67b 890m', '\d+') 
        结果为'5'
    *|SELECT regexp_extract('5a 67b 890m', '(\d+)([a-z]+)',2) 
        结果为'a'
    *|SELECT regexp_like('5a 67b 890m', '\d+m') 
        结果为true
    *|SELECT regexp_replace('5a 67b 890m', '\d+','a') 
        结果为'aa ab am'
    *|SELECT regexp_replace('5a 67b 890m', '\d+') 
        结果为'a b m'
    *|SELECT regexp_split('5a 67b 890m', '\d+') 
        结果为['a','b','m']

JSON函数::

    JSON主要有两种结构：map和array。如果一个字符串解析成JSON失败，那么返回的是null
    json_parse(string)    把字符串转化成JSON类型。
    json_format(json)     把JSON类型转化成字符串。
    json_array_contains(json, value)    判断JSON类型数值(或内容是JSON数组字符串)是否包含某值
    json_array_get(json_array, index)   是获取一个JSON数组的某个下标对应的元素
    json_array_length(json)         返回JSON数组的大小。  
    json_extract(json, json_path)   从一个JSON对象中提取值，返回结果是一个JSON对象。 
                          JSON路径的语法类似$.store.book[0].title
    json_extract_scalar(json, json_path)  类似json_extract，但是返回结果是字符串类型
    json_size(json,json_path)     获取JSON对象或数组的大小

    % 实例:
    SELECT json_parse('[1, 2, 3]') 结果为JSON类型数组
    SELECT json_format(json_parse('[1, 2, 3]')) 结果为字符串
    SELECT json_array_contains(json_parse('[1, 2, 3]'), 2)
        或 SELECT json_array_contains('[1, 2, 3]', 2)
    SELECT json_array_get('["a", "b", "c"]', 0)结果为'a'
    SELECT json_array_length('[1, 2, 3]') 返回结果3
    SELECT json_extract(json, '$.store.book');
    SELECT json_size('[1, 2, 3]') 返回结果3

类型转换函数::

    cast([key|value] AS type)       在查询中将某一列（字段）或某一个值转换成指定类型。
          其中，如果某一个值转换失败，将终止整个查询
    try_cast([key|value] AS type)   在查询中将某一列（字段）或某一个值转换成指定类型。
          如果某一个值转换失败，该值返回NULL，并跳过该值继续处理

    % 实例:
    cast(123 AS varchar)    将数字123转换为字符串（varchar）格式
    cast(uid AS varchar)    将uid字段转换为字符串（varchar）格式

IP地理函数::

    IP 识别函数，可以识别一个IP是内网IP还是外网IP，也可以判断IP所属的国家、省份、城市。

    ip_to_domain(ip)    判断IP所在的域，是内网还是外网。返回intranet或internet
    ip_to_country(ip)   判断IP所在的国家。  
    ip_to_province(ip)  判断IP所在的省份。  
    ip_to_city(ip)      判断IP所在的城市。  
    ip_to_geo(ip)       判断IP所在的城市的经纬度，范围结果格式为纬度,经度。 
    ip_to_city_geo(ip)  判断IP所在的城市的经纬度，返回的是城市经纬度，
        每个城市只有一个经纬度，范围结果格式为纬度,经度。 
    ip_to_provider(ip)  获取IP对应的网络运营商。 
    ip_to_country(ip,'en')  判断IP所在的国家，返回国际码。  
    ip_to_country_code(ip)  判断IP所在的国家，返回国际码。  
    ip_to_province(ip,'en') 判断IP所在的省份，返回英文省名或者中文拼音。 
    ip_to_city(ip,'en')     判断IP所在的城市，返回英文城市名或者中文拼音。

    geohash(string) 将纬度、经度用geohash编码，string为字符串类型，内容是纬度、逗号、经度。
        select geohash('34.1,120.6')= 'wwjcbrdnzs'
    geohash(lat,lon)  将纬度、经度用geohash编码，参数分别是纬度和经度。  
        select geohash(34.1,120.6)= 'wwjcbrdnzs'

    % 实例:
    在查询中过滤掉内网访问请求，看请求总数
    * | select count(1) whereip_to_domain(ip)!='intranet'
    查看Top10的访问省份
    * | SELECT count(1) as pv, ip_to_province(ip) as province 
      GROUP BY province order by pv desc limit 10
    过滤掉内网请求，查看Top 10的网络访问省份
    * | SELECT count(1) as pv, ip_to_province(ip) as province 
      WHERE ip_to_domain(ip) != 'intranet'  
      GROUP BY province ORDER BY pv desc limit 10
    查看不同国家的平均响应延时，最大响应延时，最大延时对应的request
    * | SELECT AVG(latency),MAX(latency),MAX_BY(requestId, latency),
        ip_to_country(ip) as country 
        group by country limit 100
    查看不同网络运营商的平均延时
    * | SELECT AVG(latency) , ip_to_provider(ip) as provider 
        group by provider limit 100
    查看IP的经纬度，绘制地图
    * | select count(1) as pv , ip_to_geo(ip) as geo group by geo order by pv desc

GROUP BY 语法::

    GROUP BY 支持多列。GROUP BY支持通过SELECT的列的别名来表示对应的KEY
    * |select avg(latency),projectName,date_trunc('hour',__time__) as hour   
        group by projectName,hour
    GROUP BY 支持GROUPING SETS、CUBE、ROLLUP
    * |select avg(latency)   group by cube(projectName,logstore)
    * |select avg(latency)   group by 
        GROUPING SETS ( ( projectName,logstore), (projectName,method))
    * |select avg(latency)   group by rollup(projectName,logstore)

    % 实践样例
    按照每小时、每分钟统计计算PV
    * | SELECT count(1) as pv , date_trunc('hour',__time__) as hour 
        group by hour order by hour limit 100
    * | SELECT count(1) as pv , date_trunc('minute',__time__) as minute 
        group by minute order by minute limit 100
    按照灵活的时间维度进行统计，例如统计每5分钟的，date_trunc只能在按照一些固定时间间隔统计，
    这种场景下，我们需要按照数学取模方法进行GROUP BY。
    上述公式中的%300表示按照5分钟进行取模对齐。
    * | SELECT count(1) as pv,  __time__ - __time__% 300 as minute5 
        group by minute5 limit 100

    % 在GROUP BY 中提取非agg列
    例如，以下语法是非法的，因为b是非GROUP BY的列，在按照a进行GROUP BY时，
    有多行b可供选择，系统不知道该选择哪一行输出。
    *|select a, b , count(c) group by a
    为了达到以上目的，可以使用arbitrary函数输出b：
    *|select a, arbitrary(b), count(c) group by a

窗口函数::

    窗口函数用来跨行计算。普通的SQL聚合函数只能用来计算一行内的结果，或者把所有行聚合成一行结果。
    窗口函数，可以跨行计算，并且把结果填到到每一行中。

    % 窗口函数语法：
    SELECT key1, key2, value,
       rank() OVER (PARTITION BY key2
                    ORDER BY value DESC) AS rnk
    FROM orders
    ORDER BY key1,rnk
    % 核心部分是：
    rank() OVER (PARTITION BY  KEY1 ORDER BY KEY2 DESC)
    其中rank()是一个聚合函数，可以使用分析语法中的任何函数，也可以使用本文档列出的函数。
    PARTITION BY 是值按照哪些桶进行计算。

    窗口中使用的特殊聚合函数
    rank()          在窗口内，按照某一列排序，返回在窗口内的序号。
    row_number()    返回在窗口内的行号。
    first_value(x)  返回窗口内的第一个value，一般用法是窗口内数值排序，获取最大值。
    last_value(x)   含义和first value相反。
    nth_value(x, offset)  窗口内的第offset个数。
    lead(x, offset, defaut_value) 窗口内x列某行之后offset行的值，
          如果不存在该行，则取default_value。
    lag(x, offset, defaut_value)  窗口内x列某行之前offset行的值，
          如果不存在该行，则取default_value。

    % 使用样例
    在整个公司的人员中，获取每个人的薪水在部门内排名
    * | select department, persionId, sallary, 
        rank() over(PARTITION BY department order by sallary desc) as sallary_rank  
        order by department,sallary_rank
    在整个公司的人员中，获取每个人的薪水在部门内的占比
    * | select department, persionId, sallary,
      sallary *1.0 / sum(sallary) over(PARTITION BY department ) as sallary_percentage
    按天统计，获取每天UV相对前一天的增长情况
    * | select day ,uv, uv *1.0 /(lag(uv,1,0) over() ) as diff_percentage from
    (
        select approx_distinct(ip) as uv, date_trunc('day',__time__) as day 
        from log group by day order by day asc
    )

HAVING语法::

    日志服务查询分析功能支持标准SQL的HAVING语法，和GROUP BY配合使用，用于过滤GROUP BY的结果。
    格式：
    * |select avg(latency),projectName group by projectName HAVING avg(latency) > 100

    HAVING和WHERE的区别
    HAVING 用于过滤GROUP BY之后的聚合计算的结果，WHERE在聚合计算之间过滤原始数据。

    % 实例:
    对于气温大于10℃的省份，计算每个省份的平均降雨量，并在最终结果中只显示平均降雨量大于100mL的省份：
    * | select avg(rain) ,province where temperature > 10 
        group by province having avg(rain) > 100

CASE WHEN和IF分支语法::

    支持CASE WHEN语法，对连续数据进行归类:
    SELECT 
      CASE 
        WHEN http_user_agent like '%android%' then 'android' 
        WHEN http_user_agent like '%ios%' then 'ios' 
        ELSE 'unknown' 
      END  
    AS http_user_agent,
      count(1) as pv 
      group by  http_user_agent

    计算状态码为200的请求占总体请求的比例：
    * | SELECT 
      sum(
        CASE 
          WHEN status =200 then 1
          ELSE 0 
        end
      ) *1.0 / count(1) as status_200_percentage

    统计不同延时区间的分布：
    * | SELECT
      CASE
        WHEN latency < 10 then 's10'
        WHEN latency < 100 then 's100'
        WHEN latency < 1000 then 's1000'
        WHEN latency < 10000 then 's10000'
        else 's_large' 
      end
    as latency_slot,
    count(1) as pv
    group by latency_slot

    % IF语法
    if语法逻辑上等同于CASE WHEN语法。
    CASE
         WHEN condition THEN true_value
         [ ELSE false_value ]
    END

    if(condition, true_value)
    如果condition是true，则返回true_value这一列，否则返回null。

    if(condition, true_value, false_value)
    如果condition是true，则返回true_value这一列，否则返回false_value这一列。

    % COALESCE语法
    coalesce 返回多个列的第一个非Null值。
    coalesce(value1, value2[,...])

    % NULLIF 语法
    如果value1和value2相等，返回null，否则返回value1。
    nullif(value1, value2)

    % TRY 语法
    try语法可以捕获一些底层的异常，例如除0错误，返回null值。
    try(expression)

数组::

    下标运算符[]     用于获取数组中的某个元素。 -
    连接运算符||     用于把两个数组连接成一个数组。 
        SELECT ARRAY [1] || ARRAY [2]; — [1, 2]
        SELECT ARRAY [1] || 2; — [1, 2]
        SELECT 2 || ARRAY [1]; — [2, 1]
    array_distinct                数组去重，获取数组中的唯一元素。
    array_intersect(x, y)         获取x，y两个数组的交集。
    array_union(x, y) → array     获取x，y两个数组的并集。 
    array_except(x, y) → array    获取x，y两个数组的差集 
    array_join(x, delimiter, null_replacement) → varchar  
          把字符串数组用delimiter连接，拼接成字符串，null值用null_replacement替代。
          注: 使用array_join函数时，返回结果最大为1 KB，超出1 KB的数据会被截断。
    array_max(x) → x      获取x中的最大值。 
    array_min(x) → x      获取x中的最小值。 
    array_position(x, element) → bigint     
          获取element在x中的下标，下标从1开始。如果找不到，则返回0。 
    array_remove(x, element) → array    从数组中移除element。  
    array_sort(x) → array               给数组排序，null值放到最后。
    cardinality(x) → bigint             获取数组的大小。
    concat(array1, array2, …, arrayN) → array   连接数组。
    contains(x, element) → boolean              如果x中包含element，则返回true。
    filter(array, function) → array             function 是一个Lambda函数中的filter
    flatten(x) → array                          把二维的array拼接成一维的array。 
    reduce(array, initialState, inputFunction, outputFunction) → x  
          请参考lambda函数reduce。
    reverse(x) → array              把x反向排列。 
    sequence(start, stop) → array       生成从start到stop结束的一个序列，每一步加1。
    sequence(start, stop, step) → array 生成从start到stop结束的一个序列，每一步加step。
    sequence(start, stop, step) → array 
          start和stop是timestamp类型，生成从start到stop结束的timestamp数组。
          step是INTERVAL类型，可以是DAY到SECOND，也可以是YEAR或MONTH。    
    shuffle(x) → array                  重新随机分布array。  
    slice(x, start, length) → array     获取x数组从start开始，length个元素组成新的数组。
    transform(array, function) → array  请参考lambda函数transform()。 
    zip(array1, array2[, …]) → array    合并多个数组。
          结果的第M个元素的第N个参数，是原始第N个数组的第M个元素，相当于把多个数组进行了转置。
          SELECT zip(ARRAY[1, 2], ARRAY[‘1b’, null, ‘3b’]); —>
             [ROW(1, ‘1b’), ROW(2, null), ROW(null, ‘3b’)]
    zip_with(array1, array2, function) → array    请参考lambda函数zip_with
    array_agg (key)         聚合函数，表示把key这一列的所有内容变成一个array返回

二进制字符串函数::

    二进制字符串类型varbinary有别于字符串类型varchar。
    连接函数 ||                                   a || b 结果为ab。
    length(binary) → bigint                     返回二进制的长度。
    concat(binary1, …, binaryN) → varbinary     连接二进制字符串，等同于||。
    to_base64(binary) → varchar                 把二进制字符串转换成base64。
    from_base64(string) → varbinary             把base64转换成二进制字符串。
    to_base64url(binary) → varchar              转化成url安全的base64。
    from_base64url(string) → varbinary          从url安全的base64转化成二进制字符串。
    to_hex(binary) → varchar                    把二进制字符串转化成十六进制表示。
    from_hex(string) → varbinary                从十六进制转化成二进制。
    to_big_endian_64(bigint) → varbinary        把数字转化成大端表示的二进制。
    from_big_endian_64(binary) → bigint         把大端表示的二进制字符串转化成数字。
    md5(binary) → varbinary                     计算二进制字符串的md5。
    sha1(binary) → varbinary                    计算二进制字符串的sha1。
    sha256(binary) → varbinary                  计算二进制字符串的sha256 hash。
    sha512(binary) → varbinary                  计算二进制字符串的sha512。
    xxhash64(binary) → varbinary                计算二进制字符串的xxhash64。

位运算::

    bit_count(x, bits) → bigint       统计x的二进制表示中，1的个数。  
        SELECT bit_count(9, 64);  — 2
        SELECT bit_count(9, 8);   — 2
        SELECT bit_count(-7, 64); — 62
        SELECT bit_count(-7, 8);  — 6
    bitwise_and(x, y) → bigint         以二进制的形式求x,y的and的值。  -
    bitwise_not(x) → bigint            以二进制的形式求对x的所有位取反。 -
    bitwise_or(x, y) → bigint          以二进制形式对x，y求or。  -
    bitwise_xor(x, y) → bigint         以二进制形式对x，y求xor。

同比和环比函数::

    同比和环比函数用于比较当前区间的计算结果和之前一个指定区间的结果。
    compare(value, time_window)     
        表示将当前时段计算出来的value值和time_window计算出来的结果进行比较。
        value为double或long类型，time_window单位为秒；返回值为数组类型。
        返回值分别是当前值、time_window之前的值和当前值与之前值的比值。
        *|select compare( pv , 86400) from (select count(1) as pv from log)
    compare(value, time_window1, time_window2)  
        表示当前区间分别和time_window1和time_window2之前的区间值进行比较，结果为json数组。
        其中，各个值的大小必须满足以下规则：
          [当前值, time_window1之前的值，time_window2之前的值，
          当前值/time_window1之前的值, 当前值/time_window2之前的值]。 
        * | select compare(pv, 86400, 172800) from ( select count(1) as pv from log)
    compare(value, time_window1, time_window2, time_window3)  
    compare_result(value, time_window) 
        效果等同于compare(value, time_window)，但返回结果是字符串类型，
        格式为"当前值(增长百分比%)"。其中增长百分比默认保留2位小数。 
    compare_result(value,time_window1, time_window2)  
    ts_compare(value, time_window)  
        表示当前区间分别和time_window1和time_window2之前的区间值进行比较，结果为json数组。
        其中，各个值的大小必须遵循以下规则：
        [当前值, time_window1之前的值，当前值/time_window1之前的值，
            当前和前一个时间起点的unix时间戳]
        % 实例:
        * | select t, ts_compare(pv, 86400 ) as d from(
            select date_trunc('minute',__time__ ) as t, count(1) as pv 
            from log group by t order by t 
        ) group by t
        表示将当前时间段每分钟的计算结果和上一个时间段每分钟的计算结果进行比较。
        结果为：d:[1251.0, 1264.0, 0.9897151898734177, 1539843780.0,1539757380.0]t:2018-10-19 14:23:00.000

    % 实例
    计算当前1小时和昨天同一时段的PV比例。
    开始时间为2018-7-25 14:00:00；结束时间为2018-07-25 15:00:00。
    * | select compare( pv , 86400) from (select count(1) as pv from log)
    如果要把数组展开成3列数字，分析语句为
    * | select diff[1],diff[2],diff[3] from(
        select compare( pv , 86400) as diff from (select count(1) as pv from log)
    )

    计算当前1小时内每分钟的PV和昨天同时段的PV比值
    *| select t, compare( pv , 86400) as diff from (
        select count(1) as pv, date_format(from_unixtime(__time__), '%H:%i') as t 
        from log group by t
      ) group by t order by t
    将查询结果展开为折线图形式
    *|select t, diff[1] as current, diff[2] as yestoday, diff[3] as percentage 
      from(
        select t, compare( pv , 86400) as diff from (
          select count(1) as pv, date_format(from_unixtime(__time__), '%H:%i') as t
          from log group by t
        ) group by t order by t
      )

比较函数和运算符::

    % 比较运算符
    运算符       含义
    <           小于
    >           大于
    <=          小于或等于
    >=          大于或等于
    =           等于
    <>          不等于
    !=          不等于

    % 范围运算符 BETWEEN
    示例：
    SELECT 3 BETWEEN 2 AND 6
    => 
    SELECT 3 >= 2 AND 3 <= 6
    示例:
    SELECT 3 NOT BETWEEN 2 AND 6
    =>
    SELECT 3 < 2 OR 3 > 6
    如果三个参数中任何一个包含Null，则返回的结果为Null

    % IS NULL 和 IS NOT NULL
    该运算符用于判断参数是否是Null值。

    % IS DISTINCT FROM 和 IS NOT DISTINCT FROM
    类似于相等和不等判断，区别在于该运算符能够判断存在NULL值的情况。
    SELECT NULL IS DISTINCT FROM NULL; -- false
    SELECT NULL IS NOT DISTINCT FROM NULL; -- true

    a     b     a = b   a <> b   a DISTINCT b    a NOT DISTINCT b
    1     1     TRUE    FALSE       FALSE               TRUE
    1     2     FALSE   TRUE        TRUE                FALSE
    1     NULL  NULL    NULL        TRUE                FALSE
    NULL  NULL  NULL    NULL        FALSE               TRUE

    % GREATEST 和 LEAST
    用于获取多列中的最大值或者最小值。
    select greatest(1,2,3) ; -- 返回3

    % 比较判断：ALL、ANY 和 SOME
    比较判断用于判断参数是否满足条件
      ALL用于判断参数是否满足所有条件。如果逻辑成立，则返回true，否则返回false。
      ANY用于判断参数是否满足条件之一。如果逻辑成立，则返回true，否则返回false。
      SOME和ANY一样，用于判断参数是否满足条件之一。
      ALL、ANY 和 SOME必须紧跟在比较运算符之后。

    如下表所示，ALL和ANY支持多种情况下的比较判断。
    A = ALL (…)         A等于所有的值时，结果才是true。
    A <> ALL (…)        A不等于所有的值时，结果才是true。
    A < ALL (…)         A小于所有的值时，结果才是true。
    A = ANY (…)         A等于任何一个值时，结果就为true，等同于 A IN (…)。
    A <> ANY (…)        A不等于任何一个值时，结果为true。
    A < ANY (…)         A小于其中最大值时，结果为true。

    实例:
    SELECT 'hello' = ANY (VALUES 'hello', 'world'); -- true
    SELECT 21 < ALL (VALUES 19, 20, 21); -- false
    SELECT 42 >= SOME (SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43); -- true

逻辑函数::

    a       b        a AND b    a OR b
    FALSE   NULL    FALSE         NULL
    NULL    TRUE    NULL          TRUE
    NULL    FALSE   FALSE         NULL
    NULL    NULL    NULL          NULL

    not NULL  => NULL

空间几何函数::

    @todo 


电话号码函数::

    电话号码函数提供对中国大陆区域电话号码的归属地查询功能。
    mobile_province    
      * | select mobile_province(12345678)
      * | select mobile_province(try_cast('12345678' as bigint) )
    mobile_city       
      * | select mobile_city(12345678)
      * | select mobile_city(try_cast('12345678' as bigint) )
    mobile_carrier    
      * | select mobile_carrier(12345678)
      * | select mobile_carrier(try_cast('12345678' as bigint) )











.. [1] https://help.aliyun.com/document_detail/63445.html






