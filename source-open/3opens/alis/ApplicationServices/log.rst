ali日志
###########


.. toctree::
   :maxdepth: 1

   logs/common
   logs/collection
   logs/limit
   logs/sql_function_search
   logs/sql_function_analytics
   logs/sql_function_analytics_time
   logs/sql_function_analytics_lambda
   logs/sql_function_analytics_complex
   logs/sql_function2
   logs/sql_function_ml
   logs/k8s_collect
   logs/example
   logs/example2
   logs/example_slb
   logs/pay
   logs/question

注意事项::

    1. 同时配置全文查询和键值查询时;如果索引设置中两者的分词符不同;以键值索引设置为准;使用全文查询方式无法查出有效数据
    2. 设置某字段的数据类型为double或long后;才能通过数值范围查询这些字段的数据若未设置数据类型、或者数值范围查询的语法错误;日志服务会将该查询条件解释成全文索引;可能与您的期望的结果不同
    3. 如果将某字段由文本类型改成数值类型;则修改索引之前采集到的数据只支持=查询



说明:
当写入的API持续报告403或者500错误时;通过Logstore云监控查看流量和状态码判断是否需要增加分区
对超过分区服务能力的读写;系统会尽可能服务;但不保证服务质量



机器学习语法与函数
--------------------
https://help.aliyun.com/document_detail/93024.html?spm=a2c4g.11186623.6.787.7edc7279CcEBMP

优秀分析案例
---------------
https://help.aliyun.com/document_detail/63662.html?spm=a2c4g.11186623.6.798.749c5ff9Ly2nCK


可视化分析 
=============

分析图表 
----------
https://help.aliyun.com/document_detail/69313.html?spm=a2c4g.11186623.6.804.50866e15mPnLon

仪表盘
--------
https://help.aliyun.com/document_detail/102530.html?spm=a2c4g.11186623.6.818.51402960JQn3jf

日志服务可视化重磅升级！专属你的炫酷仪表盘: https://yq.aliyun.com/articles/689418

其他可视化方案
---------------

https://help.aliyun.com/document_detail/74971.html?spm=a2c4g.11186623.6.827.46d115192Fz07g
如::
    
    控制台分享内嵌
    Grafana
    DataV


命令行工具CLI
================








