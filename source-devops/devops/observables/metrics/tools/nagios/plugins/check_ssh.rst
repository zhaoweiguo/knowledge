.. _check_ssh:

check_ssh命令
==============

* 用法::

    check_ssh [-46] [-t <timeout>] [-r <remote version>] [-p <port>] <host>

* 选项::

    * -h, --help  打印帮助信息
    * -V, --version  打印版本信息
    * -H, --hostname=ADDRESS  主机名、IP地址
    * -p, --port=INTEGER  端口号、默认为22
    * -4, --use-ipv4  使用ip4
    * -6, --use-ipv6  使用ip6
    * -t, --timeout=INTEGER  连接超时时间、单位是秒(默认是10s)
    * -r, --remote-version=STRING   当字符串和期待的服务版本不匹配时会警告(例: OpenSSH_3.9p1)
    * -v, --verbose \  Show details for command-line debugging (Nagios may truncate output)

