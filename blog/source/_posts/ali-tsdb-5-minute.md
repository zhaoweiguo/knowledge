---
title: 5分钟了解阿里时序时空数据库
date: 2019-05-24 11:19:13
categories:
- aliyun
tags:
- aliyun
- tsdb
---

### 简介

时序时空数据库（Time Series & Spatial Temporal Database，简称 TSDB）是一种高性能、低成本、稳定可靠的在线时序时空数据库服务，提供高效读写、高压缩比存储、时序数据插值及聚合计算等服务，广泛应用于物联网（IoT）设备监控系统、企业能源管理系统（EMS）、生产安全监控系统和电力检测系统等行业场景；除此以外，还提供时空场景的查询和分析的能力。
<!--more-->

### 三个数据库

时序时空数据库文档最近经过几次大的变动，有点乱，看的时候注意一下。

##### 时序数据库TSDB版

经过阿里集团大规模验证的时序数据库，支持分布式集群架构水平扩展，支持千万物联网设备接入，基于自研压缩算法，具备高效压缩比。

```
- 针对时序数据优化，包括存储模型，多值数据模型，时序数据压缩、聚合、采样，高效压缩算法，列存，边缘一体化；
- 具备高性能，内存优先数据处理，分布式MPP SQL并行计算，动态schema，实时流式数据计算引擎，海量时间线自适应索引；
- 高可扩展，数据动态分区，水平扩展，动态弹性扩容，动态升降配规格；高可靠性，自动集群控制，线程级读写分离，多层数据备份，分级存储；
- 瞄准的是大规模指标数据，事件数据场景
```

