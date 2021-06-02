freebsd专用
###########



防火墙::

    emacs /etc/pf.conf
    /etc/rc.d/pf restart





位置: ``/usr/ports``
查询软件::

    make search key=<xxxxx>
    make search name=<xxxxx>
    whereis <xxxxx>
    find . -name <xxxxx>


安装::

    make config
    make install



::

    sockstat 网络状态
    常用参数 -4 ,-4l, -c
    systat 系统状态
    常用参数 -iostat, -ifstat
    netstat 网络状态
    常用参数 -r






