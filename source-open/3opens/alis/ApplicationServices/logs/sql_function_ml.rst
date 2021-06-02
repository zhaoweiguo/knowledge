机器学习
############

根因分析函数
-------------------

rca_kpi_search::

    函数格式
    select rca_kpi_search(varchar_array, name_array, real, forecast, level)
    参数说明如下：
    varchar_array   属性维度字段。 数组形式，例如：array[col1, col2, col3]。
    name_array      属性名字字段。 数组形式，例如：array['col1', 'col2', 'col3']。
    real            varchar_array对应的实际值。  double 类型，取值范围：全体实数。
    forecast        varchar_array对应的预测值。  double 类型，取值范围：全体实数。
    level           输出的根因集合对应的维度属性的数量，
                      其中level=0表示输出找到的全部根因集合。 
                      long类型，取值范围：0<=level<=分析维度数（对应varchar_array的长度）

查询分析::

    % 先利用子查询去组织每个细粒度属性对应的实际值和预测值，
    % 然后直接调用rca_kpi_search函数去分析异常时刻的根因。
    * not status:200 | 
      select rca_kpi_search(
          array[ Project, LogStore, UserAgent, Method ],
          array[ 'Project', 'LogStore', 'UserAgent', 'Method' ], 
          real, forecast, 1) 
      from ( 
          select 
            Project, LogStore, UserAgent, Method,
            sum(
                case when time < 1552436040 then real else 0 end
              ) * 1.0 / sum(
                  case when time < 1552436040 then 1 else 0 end
              ) as forecast,
            sum(
                case when time >=1552436040 then real else 0 end
              ) *1.0 / sum(case when time >= 1552436040 then 1 else 0 end) as real
          from ( 
              select 
                  __time__ - __time__ % 60 as time, Project, LogStore, 
                    UserAgent, Method, COUNT(*) as real 
              from log 
              GROUP by time, Project, LogStore, UserAgent, Method 
          ) 
          GROUP BY Project, LogStore, UserAgent, Method limit 100000000
      )








