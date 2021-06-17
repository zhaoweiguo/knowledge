.. _ls:

ls命令
=======

ls [路径]     显示当前目录文件列表::

     –color 不同属性以不同颜色显示(默认参数)
     -a 全部显示
     -i 显示 inode 值
     -l 详细信息
     -F 显示文件类型后缀 目录/ 链接@ 可执行文件* 端口文件= 管道文件| >
     -A 显示隐藏文件
     -R 递归显示子目录文件列表
     -S 按文件大小排序
     -t 按修改时间排序
     -u 按访问时间排序
     -d 只显示目录,不递归显示目录下的文件
     -s 显示每个文件实际使用的文件系统的块数,块BLOCKSIZE的大小默认为512字节,可通过修改环境变量BLOCKSIZE来改变
     -k 与-s选项配合使用, 把单位由BLOCKSIZE替换为KB（千字节）显示文件大小,相当于修改环境变量BLOCKSIZE


ls 还可以使用 a 、 u 、 g 、 o 表示归属关系,使用 = 、 + 、 – 表示权限变化,使用 r 、w 、 x 表示权限内容::

         a 所有用户      u 归属用户      g 归属群组 o 其它用户
         = 具有权限      + 增加权限      – 去除权限
         r 可读权限      w 可写权限      x 可执行权限

例如::

         a+x 给所有用户增加可执行权限
         go-wx 将归属群组和其它用户的可写、可执行权限去掉
         u=rwx 归属用户具有可读、可写、可执行权限

* 常见命令::

    * ls -lh
    * ls -d, --directory 只展示目录
    * ls -r, --reverse 有排序时反转
    * ls -R, --recursive 递归列出子目录

* 排序(ls -l --sort=<WORD>)::

    * ls -lS 等同于 ls -l --sort=size 按大小降序排序    
    * ls -lt 等同于 ls -l --sort=time 按时间降序排序
    * ls -lU 等同于 ls -l --sort=none
    * ls -lX 等同于 ls -l --sort=extension
    * ls -lv 等同于 ls -l --sort=version

* 显示时间(ls --time=<WORD>)[默认是修改时间]::

    * ls -c, --time=ctime
    * ls -u, --time: 最后使用的最后日期


实例::

    ls -lh      // 查看逻辑大小
    $ zhaoweiguo$ ls -lh Docker.raw
    -rw-r--r--@ 1 zhaoweiguo  staff    15G Jun 25 13:56 Docker.raw
    
    ls -lskh    // 查看物理大小
    $ zhaoweiguo$ ls -lhks Docker.raw
    3728116 -rw-r--r--@ 1 zhaoweiguo  staff    15G Jun 25 13:56 Docker.raw




