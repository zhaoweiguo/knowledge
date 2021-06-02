.. _redis_usage:

用法
####

服务端
======

启动服务端::

    redis-server /path/to/redis.conf

关闭服务端::

    ./redis-cli -p 10379 shutdown

客户端
======

启动客户端, 用redis-cli启动它的自带客户端::

    Usage: redis-cli [OPTIONS] [cmd [arg [arg ...]]]
      -h <hostname>    Server hostname (default: 127.0.0.1)
      -p <port>        Server port (default: 6379)
      -s <socket>      Server socket (overrides hostname and port)
      -a <password>    Password to use when connecting to the server
      -r <repeat>      Execute specified command N times
      -n <db>          Database number
      -x               Read last argument from STDIN
      -d <delimiter>   Multi-bulk delimiter in for raw formatting (default: \n)
      --raw            Use raw formatting for replies (default when STDOUT is not a tty)
      --help           Output this help and exit
      --version        Output version and exit

实例::

   cat /etc/passwd | redis-cli -x set mypasswd
   redis-cli get mypasswd    // 查看key为mypasswd的值
   redis-cli -r 100 lpush mylist x  // lpush mylist执行100次

进入redis客户端后::

    redis> help
    redis-cli 2.2.4
    Type: "help @<group>" to get a list of commands in <group>
          "help <command>" for help on <command>
          "help <tab>" to get a list of possible help topics
          "quit" to exit

其他
====

可执行文件::

    redis-server :Redis服务器的daemon启动程序
    redis-cli :Redis命令行操作工具。当然，你也可以用telnet根据其纯文本协议来操作
    redis-benchmark :Redis性能测试工具，测试Redis在你的系统及你的配置下的读写性能
    redis-check-dump :本地数据库检查
    redis-check-aof :更新日志检查

redis乱七八糟的东西::

  redis是用链表而不是数组实现的，所以它的读取速度相比会较慢
  还可以在命令行中用如: ./redis-cli rpush msgs "hello"



