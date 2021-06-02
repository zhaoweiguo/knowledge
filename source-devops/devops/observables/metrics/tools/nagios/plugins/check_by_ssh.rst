.. _check_by_ssh:

check_by_ssh命令
==================

* 用法::

    check_by_ssh -H <host> -C <command> [-fqv] [-1|-2] [-4|-6]
       [-S [lines]] [-E [lines]] [-t timeout] [-i identity]
       [-l user] [-n name] [-s servicelist] [-O outputfile]
       [-p port] [-o ssh-option] [-F configfile]

* 选项::

    * -h, --help
    * -V, --version
    * -H, --hostname=ADDRESS 主机名、IP地址
    * -p, --port=INTEGER    端口 (default: none)
    * -4, --use-ipv4        使用ip4
    * -6, --use-ipv6        使用ip6
    * -1, --proto1    tell ssh to use Protocol 1 [optional]
    * -2, --proto2    tell ssh to use Protocol 2 [optional]
    * -S, --skip-stdout[=n]    Ignore all or (if specified) first n lines on STDOUT [optional]
    * -E, --skip-stderr[=n]    Ignore all or (if specified) first n lines on STDERR [optional]
    * -f    tells ssh to fork rather than create a tty [optional]. This will always return OK if ssh is executed
    * -C, --command='COMMAND STRING'    在远程服务器上要运行的命令
    * -l, --logname=USERNAME    SSH user name on remote host [optional]
    * -i, --identity=KEYFILE    identity of an authorized key [optional]
    * -O, --output=FILE    external command file for nagios [optional]
    * -s, --services=LIST    list of nagios service names, separated by ':' [optional]
    * -n, --name=NAME    short name of host in nagios configuration [optional]
    * -o, --ssh-option=OPTION    Call ssh with '-o OPTION' (may be used multiple times) [optional]
    * -F, --configfile    Tell ssh to use this configfile [optional]
    * -q, --quiet    Tell ssh to suppress warning and diagnostic messages [optional]
    * -w, --warning=DOUBLE    Response time to result in warning status (seconds)
    * -c, --critical=DOUBLE    Response time to result in critical status (seconds)
    * -t, --timeout=INTEGER    Seconds before connection times out (default: 10)
    * -v, --verbose    Show details for command-line debugging (Nagios may truncate output)

* 实例::

     $ check_by_ssh -H localhost -n lh -s c1:c2:c3 -C uptime -C uptime -C uptime -O /tmp/foo
     $ cat /tmp/foo
      [1080933700] PROCESS_SERVICE_CHECK_RESULT;flint;c1;0; up 2 days
      [1080933700] PROCESS_SERVICE_CHECK_RESULT;flint;c2;0; up 2 days
      [1080933700] PROCESS_SERVICE_CHECK_RESULT;flint;c3;0; up 2 days


* 前提:

* ssh免登录(nagios用户) (记得测试下)
* 把nagios插件里的可执行文件放到 ``/home/nagios/bin`` 下
* 把目录 ``/home/nagios/bin`` 加到PATH中(``~/.bashrc``)

