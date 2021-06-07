Erlang接入远程shell控制台
###############################

Erlang Shell JCL作业（JCL ）模式 
''''''''''''''''''''''''''''''''''''''''''

Node_1 添加了-detached选项,启动之后直接在后台运行并没有启动Shell::

  erl -setcookie abc -name node_1@192.168.1.123 -detached 

Node_2 使用了和Node_1相同的cookie,启动之后进入Erlang Shell界面::

  erl -setcookie abc -name node_2@192.168.1.123

在Node_2结点::

  Eshell V5.9  (abort with ^G)
  (node_2@192.168.1.123)1> node().
  'node_2@192.168.1.123'
  (node_2@192.168.1.123)2>                %Ctrl + G 进入JCL模式
  User switch command
  --> h   // 帮助
  --> r 'node_1@127.0.0.1'
  --> j 
    1 {shell,start,[init]} 
    2* {'node_1@127.0.0.1',shell,start,[]} 
  --> c 2 


Remsh 模式
'''''''''''''''''''''
说明::

  -remsh Node
  Starts Erlang with a remote shell connected to Node.

使用::

  // 启动节点2，将直接接入节点1控制台
  # erl -name 2@127.0.0.1 -setcookie 123456 -remsh 1@127.0.0.1
  % 底层的运作机 制和使用 JCL 模式时完全一样，不过初始 shell 是远程而非本地启动的(JCL 还是本地的)。 
  % ^G 仍然是最安全的退出远程 shell 的方法


SSH Daemon模式
'''''''''''''''''''
erlang自带了SSH的功能，我们可以很方便的开启SSH服务，对外提供远程 shell服务.SSH的使用需要开启crypto

::

  $ makdir /tmp/ssh
  $ ssh-keygen -t rsa -f /tmp/ssh/ssh_host_rsa_key
  $ ssh-keygen -t rsa1 -f /tmp/ssh/ssh_host_key
  $ ssh-keygen -t dsa -f /tmp/ssh/ssh_host_dsa_key
  $ erl

  (1@127.0.0.1)1> ssh:start().
  ok
  (1@127.0.0.1)2> ssh:daemon(8888, [{password, "12345"}, 
                                    {system_dir, "/tmp/ssh"},
                                    {user_dir, "/home/ferd/.ssh"} ]).
  {ok,<0.57.0>}

使用端::

  # ssh -p 8888 1@127.0.0.1


管道（pipe）模式
'''''''''''''''''''''''''

这种方法很少用，每次输出时都调用fsync，如果输出过多时，会有很大的性能损失::

  $> run_erl -daemon /tmp/erl_pipe /tmp/erl_log "erl -name 1@127.0.0.1 -setcookie 123456"
  % daemon 表示以后台进程运行
  % /tmp/erl_pipe是管道文件的名称
  % /tmp/erl_log指定了日志保存文件夹

  % run_erl会在/tmp/erl_pipe下创建erlang.pipe.1.r erlang.pipe.1.w两个管道文件
  % 外部系统可通过该管道文件向节点写入/读取数据

然后使用 to_erl 程序来连接节点::

  $> to_erl /tmp/erl_pipe

  % 需要注意的当前你是直接通过Unix管道和节点交互的，并不存在中间代理节点(和remsh方式不同)
  % 因此在这种情况下使用JCL ^G+q会终止目标节点。如果要退出attach模式而不影响目标节点，使用^D
  % run_erl另一个作用是输出重定向
  % 上例中将所有输出(包括虚拟机和nif输出)重定向到/tmp/erl_log/erlang.log.*
  % 这对多日志渠道(lager,io:format,c,lua等)的混合调试是有所帮助的

  % PS:rebar2便通过run_erl实现节点启动，并使用to_erl实现attach命令








erl_call模式
''''''''''''''''''''
::

  $>/usr/local/lib/erlang/lib/erl_interface-3.7.6/bin/erl_call -s -a 'erlang memory ' -name node_1@192.168.1.123 -c abc

  $>/usr/local/lib/erlang/lib/erl_interface-3.7.6/bin/erl_call -e -name node_1@192.168.1.123 -c abc







