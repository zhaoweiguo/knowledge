大数据
##########

.. toctree::
   :maxdepth: 1


   big_datas/concept
   big_datas/analysis_tool
   big_datas/data_collection
   big_datas/data_warehouse
   big_datas/data_lake
   big_datas/hadoop
   big_datas/db_hdfs
   big_datas/realtime_computer
   big_datas/other


数据分析类型::

  数据分析的实时与否
    实时分析任务（金融、电子商务）
    离线分析任务（数据挖掘搜、索引擎索引计算、推荐内容计算、机器学习）
  分析的数据类型不同
    流式数据处理（数据整体价值）
      负载、QPS、网络 Traffic、磁盘 IO
      交易下单笔数、交易总金额、PV、UV
      用户行为分析
    批量数据处理


大数据平台是一个庞大的系统工程，整个建设周期很长，涉及的生态链很长(包括：数据采集、接入，清洗、存储计算、数据挖掘，可视化等环节，每个环节都当做一个复杂的系统来建设)，风险也很大。

大数据特征：“大量化(Volume)、多样化(Variety)、快速化(Velocity)、价值密度低（Value）”就是“大数据”显著的4V特征，或者说，只有具备这些特点的数据，才是大数据。
大数据技术要解决的问题：大数据技术被设计用于在成本可承受的条件下，通过非常快速（velocity）地采集、发现和分析，从大量（volumes）、多类别（variety）的数据中提取价值（value），将是IT领域新一代的技术与架构。

app大数据::

    设备指纹
    用户画像
    应用留存
    行业分析
    应用活跃
    安装卸载

一个标准化的建模工作大体包含以下几个步骤::

    首先选取一批正负样本用户；
    然后对其进行特征补全，把无关特征进行降维操作；
    之后，选择合适的模型进行训练，这也是一个非常消耗CPU的过程；
    接下来是目标预测，我们需要整理或补齐目标用户的所有特征，再将数据投入模型中，获得预测结果；
    最后是模型评估。
    模型评估之后，再进行下一个迭代调整，循环往复。


名词
----------
* DCL:数据缓冲层
* DDL:数据明细层
* DAL:数据应用层::

    存储运营分析:Operations Analysis
    指标体系:Metrics System
    线上服务:Online Service
    用户分析:User Analysis

* DSL:数据汇总层
* Analysis:数据分析层


采 用 HAProxy+Keepalived+Flume-NG 构建高性能高可用分布式数据采集系统
采用 Hadoop 构建 PB 级大数据平台，提供海量数据存储和分布式计算
采用 Hive 做为数据清洗引擎，提供 PB级数据预处理、加工、整合服务。
采用 Spark R 组件，Spark R 提供了 Spark中弹性分布式数据集的 API，用户可以在集群上通过 R shell 交互性的运行 job。数据挖掘模型以 Spark On Yarn 的 yarn-cluster 方式构建大数据分析引擎。



用户画像 [1]_ [2]_





.. [1] https://www.zhihu.com/question/19853605
.. [2] https://zhuanlan.zhihu.com/p/43354501

