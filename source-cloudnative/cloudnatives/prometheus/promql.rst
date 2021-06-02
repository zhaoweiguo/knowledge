PromQL
######

PromQL 查询结果主要有 3 种类型::

    1. 瞬时数据 (Instant vector): 
        包含一组时序，每个时序只有一个点，例如:
        http_requests_total
    2. 区间数据 (Range vector): 
        包含一组时序，每个时序有多个点，例如:
        http_requests_total[5m]
    3. 纯量数据 (Scalar): 
        纯量只有一个数字，没有时序，例如:
        count(http_requests_total)

查询条件::

    http_requests_total{code="200"} // 表示查询名字为 http_requests_total，code 为 "200" 的数据
    http_requests_total{code!="200"}  // 表示查询 code 不为 "200" 的数据
    http_requests_total{code=～"2.."} // 表示查询 code 为 "2xx" 的数据
    http_requests_total{code!～"2.."} // 表示查询 code 不为 "2xx" 的数据

操作符::

    1. 算术运算符:
    支持的算术运算符有 +，-，*，/，%，^,
    例如 http_requests_total * 2 表示将 http_requests_total 所有数据 double 一倍。

    2. 比较运算符:
    支持的比较运算符有 ==，!=，>，<，>=，<=, 
    例如 http_requests_total > 100 表示 http_requests_total 结果中大于 100 的数据。
    
    3. 逻辑运算符:
    支持的逻辑运算符有 and，or，unless, 
    例如 http_requests_total == 5 or http_requests_total == 2 表示 http_requests_total 结果中等于 5 或者 2 的数据。
   
    4. 聚合运算符:
    支持的聚合运算符有 sum，min，max，avg，stddev，stdvar，count，count_values，bottomk，topk，quantile
    例如 max(http_requests_total) 表示 http_requests_total 结果中最大的数据。

.. note:: 注意，和四则运算类型，Prometheus 的运算符也有优先级，它们遵从（^）> (❋, /, %) > (+, -) > (==, !=, <=, <, >=, >) > (and, unless) > (or) 的原则


内置函数 [1]_ ::

    Prometheus 内置不少函数，方便查询以及数据格式化，例如:
    // 将结果由浮点数转为整数的 floor 和 ceil，
    floor(avg(http_requests_total{code="200"}))
    ceil(avg(http_requests_total{code="200"}))

    查看 http_requests_total 5分钟内增长率:
    rate(http_requests_total[5m])

    访问量前10的HTTP地址:
    topk(10, http_requests_total)


聚合, 统计高级查询::

    1. count 查询: 统计当前记录总数
    count(http_requests_total)

    2. sum 查询: 统计当前数据总值
    sum(http_requests_total)

    3. avg 查询: 统计当前数据平均值
    avg(http_requests_total)

    4. top 查询: 查询最靠前的 3 个值
    topk(3, http_requests_total)

    5. irate 查询，过去 5 分钟平均每秒数值
    irate(http_requests_total[5m])

实例::

    # 查询系统所有http请求的总量
    sum(http_request_total)

    # 按照mode计算主机CPU的平均使用时间
    avg(node_cpu) by (mode)

    # 按照主机查询各个主机的CPU使用率
    sum(sum(irate(node_cpu{mode!='idle'}[5m]))  / sum(irate(node_cpu[5m]))) by (instance)







.. [1] https://prometheus.io/docs/querying/functions/