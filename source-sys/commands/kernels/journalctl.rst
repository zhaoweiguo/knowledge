journalctl命令
##############

.. note:: systemd 尝试提供一套集中化管理方案，从而统一打理全部内核及用户级进程的日志信息。这套系统能够收集并管理日志内容，而这也就是我们所熟知的 journal。



相关目录::

    /etc/systemd/journald.conf
    /var/log/journal


按信息类型过滤
==============

按单元::

    $ journalctl -u nginx.service
    $ journalctl -u nginx.service --since today
    $ journalctl -u nginx.service -u php-fpm.service --since today

按进程、用户或者群组 ID::

    $ journalctl _PID=8088
    $ journalctl _UID=33 --since today

    帮助:
    man systemd.journal-fields

    查看 systemd journal 拥有条目的群组 ID
    $ journalctl -F _GID

按组件路径::

    $ journalctl /usr/bin/bash

显示内核信息::

    $ journalctl -k
    $ journalctl -k -b -5

按优先级::

    $ journalctl -p err -b

    0: emerg
    1: alert
    2: crit
    3: err
    4: warning
    5: notice
    6: info
    7: debug




实战::


    // 查看最新的100行并继续跟踪查看
    $ journalctl --lines=100 --follow --unit bee

    // 早 9：00 到一小时前这段时间内的报告
    $ journalctl --since 09:00 --until "1 hour ago"


修改 journal 显示内容
=====================

截断或者扩大输出结果::

    截断输出内容，向其中插入省略号以代表被移除的信息:
    $ journalctl --no-full
    Feb 04 20:54:13 journalme sshd[937]: Failed password for root from 83.234.207.60...
    Feb 04 20:54:13 journalme sshd[937]: Connection closed by 83.234.207.60 [preauth]

    无论其是否包含不可输出的字符，显示全部信息:
    journalctl -a

标准输出结果::

    根据需要被重新定向至磁盘上的文件或者处理工具
    $ journalclt --no-pager

输出格式::

    $ journalctl -b -u nginx -o json

    $ journalctl -b -u nginx -o json-pretty

    可用于显示的各类格式:
    1. cat: 只显示信息字段本身。
    2. export: 适合传输或备份的二进制格式。
    3. json: 标准 JSON，每行一个条目。
    4. json-pretty: JSON 格式，适合人类阅读习惯。
    5. json-sse: JSON 格式，经过打包以兼容 server-sent 事件。
    6. short: 默认 syslog 类输出格式。
    7. short-iso: 默认格式，强调显示 ISO 8601 挂钟时间戳。
    8. short-monotonic: 默认格式，提供普通时间戳。
    9. short-precise: 默认格式，提供微秒级精度。
    10. verbose: 显示该条目的全部可用 journal 字段，包括通常被内部隐藏的字段。


活动进程监控
============

显示近期日志::

    journalctl -n       // 默认是10
    journalctl -n 20








