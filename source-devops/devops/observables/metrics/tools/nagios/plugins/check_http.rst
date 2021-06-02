.. _check_http:

check_http命令
#########################

* 用法::

    Usage: check_http -H <vhost> | -I <IP-address> [-u <uri>] [-p <port>]
       [-w <warn time>] [-c <critical time>] [-t <timeout>] [-L]
       [-a auth] [-f <ok | warn | critcal | follow>] [-e <expect>]
       [-s string] [-l] [-r <regex> | -R <case-insensitive regex>] [-P string]
       [-m <min_pg_size>:<max_pg_size>] [-4|-6] [-N] [-M <age>] [-A string]
       [-k string] [-S] [-C <age>] [-T <content-type>]

* 选项::

    -H: 指定域名
    -I: 指定ip地址
    -p: 端口
    ... ...


* 注意事項::

    注意这儿和web服务器相关, 只有能通过curl访问, 才能使用 ``check_http`` 访问。




