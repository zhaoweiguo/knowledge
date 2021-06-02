其他技术
########

.. _apache_sqoop:

Sqoop
''''''''
Sqoop(发音：skup)是一款开源的工具，主要用于在Hadoop(Hive)与传统的数据库(mysql、postgresql...)间进行数据的传递，可以将一个关系型数据库（例如 ： MySQL ,Oracle ,Postgres等）中的数据导进到Hadoop的HDFS中，也可以将HDFS的数据导进到关系型数据库中。
Sqoop项目开始于2009年，最早是作为Hadoop的一个第三方模块存在，后来为了让使用者能够快速部署，也为了让开发人员能够更快速的迭代开发，Sqoop独立成为一个Apache项目。

.. _kettle:

Kettle
''''''''
Kettle是一款国外开源的ETL工具，纯java编写，可以在Windows、Linux、Unix上运行，数据抽取高效稳定。
Kettle 中文名称叫水壶，该项目的主程序员MATT希望把各种数据放到一个壶里，然后以一种指定的格式流出。
Kettle家族目前包括4个产品：Spoon、Pan、CHEF、Kitchen。
SPOON 允许你通过图形界面来设计ETL转换过程（Transformation）。
PAN 允许你批量运行由Spoon设计的ETL转换 (例如使用一个时间调度器)。Pan是一个后台执行的程序，没有图形界面。
CHEF 允许你创建任务（Job）。 任务通过允许每个转换，任务，脚本等等，更有利于自动化更新数据仓库的复杂工作。任务通过允许每个转换，任务，脚本等等。任务将会被检查，看看是否正确地运行了。
KITCHEN 允许你批量使用由Chef设计的任务 (例如使用一个时间调度器)。KITCHEN也是一个后台运行的程序。


ETL
''''''

ETL，是英文Extract-Transform-Load的缩写，用来描述将数据从来源端经过萃取（extract）、转置（transform）、加载（load）至目的端的过程。ETL一词较常用在数据仓库，但其对象并不限于数据仓库。
ETL所描述的过程，一般常见的作法包含ETL或是ELT（Extract-Load-Transform），并且混合使用。通常愈大量的数据、复杂的转换逻辑、目的端为较强运算能力的数据库，愈偏向使用ELT，以便运用目的端数据库的平行处理能力。 

.. _apache_zeppelin:

Zeppelin（Apache开源框架）
'''''''''''''''''''''''''''''
Apache Zeppelin是一个让交互式数据分析变得可行的基于网页的开源框架。Zeppelin提供了数据分析、数据可视化等功能。
Zeppelin 是一个提供交互数据分析且基于Web的笔记本。方便你做出可数据驱动的、可交互且可协作的精美文档，并且支持多种语言，包括 Scala(使用 Apache Spark)、Python(Apache Spark)、SparkSQL、 Hive、 Markdown、Shell等等。










