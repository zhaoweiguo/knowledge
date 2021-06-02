.. _tsung_introduce:

简单介绍
=========

历史背景::

    1. Tsung是由Nicolas Niclausse在2001年开发的分布式jabber负载压力测试工具。
       几个月后，开源并发展成多协议负载压力测试工具。
       2003年支持http协议，已经在多工业项目上被使用。
       现在归Erlang-projects所有，由process-one.net支持。
    3. jabber/XMPP协议：
        * 在4个tsung结点集群(3xSun V240 + 1 Sun V440)上可以跑90 000个同步用户
        * 在3个计算机集群上(CPU 800MHz)可以跑10 000同步用户   
    4. http/https协议：
        * 在4个计算机集群上跑12 000个同步用户，它的测试平台已经达到每秒3000个请求
        * 在75个计算机集群上跑100万个同步用户，支持每秒10万个请求

基本特性::

  1. High Performance高效的：一个单独的cpu可以模拟数以千计的用户(因为模拟用户不总是处于激活状态，它有可能在思考的闲置状态)
  2. Distributed分布式的：可以把负载分布到一系统客户端集群中
  3. Multi-Protocols using a plug-in system多协议支持(通过插件方式实现)：
     当前最新版本支持的协议插件有：HTTP , WebDAV, Jabber/XMPP, PostgreSQL,LDAP和MySQL
  4. SSL support
  5. 利用底层os ip别名技术，在单独的机器上使用多个ip地址
  6. 在远程服务器或snmp上，使用erlang代理对os进行监控，主要是监控它的cpu，内存，网络流量等
  7. xml配置系统：
  8. 动态场景：我们可以从负载的服务器得到动态数据并把它重新注入到随后的请求
     当字符串或正则式匹配服务请求，我们可以循环、重起或停止这个对话。


tsung本质::

    * {tsung,”tsung, a load testing tool for TCP/UDP servers”,”1.3.3″}
    * {tsung_controller,”tsung, a bench tool for TCP/UDP servers”,”1.3.3″}
    * {tsung_recorder,”tsung recorder”,”1.3.3″}

tsung优点::

    1. 高性能、分布式的测试：可以用tsung模拟成千上万的虚拟用户
    2. 易用：你不用写复杂的脚本，在所有支持的协议，这最复杂的部分已经完成。在动态场景中，你只需要修改很小的一部分代码
    3. 多协议支持：例如：tsung是唯一一个可以测试SOAP应用的工具。
    4. 监控目标服务器来分析行为和找到瓶颈：
       例如，它可以被用来分析集群的均衡，来决定在三个集群层(web引擎、ejb引擎、数据库)中机器的最佳分配方案。


依赖关系::

    1. erlang：这个就不用说了，tsung本身就是erlang的一个otp应用。
    2. 扩充的正则模块(用于动态变量):gregexp.erl需要被包含[EPL]。
    3. pgsql模块：用于 PostgreSQL插件[EPL]。
    4. mysql模块：用于mysql插件[BSD]。
    5. eldap模块：用于LDAP插件[GPL]。
    6. mochiweb库：用于路径解析；用于http插件的动态的变量[MIT]。
    7. gnuplot 和 perl5[可选]：用于tsung_stats.pl脚本图形输出，这个模块工具集用于html报告。
    8. python 和 mathplotlib[可选]：用于tsung-plotter的图像输出。
    9. 在分布式测试中，你还需要对远程机器的无密码ssh权限(用无密码口令的RSA/DSA键或ssh-agent)[注：rsh也需要支持]。
    10. bash


相关网站:

    * http://tsung.erlang-projects.org/
    * http://www.process-one.net/en/tsung/
    * https://git.process-one.net/tsung







