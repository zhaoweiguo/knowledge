erl
######

The Erlang emulator

Flags
'''''''
简单实例::

  % erl +W w -sname arnie +R 9 -s my_init -extra +bertie
  (arnie@host)1> init:get_argument(sname).
  {ok,[["arnie"]]}
  (arnie@host)2> init:get_plain_arguments().
  ["+bertie"]


  % erl -myflag 1
  1> init:get_argument(myflag).
  {ok,[["1"]]}
  2> init:get_plain_arguments().
  []


emulator flags::

  如: +W w and +R 9
  -instr (emulator flag)
  -version (emulator flag)
  +a size
  +A size: 设置异步线程的线程数(0-1024). default:1
      查看: erlang:system_info(thread_pool_size)
  +B [c | d | i]
  【重要】+P Number: 设置此系统最大同时存在的进程数(1024-134217727)default:262144
      查看: erlang:system_info(process_limit)
  +Q Number: 设置此系统最大同时存在的port(1024-134217727). default:65536

  +K [true | false]
      是否开启kernel poll，就是epoll
  +sFlag Value
  +t size: 设定虚拟机能处理的最大atoms. default:1,048,576
  +zFlag Value
    +zdbbl size:  设定distribution buffer busy限制(1-2097151).default:1024.
    +zdntgc time:





  
init flag::

  如:  -s my_init
  -extra (init flag)
  -run Mod [Func [Arg1, Arg2, ...]] (init flag)
  -s Mod [Func [Arg1, Arg2, ...]] (init flag)


  
user flag::

  如:  -sname arnie
  -Application Par Val: 应用参数
  -args_file FileName
  -boot File: 指定boot文件名:File.boot
    默认使用<ERL_INSTALL_DIR>/bin/start.boot
    Specifies the name of the boot script, File.boot, which is used to start the system. See init(3). 
    Unless File contains an absolute path, the system searches for File.boot in the current and <ERL_INSTALL_DIR>/bin directories . 

  -boot_var Var Dir
    If the boot script used contains another path variable than $ROOT,
      this variable must have a value assigned in order to start the system.
    A boot variable is used if user applications have been installed 
      in another location than underneath the <ERL_INSTALL_DIR>/lib directory. 
    $Var is expanded to Directory in the boot script. 
    例:
      -boot_var ERTS_LIB_DIR /home/support/emqttd/erts-9.0/../lib
    % @待确认
      指定一个变量Var的路径为Dir，主要用于systools:make_script的:
        {variables, [{“Var”, “Prefix”}]},
      因为默认的script路径都是在$ROOT/lib下寻找，当在make_script中加入variables选项时

  -config Config: 指定配置文件名Config.config,此配置文件用户配置applications
  -detached: 启动Erlang runtime system detached(主要用于daemons and backgrounds进程)
  -env Variable Value:设定os环境变量
  -heart
  -hidden
  -mode interactive | embedded
  -name Name
  -noinput
  -noshell
  -pa Dir1 Dir2 ...
  -pz Dir1 Dir2 ...
  -remsh Node: remote shell 
  -rsh Program
    -rsh ssh

  -setcookie Cookie
  -sname Name











  
plain arguments::

  如: -extra xxx xxx ...










