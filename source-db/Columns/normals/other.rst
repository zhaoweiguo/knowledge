其他
####



Greenplum DB
============

* 官网: https://greenplum.org/
* GitHub: https://github.com/greenplum-db/gpdb ::
    
    源码: C/C++
    开源协议: Apache 2.0
    star: 3.6k(2019-12)
    star: 4.6k(2021-07-06)

该公司成立于 2003 年，2006 年推出了首款产品，其主营业务关注在数据仓库和商业智能方面，Greenplum DW/BI 软件可以在虚拟化 x86 服务器上运行无分享（shared-nothing）的大规模并行处理（MPP）架构

Greenplum 提供称为 “多态存储” 的灵活存储方式。多态存储可以根据数据热度或者访问模式的不同而使用不同的存储方式。一张表的不同数据可以使用不同的物理存储方式。支持的存储方式包含::

    1. 行存储
        行存储是传统数据库常用的存储方式，特点是访问比较快，多列更新比较容易。
    2. 列存储
        列存储按列保存，不同列的数据存储在不同的地方（通常是不同文件中）。
        适合一次只访问宽表中某几个字段的情况。列存储的另外一个优势是压缩比高。
    3. 外部表
        数据保存在其他系统中例如 HDFS，数据库只保留元数据信息。




Impala
======


* Impala 是 Cloudera 公司推出，提供对 HDFS、Hbase 数据的高性能、低延迟的交互式 SQL 查询功能。
* 基于 Hive 使用内存计算，兼顾数据仓库、具有实时、批处理、多并发等优点
* impala 使用 hive 的元数据，完全在内存中计算

* 官网: https://impala.apache.org/
* GitHub: https://github.com/apache/impala ::
    
    C++
    star: 2.2k(2019-12)
    star: 621(2021-07-06)



Pinot
=====

* GitHub: https://github.com/apache/incubator-pinot ::
    
    Java
    star: 2.4k(2019-12)
    star: 3.1k(2021-07-06)

Kylin
=====


* GitHub: https://github.com/apache/kylin ::
    
    Java
    star: 2.4k(2019-12)
    star: 3.1k(2021-07-06)






