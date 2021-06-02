代理
#########

一、replace 方式来指定替换包的地址::

    module github.com/exercise
    require (
        golang.org/x/text v0.3.0
        gopkg.in/yaml.v2 v2.1.0 
    )

    replace (
        golang.org/x/text => github.com/golang/text v0.3.0
    )

二、goproxy.io [1]_ ::

    // For Linux
    export GOPROXY=https://goproxy.io
    // For windows
    $env:GOPROXY = "https://goproxy.io"

    注(默认值):
    GOPROXY=https://proxy.golang.org,direct


.. image:: /images/languages/golangs/goproxy1.png

Athens [2]_

三、Idea设置:

.. image:: /images/emacs/idea_golang_proxy.png


proxy.golang.org [3]_
======================

* Go Module Mirror, Index, and Checksum Database
* Go 1.13默认使用 ``Go module mirror`` and ``Go checksum database`` 下载和认证模块
* Go 1.13默认: GOPROXY=https://proxy.golang.org
* 不使用: GOPROXY=direct

Services
========

* https://proxy.golang.org
* https://sum.golang.org
* https://index.golang.org
* https://index.golang.org/index
* https://index.golang.org/index?since=2019-04-10T19:08:52.997264Z
* https://index.golang.org/index?limit=10

Checksum database
=================

gosumcheck::

    // Go1.13之前,手工检查go.sum文件与checksum数据库的对比
    go get golang.org/x/mod/gosumcheck
    gosumcheck /path/to/go.sum







.. [1] https://goproxy.io/
.. [2] https://docs.gomods.io/
.. [3] https://proxy.golang.org/