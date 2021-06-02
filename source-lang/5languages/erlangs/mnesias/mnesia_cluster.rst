.. _mnesia_cluster:

从头建立mnesia集群
''''''''''''''''''''''''''

启动3个erlang节点并ping通::

    erl -name a@host1 -setcookie abc
    erl -name b@host1 -setcookie abc

    (a@host1)1> net_adm:ping('b@host1').
    pong

创建schema::

    (a@host1)3> NL = [node()|nodes()].   
    [a@host1,b@host1]
    (a@host1)4> mnesia:create_schema(NL).
    ok
    注: 这个时候在文件浏览器中可以看到，3个数据库的文件夹都出现了。

    启动3个节点上的mnesia数据库:
    (a@host1)5> mnesia:start().
    ok
    (b@host1)1> mnesia:start().
    ok

    查看一下数据库是不是都启动了:
    (a@host1)6> mnesia:system_info(running_db_nodes).
    [a@host1]

建表::

    先创建一个record，作为表结构使用:
    (a@host1)7> rd(<table>, {key, value}).
    <table>

    建表的属性参数设置:
    (a@host1)9> TablePropList = [{attributes, record_info(fields, <table>)}].
    [{attributes,[key,value]}]

    建表:
    (a@host1)10> mnesia:create_table(<table>,TablePropList).
    {atomic,ok}
    (a@host1)12> mnesia:info().
    ......
    running db nodes   = [b@host1,a@host1]
    stopped db nodes   = [] 
    master node tables = []
    remote             = []
    ram_copies         = [<table>]
    disc_copies        = [schema]
    disc_only_copies   = []
    [{a@host1,disc_copies},
     {b@host1,disc_copies}] = [schema]
    [{a@host1,ram_copies}] = [<table>]
    ......

往表里插入1000条数据::

    (a@host1)17> Write = fun(Keys) -> [mnesia:write({dictionary,K,K}) || K <- Keys], ok end.
    #Fun<erl_eval.6.13229925>
    (a@host1)18> mnesia:activity(sync_dirty, Write, [lists:seq(1, 1000)], mnesia_frag).
    ok

修改表的属性::

    // 把dictionary表在a节点的存储方式改成disc_copies:
    (a@host1)23> mnesia:change_table_copy_type(dictionary, node(), disc_copies).
    {atomic,ok}
    (a@host1)24> mnesia:info().
    ......
    [{a@host1,disc_copies}] = [dictionary]
    ......

在现在mnesia集群中增加1个结点
''''''''''''''''''''''''''''''
启动一个新结点,并启动mnesia,ping通网络::

    erl -name d@host1 -setcookie abc
    (d@host1)1> mnesia:start().
    ok
    (a@host1)48> net_adm:ping('d@host1').
    pong

添加mnesia节点::

    (a@host1)49> mnesia:change_config(extra_db_nodes, [d@host1]).
    {ok,[d@host1]}

查看mnesia集群属性::

    (a@host1)50> mnesia:info().
    .... ....
    [{a@host1,disc_copies},
     {b@host1,disc_copies},
     {d@host1,ram_copies}] = [schema]
     [{a@host1,disc_copies}] = [dictionary]
     .... ....

在d上再备份一下a节点的数据::

    (a@host1)52> mnesia:add_table_copy(<table>, 'd@host1', ram_copies). 
    {atomic,ok}

    方案1:
    在d节点改一下dictionary的备份属性:
    (d@host1)4> mnesia:change_table_copy_type(<table>, node(), disc_copies).
    {atomic,ok}

    方案2:
    拷贝创建本schema
    mnesia:change_table_copy_type(schema, node(), disc_copies).
    Tables = [<table>].
    [mnesia:add_table_copy(T, node(), ram_copies)||T<-L].

其他  
''''''''''


激活表格的分片::

    (a@host1)25> mnesia:change_table_frag(dictionary, {activate, []}).          
    {atomic,ok}

查看分辨是否激活了::

    (a@host1)26> mnesia:table_info(dictionary, frag_properties).                
    [{base_table,dictionary},
     {foreign_key,undefined},
     {hash_module,mnesia_frag_hash},
     {hash_state,{hash_state,1,1,0,phash2}},
     {n_fragments,1},
     {node_pool,[a@localhost,b@localhost,c@localhost]}]

创建一个函数，这个函数的作用是获得表的frag_dist::

    (a@host1)28> GetTableInfo = fun(Item) -> mnesia:table_info(dictionary, Item) end. 
    #Fun<erl_eval.6.35866844> 
    (a@host1)29> GetFragNodes = fun()-> mnesia:activity(sync_dirty, GetTableInfo, [frag_dist], mnesia_frag) end.
    #Fun<erl_eval.20.67289768>

测试一下::

    (a@host1)30> GetFragNodes().                                                
    [{b@host1,0},{{a@host1,1}]

添加一个分片了，通过GetFragNodes返回的节点列表，mnesia可以负载均衡的把新的分片添加到相对空闲的节点上::

    (a@localhost)35> mnesia:change_table_frag(dictionary, {add_frag, GetFragNodes()}).
    {atomic,ok}
    (a@localhost)36> mnesia:table_info(dictionary, frag_properties).                
    [{base_table,dictionary},
     {foreign_key,undefined},
     {hash_module,mnesia_frag_hash},
     {hash_state,{hash_state,2,1,1,phash2}},
     {n_fragments,2},
     {node_pool,[a@localhost,b@localhost,c@localhost]}
    ]

  看到了 {n_fragments,2}，增加到2个了

新的分片分派到哪个节点了::

    (a@localhost)37> GetFragNodes().                                                
    [{c@localhost,0},{a@localhost,1},{b@localhost,1}]

节点数据备份:

    * 给a节点的dictionary表增加一个备份节点(选择在c节点)::

        (a@localhost)40> mnesia:add_table_copy(dictionary, 'c@localhost', disc_copies).
        {atomic,ok}

    * 我们再插入1000条数据，看看c节点是不是和a节点同时插入数据::

        (a@localhost)43> mnesia:activity(sync_dirty, Write, [lists:seq(1001, 2000)], mnesia_frag).                      
        ok

    結果:在c结点上, dictionary表中dictionary分片保存了1014条,dictionary_frag2分片保存了0条(因为没有对b结点备份)

    * 在c节点备份b节点的dictionary_frag2这个分片的数据::

        (b@localhost)6> mnesia:add_table_copy(dictionary_frag2, 'c@localhost', disc_copies).
        {atomic,ok}

      結果:在c结点上, dictionary表中dictionary分片保存了1014条,dictionary_frag2分片保存了986条(对b结点备份了)

    * 看到n_disc_copies属性是2::

        (a@localhost)47> mnesia:activity(sync_dirty, GetTableInfo, [n_disc_copies], mnesia_frag).                       
        2


    * a节点的dictionary分片表在a、c、d上已经有了3份拷贝，现在，我们查一下dictionary的拷贝数量::

        (a@localhost)67> mnesia:activity(sync_dirty, GetTableInfo, [n_disc_copies], mnesia_frag).
        3

    * 去掉一个表的备份节点(把d节点的dictionary分片表的备份去掉)::

        (a@localhost)68> mnesia:del_table_copy(dictionary, 'd@localhost').
        {atomic,ok}
        (a@localhost)69> mnesia:activity(sync_dirty, GetTableInfo, [n_disc_copies], mnesia_frag).
        2
