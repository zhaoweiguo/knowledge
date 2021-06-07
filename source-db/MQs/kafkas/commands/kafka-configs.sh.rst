kafka-configs.sh
################

配置管理脚本，这个脚本主要分两类用法：describe和alter。


参数解析::

    --zookeeper <String: urls>  REQUIRED: The connection string for the zookeeper
                                  connection in the form host:port. Multiple URLS
                                  can be given to allow fail-over.
    --describe                  List configs for the given entity.
    --alter                     Alter the configuration for the entity.
    --entity-default            Default entity name for clients/users (applies to
                                  corresponding entity type in command line)
    --entity-name <String>      Name of entity (topic name/client id/user principal
                                  name/broker id)
    --entity-type <String>      Type of entity (topics/clients/users/brokers)
    --bootstrap-server <String: server>   The Kafka server to connect to. This
                                             is required for describing and
                                             altering broker configs.
    --command-config <String:command>      Property file containing configs to be
                                             passed to Admin Client. This is used
                                             only with --bootstrap-server option
                                             for describing and altering broker
                                             configs.
    --add-config <String>                  Key Value pairs of configs to add.
    --delete-config <String>    config keys to remove 'k1,k2'
    --force                     Suppress console prompts


增加配置项::

    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type topics\
       --entity-name topicName  --add-config 'k1=v1, k2=v2, k3=v3' 

    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type clients\
       --entity-default --add-config 'k1=v1, k2=v2, k3=v3' 

    实例:
    1. 某个topic配置对象:
    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type topics \
        --entity-name topicName  --add-config 'max.message.bytes=50000000, flush.messages=50000, flush.ms=5000'

    2. 所有clientId的配置对象
    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type topics \
        --entity-name topicName  --add-config 'max.message.bytes=50000000' --add-config 'flush.messages=50000'

删除配置项::

    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type topics \
        --entity-name topicName --delete-config ‘k1,k2,k3’

    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type clients \
        --entity-name clientId --delete-config ‘k1,k2,k3’

    bin/kafka-configs.sh --bootstrap-server localhost:9092 --alter --entity-type brokers \
        --entity-name $brokerId --delete-config ‘k1,k2,k3’

    bin/kafka-configs.sh --bootstrap-server localhost:9092 --alter --entity-type brokers \
        --entity-default --delete-config ‘k1,k2,k3’

    例子:
    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --alter --entity-type topics \
        --entity-name test-topic --delete-config 'segment.bytes'

    #localhost:2182是zookeeper的ip和端口，__consumer_offsets是要查询的topics:
    ./bin/kafka-configs.sh --zookeeper localhost:2182 --entity-type topics \
        --entity-name __consumer_offsets --alter --delete-config cleanup.policy

    ./bin/kafka-configs.sh --zookeeper localhost:2182  --entity-type topics \
        --entity-name __consumer_offsets --alter --delete-config cleanup.policy=delete

修改配置项::

    修改配置项与增加语法格式相同，相同参数后端直接覆盖
    
    % 更改代理ID为0的当前代理配置(日志清理程序的线程数)
    > bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers --entity-name 0 --alter --add-config log.cleaner.threads=2
    % 查看 
    > bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers --entity-name 0 --describe

    % 删除
    > bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers --entity-name 0 --alter --delete-config log.cleaner.threads

    % 更新所有brokder的日志清理程序的线程数
    > bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers --entity-default --alter --add-config log.cleaner.threads=2
    % 查看
    > bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers --entity-default --describe

列出entity配置描述::

    bin/kafka-configs.sh --zookeeper localhost:2181/kafkacluster --entity-type topics \
        --entity-name topicName --describe

    bin/kafka-configs.sh--bootstrap-server localhost:9092 --entity-type brokers \
        --entity-name $brokerId --describe

    bin/kafka-configs.sh --bootstrap-server localhost:9092 --entity-type brokers \
        --entity-default --describe

    bin/kafka-configs.sh  --zookeeper localhost:2181/kafkacluster --entity-type users \
        --entity-name user1 --entity-type clients --entity-name clientA --describe

    查看每个topic的配置:
    bin/kafka-configs.sh --zookeeper localhost:2181 --describe --entity-type topics

    查看broker的配置:
    bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --entity-type brokers --entity-name 0



Updating Password Configs Dynamically::

  // Updating Password Configs in ZooKeeper Before Starting Brokers
  > bin/kafka-configs.sh --zookeeper localhost:2181 --entity-type brokers --entity-name 0 --alter 
    --add-config 'listener.name.internal.ssl.key.password=key-password,password.encoder.secret=secret,password.encoder.iterations=8192'







