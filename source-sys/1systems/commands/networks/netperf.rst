netperf命令使用
=======================

Netperf是一种网络性能的测量工具，主要针对基于TCP或UDP的传输。Netperf根据应用的不同，可以进行不同模式的网络性能测试，即批量数据传输（bulk data transfer）模式和请求/应答（request/reponse）模式。Netperf测试结果所反映的是一个系统能够以多快的速度向另外一个系统发送数据，以及另外一个系统能够以多块的速度接收数据。

::

   netperf-H host -l testlen -t testname

netperf的命令行参数::

  -H host ：指定远端运行netserver的server IP地址
  -l testlen：指定测试的时间长度（秒）
  -t testname：指定进行的测试类型，包括TCP_STREAM，UDP_STREAM，TCP_RR，TCP_CRR，UDP_RR



