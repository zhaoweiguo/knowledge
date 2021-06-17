.. _rar:

rar命令
===============

rar <子命令> [参数] <压缩包> [文件|文件列表|路径]


* .rar

    * 解压::

        rar x FileName.rar

    * 压缩::

        rar a FileName.rar DirName


rar请到: http://www.rarsoft.com/download.htm 下载！
解压后请将rar_static拷贝到/usr/bin目录(其他由$PATH环境变量指定的目录也可以)::

    [root@www2 tmp]# cp rar_static /usr/bin/rar


