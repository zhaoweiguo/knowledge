限制说明
------------

基础资源::

    Project:  每个账号下最多可创建50个Project
    Logstore: 一个Project中最多可创建200个Logstore
    Shard:    一个Project中最多可创建200个Shard
              控制台创建Logstore时;一个Logstore最多可创建10个Shard
              API创建Logstore时;最多可创建100个,但可以通过分裂操作来增加Shard
    Logtail:  每个Project最多可创建100个Logtail配置
    日志保存时间:
              支持永久保存
              您也可以自定义日志保存时间;取值范围为1~3000
    MachineGroup: 每个Project最多可创建100个机器组
    ConsumerGroup:每个Logstore最多可创建10个协同消费组
    SavedSearch:  每个Project最多可创建100个快速查询
    Dashboard:    每个Project最多可创建50个仪表盘
                  每个仪表盘最多可包含50张分析图表
    LogItem:      API:单个长度最大为1 MB
                  Logtail:单个最大为 512KB
    LogGroup:     每个日志组中最多包含4096条日志;且最大长度为5 MB

数据读写::

    Project:
      写入流量最大为30 GB/min即: 500MB/s
      写入次数最大为60,0000 次/min, 10000 次/s
      读取次数最大为60,0000 次/min, 10000 次/s
    Shard:
      写入流量最大为5 MB/s
      写入次数最大为500 次/s
      读取流量最大为10 MB/s
      读取次数最大为100 次/s

查询分析与可视化::

    查询（Search）:
      关键词;即单词查询时布尔逻辑符外的条件个数每次查询最多30个
      单个字段（Value）长度最大为10 KB;超出部分不参与查询
      单个Project并发最大为100个
      对于超过1w个字符的日志;日志服务只会对前10,000个字符进行DOM切词处理
    SQL分析（Analytics）:
      单个字段（Value）最大长度为2 KB;超出部分不参与查询
      单个Project并发不超过15个
      每次分析的返回结果最大100 MB或100,000条
      使用分析语句时;字段长度最大支持2 KB
      Double类型最多用52位表示;如果浮点数编码位数超过52位;会有精度损失

Project::

    目前;日志服务仅提供控制台方式创建Project
    Project的名字需要全局唯一（在所有阿里云Region内）
    Project创建时需要指定所在的阿里云Region
    Project一旦创建完成则无法改变其所属地域;且日志服务不支持Project的迁移
    一个阿里云账户在所有阿里云Region最多可创建50个Project

logtail日志::

    单条日志大小限制为512KB
    对于日志中包含’\0’的行，该条日志会被截断到第一个’\0’处
    吞吐:原始日志流量默认限制为2MB/s
    性能:
      单核能力：极简模式日志最大处理能力为100MB/s
      正则默认最大处理能力为20MB/s（和正则复杂度有关）
      分隔符日志最大处理能力为40MB/s
      JSON日志最大处理能力为30MB/s
      开启多个处理线程性能可提高1.5-3倍左右
    监控目录数:最多3000个目录（含子目录）
    监控文件数:
      每个Logtail采集配置监控的最大文件数量为10,000个
      每台服务器上的Logtail客户端最多可监控100,000个文件
    默认资源限制:
      默认Logtail最多会占用40%CPU、256MB内存
    资源超限处理策略:
      若3分钟内Logtail占用的相关资源超过最大限制，则Logtail会强制重启

    其他:
      日志采集延迟:正常情况下从日志flush磁盘到Logtail采集改日志延迟不超过1秒
      日志上传策略:
        Logtail会将同一文件的日志自动聚合上传，聚合条件为:
          1.日志超过2000条
          2.日志总大小超过2M
          3.日志采集时间超过3秒
          任一条件满足则触发上传行为

    time字段,超过12小时会被作为过期日志丢弃的


Storm::

    每个Logstore最多支持 10 个Consumer Group
    Spout的个数最好和Shard个数相同，否则可能会导致单个Spout处理数据量过多而处理不过来
    如果单个Shard 的数据量太大,超过一个Spout处理极限,使用Shard split接口分裂Shard
    在Loghub Spout中，强制依赖Storm的ACK机制，用于确认Spout将消息正确发送至Bolt

分区的读写能力::

    写入：5MB/s;500次/s
    读取：10MB/s;100次/s













