Docker版使用
############

最基本使用::

    $ docker run registry.cn-hangzhou.aliyuncs.com/opensources/influxdb

指定端口::

    $ docker run -p 8086:8086 registry.cn-hangzhou.aliyuncs.com/opensources/influxdb

完整命令::

    $ docker run -d -p 8083:8083 -p 8086:8086 --name influxdb \
    -v ./conf/influxdb.conf:/etc/influxdb/influxdb.conf \
    -v ./data:/var/lib/influxdb/data \
    -v ./meta:/var/lib/influxdb/meta \
    -v ./wal:/var/lib/influxdb/wal \
    registry.cn-hangzhou.aliyuncs.com/opensources/influxdb

    说明:
    8083端口为web管理端，默认不开启


