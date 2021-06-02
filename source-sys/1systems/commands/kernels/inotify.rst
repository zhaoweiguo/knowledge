inotify系列命令 [1]_
######################

高效、实时的 Linux 文件系统事件监控框架，windows用ReadDirectoryChangesW


判断是否支持Inotify 机制::

    % grep INOTIFY_USER /boot/config-$(uname -r)
    CONFIG_INOTIFY_USER=y

实例1::

    $> inotifywait -rme modify,attrib,move,close_write,create,delete,delete_self /file/path
    Setting up watches.  Beware: since -r was given, this may take a while!
    Watches established.

    $> mkdir /file/path/infoq
    $> echo TODO > /file/path/infoq/article.txt
    $> rm /file/path/infoq/article.txt
    % shell 中将会打印以下信息
    /file/path/ CREATE,ISDIR infoq
    /file/path/infoq/ CREATE article.txt
    /file/path/infoq/ MODIFY article.txt
    /file/path/infoq/ CLOSE_WRITE,CLOSE article.txt
    /file/path/infoq/ DELETE article.txt


实例2:我们要忽略文件夹 /srv/test/large::

    $> inotifywait --exclude '^/srv/test/(large|ignore)/' -rme modify,attrib,move,close_write,create,delete,delete_self /srv/test
    Setting up watches.  Beware: since -r was given, this may take a while!
    Watches established.

    % echo test > /srv/test/action.txt
    % echo test > /srv/test/large/no_action.txt
    % echo test > /srv/test/ignore/no_action.txt
    % echo test > /srv/test/large-name-but-action.txt

    % 这里应该只会报告'action.txt'和'large-name-but-action.txt'两个文件的变化
    % 而忽略子文件夹'large'和'ignore'下的文件，结果也确实如此

    /srv/test/ CREATE action.txt
    /srv/test/ MODIFY action.txt
    /srv/test/ CLOSE_WRITE,CLOSE action.txt
    /srv/test/ CREATE large-name-but-action.txt
    /srv/test/ MODIFY large-name-but-action.txt
    /srv/test/ CLOSE_WRITE,CLOSE large-name-but-action.txt

Inotifywatch:使用 inotify 来统计文件系统访问信息::

    $> inotifywatch -v -e access -e modify -t 120 -r ~/InfoQ

    Establishing watches...
    Setting up watch(es) on /home/mika/InfoQ
    OK, /home/mika/InfoQ is now being watched.
    Total of 58 watches.
    Finished establishing watches, now collecting statistics.
    Will listen for events for 120 seconds.
    total  modify  filename
    2      2       /home/mika/InfoQ/inotify/

Inotify 的配置选项::


    /proc/sys/fs/inotify/max_user_instances:
    规定了每个用户所能创建的 Inotify 实例的上限

    /proc/sys/fs/inotify/max_user_watches:
    规定了每个 Inotify 实例最多能关联几个监控 (watch)

    运行过程中达到上限测试:

    $> inotifywait -r /

使用 Inotify 的一些工具::

    incron: http://inotify.aiken.cz/:
        似于 cron 的守护进程 
        使用了 Inotify,可以由事件触发执行
        使用方法:
          1.在 /etc/incron.allow 中添加使用 incron 的用户 
            $> echo username > /etc/incron.allow
          2.插入我们自己的规则:/src/test 文件夹中的文件被修改，就会发送一封邮件
            $> incrontab -e
            /srv/test/ IN_CLOSE_WRITE mail -s "$@/$#\n" root
            注意: 不要让 incron 监控整个子目录树
            注意: incron 使用不慎的话，例如形成死循环，则会导致系统宕机

    其他工具:
      inosync(基于消息通知机制的文件夹同步服务)
      iwatch(基于 Inotify 的程序，对文件系统进行实时监控)
      lsyncd(一个守护进程 (daemon)，使用 rsync 同步本地文件夹)




.. [1] https://www.infoq.cn/article/inotify-linux-file-system-event-monitoring

