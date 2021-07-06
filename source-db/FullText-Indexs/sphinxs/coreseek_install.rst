.. _coreseek_install:

coreseek安装
=============

.. _coreseek_install_before:

coreseek的安装准备条件
------------------------

    * 安装 ``coreseek/mmseg`` 需要安装的软件列表:

        * centos::

            yum install make gcc g++ gcc-c++ libtool autoconf automake 
                        imake mysql-devel libxml2-devel expat-devel

        * ubuntu::

            apt-get install make gcc g++ automake libtool mysql-client 
                       libmysqlclient15-dev libxml2-dev libexpat1-dev

    * 依赖环境建议版本:

        * m4 >= 1.4.13
        * autoconf >= 2.65
        * automake >= 1.11
        * libtool >= 2.2.6b

    注: 如果版本不满足的话,请下载源文件,按标准方法编译即::

        ./configure --prefix=/usr/local
        make && make install

.. _coreseek_install_simple:

快速安装步骤(不支持mysql)
--------------------------

    * 下载coreseek::

        wget http://www.coreseek.cn/uploads/csft/3.2/coreseek-3.2.14.tar.gz
        或
        wget http://www.coreseek.cn/uploads/csft/4.0/coreseek-4.0.1-beta.tar.gz
        ... ...
        tar xzvf coreseek-3.2.14.tar.gz
        cd coreseek-3.2.14

    * 安装mmseg::

        cd mmseg-3.2.14
        ./bootstrap    #输出的warning信息可以忽略，如果出现error则需要解决
        ./configure --prefix=/usr/local/mmseg3
        make && make install
        cd ..

    * 安装coreseek::

        cd csft-3.2.14
        sh buildconf.sh    #输出的warning信息可以忽略，如果出现error则需要解决
        ./configure --prefix=/usr/local/coreseek  --without-unixodbc 
                    --with-mmseg --with-mmseg-includes=/usr/local/mmseg3/include/mmseg/ 
                    --with-mmseg-libs=/usr/local/mmseg3/lib/ --with-mysql
        make && make install
        cd ..

**测试mmseg分词与coreseek搜索**

    * 测试mmseg分词，coreseek搜索(需要预先设置好字符集为zh_CN.UTF-8，确保正确显示中文)::

        cd testpack
        cat var/test/test.xml    #此时应该正确显示中文
        /usr/local/mmseg3/bin/mmseg -d /usr/local/mmseg3/etc var/test/test.xml
        /usr/local/coreseek/bin/indexer -c etc/csft.conf --all
        /usr/local/coreseek/bin/search -c etc/csft.conf 网络搜索



.. _coreseek_install_mysql:

coreseek mysql数据源支持
--------------------------

**要想支持mysql,需要安装相关的基础依赖库**

* 各操作系统对安装命令:

    * centos5.4/5.5: fedora12/13: rhel5.5::

        yum install mysql-devel libxml2-devel expat-devel

    * debian5: ubuntu9/10::

        apt-get install mysql-client libmysqlclient15-dev libxml2-dev libexpat1-dev

**重新编译安装coreseek，以支持mysql数据源和xml数据源**

* 命令::

    $ cd csft-3.2.14
    $ make clean
    $ ./configure --prefix=/usr/local/coreseek  --without-unixodbc --with-mmseg 
      --with-mmseg-includes=/usr/local/mmseg3/include/mmseg/ 
      --with-mmseg-libs=/usr/local/mmseg3/lib/ --with-mysql
    ##以上configure参数请正确拷贝，不要遗漏或者随意修改
    $ make && make install

* 错误处理:
    * 错误提示::

        “ERROR: cannot find MySQL include files.......To disable MySQL support, use --without-mysql option.“

    * 处理方法:

        * 请找到头文件 ``mysql.h`` 所在的目录，一般是 ``/usr/local/mysql/include`` ，请替换为实际的
        * 请找到库文件 ``libmysqlclient.a`` 所在的目录，一般是 ``/usr/local/mysql/lib`` ，请替换为实际的
        * configure参数加上: ``--with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib`` ,执行后,重新编译安装

