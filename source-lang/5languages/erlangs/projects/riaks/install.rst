############
Installation
############

`Installation <http://wiki.basho.com/Installation.html>`_

**Installing on Debian and Ubuntu**
    * 64-bit::

        $ wget http://downloads.basho.com/riak/riak-1.0.2/riak_1.0.2-1_amd64.deb
        $ sudo dpkg -i riak_1.0.2-1_amd64.deb

    * 32-bit::

        $ wget http://downloads.basho.com/riak/riak-1.0.2/riak_1.0.2-1_i386.deb
        $ sudo dpkg -i riak_1.0.2-1_i386.deb


**Installing from source**
    1. dependency::

       $ sudo apt-get install build-essential libc6-dev-i386

    2. download and install Riak::

        $ wget http://downloads.basho.com/riak/riak-1.0.2/riak-1.0.2.tar.gz
        $ tar zxvf riak-1.0.2.tar.gz
        $ cd riak-1.0.2
        $ make rel


**Installing from GitHub**
    code::

    $ git clone git://github.com/basho/riak.git
    $ cd riak
    $ make rel

**启动(Starting up)**
    command::

        $ riak start
        $ riak console
        $ riak ping

**测试(testing)**
如果你在本地有Riak在运行，可以用如下命令来测试::

    $ curl -v http://127.0.0.1:8098/riak/test

