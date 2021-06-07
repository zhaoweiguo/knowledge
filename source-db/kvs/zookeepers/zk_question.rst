常见问题
#############


myid文件缺失导致zookeeper无法启动(myid file is missing)::

    现象: zookeeper无法启动
    异常: $dataDir/myid file is missing
    原因: zk集群中的节点需要获取myid文件内容来标识该节点，缺失则无法启动
    解决: 在zk数据文件存放目录下, 创建myid文件并写入一个数字用来标识本节点

    上面的数字与配置文件中的server.<n>对应
    server.0=10.140.2.21:2888:3888
    server.1=10.140.2.22:2888:3888
    server.2=10.140.2.12:2888:3888







