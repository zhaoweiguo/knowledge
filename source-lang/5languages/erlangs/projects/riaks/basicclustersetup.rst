###################
Basic Cluster Setup
###################

Riak Cluster需要配置一个结点来监听non-local接口，然后把其他的结点连接在一起。
首先编辑配置文件: ``etc/app.config`` 。如果你用源码编译，则app.config文件在 ``rel/riak/etc/`` ;如果你用二进制安装，则app.config文件在 ``/etc/riak/`` 。

**配置第一个结点(Configure the First Node)**

1. 首先确保Riak结点没有运行，可以用如下命令::

    $ bin/riak stop

2. 修改文件 ``etc/app.config`` ，由::

    {http, [ {"127.0.0.1", 8098 } ]},

改为::

    {http, [ {"192.168.1.10", 8098 } ]},

3. 修改文件 ``etc/vm.args`` ，由::

    -name riak@127.0.0.1

改为::

    -name riak@192.168.1.10

4. 启动::

    $ bin/riak start

如果你之前已经启动着Riak，可以用如下命令修改IP::

    $ bin/riak-admin reip riak@127.0.0.1 riak@192.168.1.10


**为你的cluster增加第二个结点(Add a Second Node to Your Cluster)**

1. 按照如上命令再启动一个Riak结点('riak@192.168.1.11')，再用如下命令把新启动的Riak结点加入到Riak Cluster中::

    $ bin/riak-admin join riak@192.168.1.10

2. 现在你第二个Riak结点就成为cluster的一部分，并开始和第一个结点进行同步。有如下两种方式可以察看是否成功配置:
    * 用riak-admin::

        $ bin/riak-admin status | grep ring_members
        #ring_members : ['riak@192.168.1.10','riak@192.168.1.11']

    * 用riak attach::

        $ riak attach
        1> {ok, R} = riak_core_ring_manager:get_my_ring().
        {ok,{chstate,'riak@192.168.1.10',.........
        (riak@192.168.52.129)2> riak_core_ring:all_members(R).
        ['riak@192.168.1.10','riak@192.168.1.11']

3. 你可以重复以上操作往你的cluster中增加node.


**在一台主机上运行多个结点(Running Multiple Nodes on One Host)**

如果你是用源码安装，就可以很容易的在一台机器上运行多个Riak结点。如果你是用 ``.deb`` 或 ``.rpm`` 文件安装，需要首先用源码安装并按如下命令进行操作:

1. 首先确保你使用 ``make all rel`` 命令，然后，在riak根目录中找到 ``./rel/riak`` 目录。
2. 把目录 ``./rel/riak`` 拷贝多份(你想要几个结点就拷贝几份)，如 ``./rel/riak1`` , ``./rel/riak2``... ...
3. 修改 ``./riakN/app.config`` 文件，修改在 ``http{}`` 段中 ``handoff_port, pb_port, the port`` 中的值(注意端口确保唯一)。
4. 修改 ``riakN/etc/vm.args`` 文件，如把 ``-name riak127.0.0.1@`` 修改为 ``riak1127.0.0.1@``
5. 启动结点::

    ./rel/riak1/bin/riak start
    ./rel/riak2/bin/riak start
    ./rel/riak3/bin/riak start

6. 把结点加入到cluster中::
    ./rel/riak2/bin/riak-admin join riak1@127.0.0.1
    ./rel/riak3/bin/riak-admin join riak1@127.0.0.1

注:你还可以用如下方法来进行操作:
1.首先，运行::

    make all devrel

如上命令会在Riak中创建: ``./dev/dev1, ./dev/dev2, ./dev/dev3``,直接就可以在一台机器上运行多个结点,这儿的端口分别是8091, 8092, 8093.
