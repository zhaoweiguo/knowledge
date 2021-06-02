.. _webbench:

webbench的使用
================

简介::

    webbench是Linux下的一个网站压力测试工具，最多可以模拟3万个并发连接去测试网站的负载能力


安装::

    tar zxvf webbench-<version>.tar.gz
    cd webbench-<version>
    make && make install

用法::

    webbench -c 并发数 -t 运行时间 <URL>

实例::

    webbench -c 5000 -t 120 http://bbs.programfan.info




