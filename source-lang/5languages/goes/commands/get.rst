.. _go_get:

go get命令
###############

usage::

    $ go get [-d] [-f] [-t] [-u] [-v] [-fix] [-insecure] [build flags] [packages]
    $ go help get

获取::

    go get github.com/spf13/cobra
    启用-v标记，可以看到下载的进度以及更多的调试信息

更新::

    go get -u github.com/spf13/cobra


默认::

    1. 更新指定packages A到最新版本，然后A的依赖B到A需要的指定版本（与-u标签不同点）
    Although get defaults to using the latest version of the module containing a named package, 
        it does not use the latest version of that module's dependencies. 
        Instead it prefers to use the specific dependency versions requested by that module. 

    For example, if the latest A requires module B v1.2.3, 
        while B v1.2.4 and v1.3.1 are also available, 
        then 'go get A' will use the latest A but then use B v1.2.3, as requested by A. 
    (If there are competing requirements for a particular module, 
        then 'go get' resolves those requirements by taking the maximum requested version.)

-d::

    -d标签: 下载build指定package所需的源码（包括依赖的源码）
    The -d flag instructs get to download the source code needed to build
    the named packages, including downloading necessary dependencies,
    but not to build and install them.

-u::

    -u标签: 更新指定packages A到最新版本，然后A的依赖B到最新的minor或patch release版本
    The -u flag instructs get to update modules providing dependencies of packages 
        named on the command line to use newer minor or patch releases when available. 

    For Example: Continuing the previous: 'go get -u A'
        will use the latest A with B v1.3.1 (not B v1.2.3). 
      If B requires module C, but C does not provide any packages needed 
        to build packages in A (not including tests), then C will not be updated.








