常见问题
########

Version2与3的区别
=================

主要原因::

    Docker swarm happened. 
    The new version of docker-compose files were adjusted, to work with it.

区别::

    docker-compose, was added to Docker itself.
    The way handling volumes and networks was changed for the better

v2实例::

    version: "2.4"
    services:
      foo:
        image: busybox
        blkio_config:
          weight: 300
          weight_device:
            - path: /dev/sda
              weight: 400
          device_read_bps:
            - path: /dev/sdb
              rate: '12mb'
          device_read_iops:
            - path: /dev/sdb
              rate: 120
          device_write_bps:
            - path: /dev/sdb
              rate: '1024k'
          device_write_iops:
            - path: /dev/sdb
              rate: 30

v3实例::

.. literalinclude:: ./example_v3.yml



相关参考
========

* Should I Upgrade My Docker Compose File Version From 2 to 3: https://vsupalov.com/upgrade-docker-compose-file-version/


