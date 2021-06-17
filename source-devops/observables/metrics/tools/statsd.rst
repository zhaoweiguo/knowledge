statsd相关 [1]_
################

StatsD 概念::

  buckets、values、flush interval

用法::

  % 简单的行协议
  <bucket>:<value>|<type>[|@sample_rate]
  
  % bucket
  bucket是一个metric的标识，可以看成一个metric的变量

  % value
  metric的值，通常是数字

  % type
  metric的类型，通常有timer、counter、gauge和set四种

  % sample_rate
  采样频率,防止发送数据量过大,溢满statsd


StatsD生态环境系列工具::

  Interations(集成化):
      dd-agent
      Puppet
      Chef
      Librato
      App First
  Visualization(可视化):
      graphite
      grafana
  DataHosting:
      Host Graphite
  一体化解决方案:
      Cloud Insight
      Datadog
      Librato
  Events Processing:
      事件处理引擎与时间序列数据库
        或者基于 StastD 的一体化解决方案对接
        从而弥补除开展现之外的报警这个方向上的不足
      Riemann
      Bosun
  Time-series Database: StatsD 和时间序列数据库的出现，是相辅相成
      OpenTSDB
      Influxdb
      Signal FX: https://www.signalfx.com




安装::

  git clone git@github.com:etsy/statsd.git
  node stats.js path/to/config

配置::

  port: 8125  % 默认端口

  % 后端: console, graphite,influxdb
  backends: ["./backends/console", "./backends/graphite"],
  console: {
      prettyprint: true
  }

  % statsd 默认是10s执行一次flush
  flushInterval: 2000  // 设为2s


指标 metric::

  1.计数器 counter:
  % counter类型的指标,用来计数
  % 在一个flush区间,把上报的值累加
  % 值可以是正数或者负数
  user.logins:10|c        // user.logins + 10
  user.logins:-1|c        // user.logins - 1 
  user.logins:10|c|@0.1   // user.logins + 10/0.1=100
                 // users.logins = 10-1+100=109

  2.计时器 timer
  timers用来记录一个操作的耗时,单位ms
  statsd会记录:
  平均值（mean）
  最大值（upper）
  最小值（lower）
  累加值（sum）
  平方和（sum_squares）
  个数（count）以及部分百分值
  以下是一个flush期间,发送了一个rpt的timer值100:
    count_80: 1,    
    mean_80: 100,
    upper_80: 100,
    sum_80: 100,    
    sum_squares_80: 10000, 
    std: 0,     
    upper: 100,
    lower: 100,
    count: 1,
    count_ps: 0.1,
    sum: 100,
    sum_squares: 10000,
    mean: 100,
    median: 100
  百分数相关的数据:
  以90为例。statsd会把一个flush期间上报的数据，去掉10%的峰值
  即按大小取cnt*90%（四舍五入）个值来计算百分值
  假如10s内上报以下10个值:
  1,3,5,7,13,9,11,2,4,8
  则只取10*90%=9个值,去掉13。百分值即按剩下的9个值来计算
  $KEY.mean_90   // (1+3+5+7+9+2+11+4+8)/9
  $KEY.upper_90  // 11
  $KEY.lower_90  // 1

  3.标量 gauge
  gauge是任意的一维标量值
  gague值不会像其它类型会在flush的时候清零，而是保持原有值
  statsd只会将flush区间内最后一个值发到后端
  另外，如果数值前加符号，会与前一个值累加:
  age:10|g    // age 为 10
  age:+1|g    // age 为 10 + 1 = 11
  age:-1|g    // age为 11 - 1 = 10
  age:5|g     // age为5,替代前一个值

  4.sets
  记录flush期间，不重复的值:
  request:1|s  // user 1
  request:2|s  // user1 user2
  request:1|s  // user1 user2





实例::

  echo "foo:1|c" | nc -u -w0 127.0.0.1 8125


历史::

  2008 年Statsd 最早是  Flickr 公司用 Perl 写的针对 Graphite、datadog 等监控数据后端存储开发的前端网络应用
  2011 年 Etsy 公司用 node.js 重构

  statsd狭义来讲，其实就是一个监听UDP（默认）或者TCP的守护程序
  根据简单的协议收集statsd客户端发送来的数据，聚合之后
  定时推送给后端，如graphite和influxdb等，再通过grafana等展示
  不过现在通常是指statsd系统。StatsD系统包括三部分:
    客户端（client）、服务器（server）和后端（backend）
    1.客户端植入于应用代码中，将相应的metrics上报给StatsD server
    2.statsd server聚合这些metrics之后，定时发送给backends
    3.backends则负责存储这些时间序列数据，并通过适当的图表工具展示

* 2011年2月Ian Malpass发布blog:Measure Anything, Measure Everything [2]_

优点::

  1.简单——非常容易获取的应用程序,StatsD 协议是基于文本的,可以直接写入和读取
  2.低耦合性——基于后台程序运行的应用程序,采取UDP这种「fire-and-forget」的协议,收集指标和应用程序本身之间没有依赖
  3.占用空间小——StatsD 客户端非常轻便的,不带任何状态,不需要的线程
  4.普遍及支持多种语言



.. [1] https://github.com/etsy/statsd
.. [2] `Measure Anything, Measure Everything <https://codeascraft.com/2011/02/15/measure-anything-measure-everything/>`_