协议兼容OpenTSDB，但后面内核实现是阿里自研的。但还是完全可以把它当作OpenTSDB的阿里云版，参见 [相比OpenTSDB优势](https://help.aliyun.com/document_detail/113368.html)

##### InfluxDB®

不仅仅是一个数据库，更是一个监控系统，围绕采集，可视化，分析服务，事件和指标存储和计算系统；走的是tick生态，瞄准指标，事件，trace，日志，实时分析场景。

InfluxDB®刚上线不久，现在还处在公测阶段。写入速度经测试，每次500条数据，每秒可以执行26次左右，平均速度达到1万/s，增加每次写入数据条数应该还能提高速度。另外，请求地址是外网，如果使用vpc网络速度应该还会加快不少。

注意：InfluxDB在阿里云上有时间线限制(数据库级别最高1万)，时间线的定义参见后面简介。

##### 时空数据库

时空数据库能够存储、管理包括时间序列以及空间地理位置相关的数据。时空数据是一种高维数据，具有时空数据模型、时空索引和时空算子，完全兼容SQL及SQL/MM标准，支持时空数据同业务数据一体化存储、无缝衔接，易于集成使用。

时空数据库主要是空间相关的场景，比如热力图，店铺选址等等。


### 时序数据库简介(主要是InfluxDB)

时序数据库英文全称为 Time Series Database，提供高效存取时序数据和统计分析功能的数据管理系统。主要的时序数据库包括OpenTSDB、Druid、InfluxDB以及Beringei这四个。本人主要了解一点OpenTSDB和InfluxDB，不过时序数据库有很多共性。

##### 基本名词

measurement:
```
tag，field和time列的容器
对InfluxDB: measurement在概念上类似于传统DB的table（表格）
  从原理上讲更像SQL中表的概念，这和其他很多时序数据库有些不同
对其他时序DB: Measurement与Metric等同
```

field(数值列):
```
TSDB For InfluxDB®中不能没有field。
注意:field是没有索引的
在某种程度上，可以把field理解为k/v表的value
```

tag(维度列):
```
tag不是必须要有的字段
tag是被索引的，这意味着以tag作为过滤条件的查询会更快
在某种程度上，可以把field理解为k/v表的key
```

timestamp(时间戳):
```
默认使用服务器的本地时间戳
时间戳是UNIX时间戳,单位:纳秒
最小的有效时间戳是-9223372036854775806或1677-09-21T00:12:43.145224194Z
最大的有效时间戳是9223372036854775806或2262-04-11T23:47:16.854775806Z
```

point（数据点）:
```
由时间线（series）中包含的field组成。每个数据点由它的时间线和时间戳（timestamp）唯一标识
您不能在同一时间线存储多个有相同时间戳的数据点
```


##### Series(时间线)

Series是InfluxDB中最重要的概念，时序数据的时间线就是:一个数据源采集的一个指标随着时间的流逝而源源不断地吐出数据这样形成的一条数据线称之为时间线。

下图中有两个数据源，每个数据源会采集两种指标:
```
Series由Measurement和Tags组合而成，
Tags组合用来唯一标识Measurement
就是说:
1. Measurement不同，就是不同的时间线
2. Measurement相同，Tags不同也是不同的时间线
```

##### retention policy（保留策略，简称RP）

一个保留策略描述了:
```
  1.InfluxDB保存数据的时间（DURATION）
  2.以及存储在集群中数据的副本数量（REPLICATION）
  3.指定ShardGroup Duration
注:复本系数（replication factors）不适用于单节点实例。
autogen:无限的存储时间并且复制系数设为1
```

RP创建语句如下:
```
CREATE RETENTION POLICY ON <retention_policy_name> ON <database_name>
DURATION <duration> REPLICATION <n> [SHARD DURATION <duration> ] [DEFAULT]
实例:
CREATE RETENTION POLICY "one_day_only" ON "water_database"
DURATION 1d REPLICATION 1 SHARD DURATION 1h DEFAULT
```
写入时指定rp进行写入:
```
% 如果没有指定任何RP，则使用默认的RP
curl -X POST 'http://localhost:8086/write?db=mydb&rp=six_month_rollup'
    --data-binary 'disk,host=server01 value=442221834240i 1435362189575692182'
```

##### Shard Group
Shard Group是InfluxDB中一个重要的逻辑概念:
```
Shard Group会包含多个Shard，每个Shard Group只存储指定时间段的数据
不同Shard Group对应的时间段不会重合
```

每个Shard Group对应多长时间是通过Retention Policy中字段”SHARD DURATION”指定的:
```
如果没有指定，也可以通过Retention Duration（数据过期时间）计算出来，两者的对应关系为:

Retention Duration              SHARD DURATION
<2 days                             1h
>=2days and <=6month                1day
>6month                             7day
```

Shard:
```
类似于HBase中Region，Kudu中Tablet的概念
1. Shard是InfluxDB的存储引擎实现，具体称之为TSM(Time Sort Merge Tree) Engine
    负责数据的编码存储、读写服务等。
TSM类似于LSM，因此Shard和HBase Region一样包含Cache、WAL以及Data File等各个组件，
    也会有flush、compaction等这类数据操作
2. Shard Group对数据按时间进行了分区
    InfluxDB采用了Hash分区的方法将落到同一个Shard Group中的数据再次进行了一次分区
    InfluxDB是根据hash(Series)将数据映射到不同的Shard,而非根据Measurement进行hash映射
```

### InfluxQL

##### 行协议
格式:
```
<measurement>[,<tag_key>=<tag_value>[,<tag_key>=<tag_value>]] 
  <field_key>=<field_value>[,<field_key>=<field_value>] [<timestamp>]
```

以下是符合格式的数据写入TSDB For InfluxDB®的示例：
```
1. cpu,host=serverA,region=us_west value=0.64
2. payment,device=mobile,product=Notepad,method=credit billed=33,licenses=3i 1434067467100293230
3. stock,symbol=AAPL bid=127.46,ask=127.48
4. temperature,machine=unit42,type=assembly external=25,internal=37 1434067467000000000
```

##### 登录

```
// 登录
$> influx -ssl -username <账号名称> -password <密码> -host <网络地址> -port 3242
// 创建用户
> create user gordon with password '1QAZ2wsx'
// 赋值权限
grant all privileges to gordon
// 创建数据库
create database testdb
```

##### 基本QL
```
1. # 显示时间线
show series
2. # 显示度量
show measurements
3. # 显示Tag的Key
show tag keys
4. # 显示数据字段的Key
show field keys
```

查询:
```
1. select * from metrics
2. show tag keys from metrics
3. show field keys from metrics

# 查看自定度量的数据, 里面的相关字段，官方建议使用“双引号”标注出来
select * from "CPU" order by time desc

# 查看指定的Field和Tag
select "load1","role" from "CPU" order by time desc

# 只查看Field
select *::field from "CPU"

# 查询指定Tag的数据，注意，Where子句的字符串值要使用“单引号”，字符串值
# 如果没有使用引号或者使用了双引号，都不会有任何值的返回
select * from "CPU" where role = 'FrontServer'

# 查询Field中，load1 > 20 的所有数据
select * from "CPU" where "load1" > 20

```

插入:
```
INSERT weather,location=us-midwest temperature=82 1465839830100400200
```

基本运算:
```
# 执行基本的运算
select ("load1" * 2) + 0.5 from "CPU"

// SELECT语句支持使用基本的数学运算符，例如，+、-、/、*和()等等。
SELECT field_key1 + field_key2 AS "field_key_sum"
  FROM "measurement_name" WHERE time < now() - 15m

SELECT (key1 + key2) - (key3 + key4) AS "some_calculation"
  FROM "measurement_name" WHERE time < now() - 15m

// 使用聚合函数计算百分比:
SELECT (sum(field_key1) / sum(field_key2)) * 100 AS "calculated_percentage"
  FROM "measurement_name" WHERE time < now() - 15m GROUP BY time(1m)

```












