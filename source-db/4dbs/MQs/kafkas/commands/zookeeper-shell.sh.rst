zookeeper-shell.sh
##################

用法::

    bin/zookeeper-shell.sh localhost:2181[/path]
    如果kafka集群的zk配置了chroot路径，那么需要加上/path，例如:
    bin/zookeeper-shell.sh localhost:2181/mykafka
    登陆zk后，就可以查看kafka写在zk上的节点信息

查看有哪些broker，以及broker的详细信息::

    ls /brokers/ids
    [0]
    get /brokers/ids/0
    {"listener_security_protocol_map":{"PLAINTEXT":"PLAINTEXT"},"endpoints":["PLAINTEXT://izwz91rhzhed2c54e6yx87z:9092"],"jmx_port":-1,"host":"izwz91rhzhed2c54e6yx87z","timestamp":"1530435834272","port":9092,"version":4}
    cZxid = 0x2d3
    ctime = Sun Jul 01 17:03:54 CST 2018
    mZxid = 0x2d3
    mtime = Sun Jul 01 17:03:54 CST 2018
    pZxid = 0x2d3
    cversion = 0
    dataVersion = 0
    aclVersion = 0
    ephemeralOwner = 0x1642cb09421006c
    dataLength = 216
    numChildren = 0



