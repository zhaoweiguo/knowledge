脚本列表
########

::

    脚本名称  用途描述
    connect-distributed.sh  连接kafka集群模式
    connect-standalone.sh 连接kafka单机模式
    kafka-acls.sh todo
    kafka-broker-api-versions.sh  todo
    kafka-configs.sh  配置管理脚本
    kafka-console-consumer.sh kafka消费者控制台
    kafka-console-producer.sh kafka生产者控制台
    kafka-consumer-groups.sh  kafka消费者组相关信息
    kafka-consumer-perf-test.sh kafka消费者性能测试脚本
    kafka-delegation-tokens.sh  todo
    kafka-delete-records.sh 删除低水位的日志文件
    kafka-log-dirs.sh kafka消息日志目录信息
    kafka-mirror-maker.sh 不同数据中心kafka集群复制工具
    kafka-preferred-replica-election.sh 触发preferred replica选举
    kafka-producer-perf-test.sh kafka生产者性能测试脚本
    kafka-reassign-partitions.sh  分区重分配脚本
    kafka-replay-log-producer.sh  todo
    kafka-replica-verification.sh 复制进度验证脚本
    kafka-run-class.sh  todo
    kafka-server-start.sh 启动kafka服务
    kafka-server-stop.sh  停止kafka服务
    kafka-simple-consumer-shell.sh  deprecated，推荐使用kafka-console-consumer.sh
    kafka-streams-application-reset.sh  todo
    kafka-topics.sh topic管理脚本
    kafka-verifiable-consumer.sh  可检验的kafka消费者
    kafka-verifiable-producer.sh  可检验的kafka生产者
    trogdor.sh  todo
    zookeeper-security-migration.sh todo
    zookeeper-server-start.sh 启动zk服务
    zookeeper-server-stop.sh  停止zk服务
    zookeeper-shell.sh  zk客户端



kafka这些运维脚本，有些是指定参数--zookeeper，有些是指定参数--broker-list，有些是指定参数--bootstrap-server::

        这实际上是历史问题。
        broker-list代表broker地址，
        而bootstrap-server代表连接起点，可以从中拉取broker地址信息。bootstrap-server的命名更高级点
        还有通过zookeeper连接的，kafka早起很多信息存方在zk中，后期慢慢弱化了zk的作用
        这三个参数代表kafka的三个时代。
        往好的讲是见证kafka设计的理念变迁，往坏的讲：什么**玩意儿，绕的一笔（来自厮大大的解答），哈。




