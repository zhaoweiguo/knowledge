.. _rsync:

rsync——文件同步命令
###############################

* 首先 ``SERVER`` 与 ``CLIENT`` 都需要安装 ``rsync``




``SERVER`` 服务端设置=>在 ``SERVER`` 的 ``/etc/`` 下面建立 ``rsyncd.conf``, 内容如下::

    uid = root                        //rsync启动ID
    gid = root
    use chroot = no
    log file = /var/log/rsyncd.log   //日志存放
    pid file = /var/run/rsyncd.pid
    lock file = /var/run/rsync.lock


    //非必选参数
    port = 873
    address = <服务器IP地址>
    hosts allow = 192.168.0.4
    host deny = 0.0.0.0/32
    ignore errors
    timeout = 300
    

    [<sectionName>]      //模块名称---也就一个需要同步或备份的目录
    path = /usr/local/apache/htdocs/publish/online/images
    comment = home cad folder
    ignore errors
    read only = yes     //权限只读
    list = no
    auth users = <userName>        //登录用户名--自我随意设置
    secrets file = /path/<pwdServerFile>  //密码存放文件----一般需要自我建立此文件，路经与命名随意

``SERVER`` 服务端设置 => 文件 ``/path/<pwdName>`` 文件的格式如下(文件的属性必需是(400)只有属主可读(不能错!))::

    <userName>:<passwd>

    shell> chmod 400 /path/<pwdName>

``SERVER`` 服务端设置 => 在server端将rsync以守护进程形式启动::

    # rsync --daemon --config=/etc/rsyncd/rsyncd.conf



``CLIENT`` 服务端设置 => 实例::

    // 最普通的方法
    rsync -vzrtopg --progress --delete <serverUser>@<serverHost> 
        --password-file=<密码文件> /path/<rsyncFolder>

    rsync -vzrtopg --progress --delete inburst@192.168.*.*::inburst 
      --exclude="*.sh" --exclude="images*" --exclude="*.log" 
      --password-file=<密码文件> /path/<rsyncFolder>




``CLIENT`` 服务端设置 => 参数说明::

   -vzrtopg里的:
        v是verbose，
        z是压缩，
        r是recursive，
        topg都是保持文件原有属性如属主、时间的参数
   ----progress:
        是指显示出详细的进度情况
   --delete:
        是指如果服务器端删除了这一文件,那么客户端也相应把文件删除,保持真正的一致
   <userName>@<serverHost>::<sectionName>
        用户名::模块名(对应服务端的<userName>和<sectionName>)
        注意<userName>不一定是服务端的用户,只需要在服务端rsyncd.conf中配置就好
   --exclude="*.sh"
        排除某些文件
   --exclude-from=/path/<excludeList>
        要排除的目录/文件
   -include=<PATTERN>
        不要排队的
   -include-from=<FILE>
       不解释
   --password-file /path/<pwdClientFile>
             指定CLIENT端密码文件存放路径(注意此文件权限是"400"即所有者可读)
   /path/<rsyncFolder>
             指定CLIENT端存放镜象目的目录



``CLIENT`` 服务端设置 => 实例::

    // 将远程37上的/etc目录备份到本地的 /tmp/bb目录
    rsync -av -e ssh root@192.168.254.37:/etc /tmp/bb
    




