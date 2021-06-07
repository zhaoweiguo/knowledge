Kafka Broker 配置文件
########################

collect::

    broker.id: int类型
    log.dirs: 日志目录,默认:/tmp/kafka-logs 
    zookeeper.connect: 以格式->hostname1:port1,hostname2:port2/chroot/path
    port: 服务端口号,默认9092
    listeners: 监听列表,以「,」分隔,如:
        PLAINTEXT://myhost:9092,SSL://:9091 
        CLIENT://0.0.0.0:9092,REPLICATION://localhost:9093
    num.partitions: 每个topic默认log partitions数,默认值为1

    num.network.threads: 服务用于接收请求和向网络发送请求的线程数,默认为3
    num.io.threads: 服务用于处理请求的线程数,包括disk io

    socket.send.buffer.bytes: socketServer SO_SNDBUF buffer,默认为:102400(-1:使用OS的值)
    socket.receive.buffer.bytes: SO_RCVBUF的值,默认为:102400
    socket.request.max.bytes: socket请求的最大bytes,默认为104857600

    cleanup.policy: [compact, delete],默认值为delete
    retention.bytes:
    retention.ms:
    delete.retention.ms:

    delete.topic.enable: 如关闭,使用admin tool删除topic将不起作用

  








