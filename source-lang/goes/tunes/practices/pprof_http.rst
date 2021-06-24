.. _pprof_http:

pprof在http服务的使用
#####################

使用前准备
==========

编译运行::

    $ go build -o pprof_http pprof_http.go
    $ ./pprof_http

模拟请求::

    $ wrk -c 400 -t 8 -d 3m http://localhost:9876/test



CPU 的占用分析使用
==================


打开 http://localhost:9876/debug/pprof:

.. image:: /images/languages/golangs/pprof_http2.png


::

    $ wget http://localhost:9876/debug/pprof/profile
    $ go tool pprof pprof_http profile
    (pprof) top 5
    Showing nodes accounting for 4.93mins, 97.46% of 5.06mins total
    Dropped 180 nodes (cum <= 0.03mins)
    Showing top 5 nodes out of 42
          flat  flat%   sum%        cum   cum%
      4.64mins 91.69% 91.69%   4.64mins 91.69%  main.doSomeThingOne
      0.11mins  2.16% 93.85%   0.11mins  2.16%  runtime.usleep
      0.09mins  1.83% 95.68%   0.09mins  1.84%  runtime.newstack
      0.08mins  1.52% 97.19%   0.08mins  1.52%  runtime.pthread_cond_signal
      0.01mins  0.27% 97.46%   0.14mins  2.68%  math/rand.(*Rand).Int31n
    (pprof) web   // 打开本篇最后的效果图

内存快照的占用分析
==================

::

    $ wget http://localhost:9876/debug/pprof/heap
    $ go tool pprof pprof_http heap
    (pprof)


源码
====

.. literalinclude:: /files/golangs/pprof_http.go

效果图
======

.. image:: /images/languages/golangs/pprof_http.svg


参考
====

* `caibirdme/hand-to-hand-optimize-go <https://github.com/caibirdme/hand-to-hand-optimize-go>`_





