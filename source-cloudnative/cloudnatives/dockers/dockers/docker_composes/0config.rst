配置实例
########

::

    version: '3'
    services:
      web:
        build: .
        ports:
        - "5000:5000"
        volumes:
        - .:/code
        - logvolume01:/var/log
        links:
        - redis
      redis:
        image: redis
    volumes:
      logvolume01: {}

drone实例
=========

.. literalinclude:: /files/dockers/drone.composer.yml

etcd集群
========

.. literalinclude:: /files/dockers/etcd.composer.yml







