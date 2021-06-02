常用Docker镜像
#####################

alpine::

    A minimal Docker image based on Alpine Linux 
        with a complete package index and only 5 MB in size!

scratch::

    这个镜像是虚拟的概念，并不实际存在，它表示一个空白的镜像。
    如果你以 scratch 为基础镜像的话，意味着你不以任何镜像为基础，接下来所写的指令将作为镜像第一层开始存在。
    不以任何系统为基础，直接将可执行文件复制进镜像的做法并不罕见，比如 swarm、coreos/etcd


语言 [1]_
=========

* r-base语言::

    $ docker pull r-base
    $ docker pull registry.cn-hangzhou.aliyuncs.com/langs/r-base

* java::

    openjdk:
    // OpenJDK is an open-source implementation of the Java Platform, Standard Edition
    $ docker pull openjdk

    maven:
    // Apache Maven is a software project management and comprehension tool.
    $ docker pull maven

* golang::
    
    $ docker pull golang
    $ docker pull golang:1.12-alpine
    $ docker pull registry.cn-hangzhou.aliyuncs.com/langs/golang:1.12-alpine

* node::
  
    $ docker pull node:6-alpine

操作系统
========

* `Ubuntu <https://hub.docker.com/_/ubuntu>`_::
  
    $ docker pull ubuntu:17.10

* `CentOS <https://hub.docker.com/_/centos>`_::
    
    $ docker pull centos
    $ docker pull centos:8
    $ docker pull centos:7


数据库
======

* 图数据库cayley::
  
    https://hub.docker.com/r/cayleygraph/cayley
    $ docker pull cayleygraph/cayley
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/cayley
    $ docker run --rm -p 64210:64210 cayleygraph/cayley 

* 图数据库dgraph::
  
    $ docker pull dgraph/dgraph
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/dgraph

* 时序数据库influxdb::
  
    $ docker pull influxdb
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/influxdb

* 文档数据库`mongoDB <https://hub.docker.com/_/mongo>`_::

    1. Simple Tags
    $ docker pull mongo:4.2.1-bionic
    
    2. Shared Tags
    $ docker pull mongo:4.2.1
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/mongo:4.2.1
    $ docker run --rm -p 27017:27017 mongo:4.2.1

* 关系数据库`mysql <https://hub.docker.com/_/mysql>`_::
    
    $ docker pull mysql:5
    $ docker pull mysql:5.7
    $ docker pull mysql:5.7.28
    $ docker pull mysql:8

* key/value数据库`redis <https://hub.docker.com/_/redis>`_::
    
    $ docker pull redis:5.0   # FROM debian:buster-slim
    $ docker pull redis:5.0-alpine
    

* `kafka <https://hub.docker.com/r/wurstmeister/kafka>`_::
  
    https://github.com/wurstmeister/kafka-docker
    $ docker pull wurstmeister/kafka
    $ docker pull wurstmeister/zookeeper
    composer

* `zookeeper <https://hub.docker.com/_/zookeeper>`_::

    $ docker pull zookeeper


工具
====

* 监控grafana::

    $ docker pull grafana/grafana:5.1.0
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/grafana:5.1.0

* 自动化部署jenkins::
  
    $ docker pull jenkins/jenkins
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/jenkins

* `nginx <https://hub.docker.com/_/nginx>`_::
  
    $ docker pull nginx     # FROM debian:buster-slim
    
    $ docker pull nginx:alpine
    $ docker pull registry.cn-hangzhou.aliyuncs.com/opensources/nginx:alpine







.. [1] https://hub.docker.com/search/?q=language&type=image