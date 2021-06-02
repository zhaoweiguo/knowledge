.. _nsswitch.conf:

/etc/nsswitch.conf文件
######################

* man [1]_

什么是nsswithch.conf(服务搜索顺序)文件
======================================

nsswitch.conf(name service switch configuration，名字服务切换配置)文件位于/etc目录下，由它规定通过哪些途径以及按照什么顺序以及通过这些途径来查找特定类型的信息，还可以指定某个方法奏效或失效时系统将采取什么动作。


Nsswitch.conf中的每一行配置都指明了如何搜索信息，每行配置的格式如下::

    info: method[[action]] [method[[action]]...] 

    说明:
    info指定该行所描述的信息的类型
    method为用来查找该信息的方法
    action是对前面的method返回状态的响应(action要放在方括号里)

信息(Info)
==========

``nsswitch.conf`` 文件通常控制着用户(在passwd中)、口令(在shadow中)、主机IP和组信息(在group中)的搜索。下面的列表描述了nsswitch.conf文件控制搜索的大多数信息(Info项)的类型::

    automount：自动挂载（/etc/auto.master和/etc/auto.misc）
    bootparams：无盘引导选项和其他引导选项（参见bootparam的手册页）
    ethers：MAC地址
    group：用户所在组（/etc/group),getgrent()函数使用该文件
    hosts：主机名和主机号（/etc/hosts)，gethostbyname()以及类似的函数使用该文件
    networks：网络名及网络号（/etc/networks)，getnetent()函数使用该文件
    passwd：用户口令（/etc/passwd)，getpwent()函数使用该文件
    protocols：网络协议（/etc/protocols），getprotoent()函数使用该文件
    publickey：NIS+及NFS所使用的secure_rpc的公开密钥
    rpc：远程过程调用名及调用号（/etc/rpc），getrpcbyname()及类似函数使用该文件
    services：网络服务（/etc/services），getservent()函数使用该文件
    shadow：映射口令信息（/etc/shadow），getspnam()函数使用该文件
    aiases：邮件别名，sendmail()函数使用该文件

方法(method)
============

下面列出了nsswich.conf文件控制搜索信息类型的方法，对于每一种信息类型，都可以指定下面的一种或多种方法::

    files：搜索本地文件，如/etc/passwd和/etc/hosts
    nis：搜索NIS数据库，nis还有一个别名，即yp
    dns：查询DNS（只查询主机）
    compat：passwd、group和shadow文件中的±语法（参见本节后面的相关内容）

.. note:: 最好增加一个/etc/nsswitch.conf文件, 特别是一个域名配置了dns, 你又想通过/etc/hosts修改此域名的ip地址时



实例
====

实例1/etc/nsswitch.conf::

    passwd:          files
    group:           files
    hosts:           files
    networks:        files
    protocols:       files
    rpc:             files
    ethers:          files
    netmasks:        files
    bootparams:      files
    publickey:       files

    netgroup:        files
    automount:       files
    aliases:         files
    services:        files
    sendmailvars:    files

实例2/etc/nsswitch.conf::

    passwd:        files nis
    group:         file nis

    # consult /etc "files" only if nis is down.
    hosts:         nis    [NOTFOUND=return] files
    networks:      nis    [NOTFOUND=return] files
    protocols:     nis    [NOTFOUND=return] files
    rpc:           nis    [NOTFOUND=return] files
    ethers:        files  [NOTFOUND=return] nis
    netmasks:      nis    [NOTFOUND=return] files 
    bootparams:    files  [NOTFOUND=return] nis
    publickey:     nis    
    netgroup:      nis

    automount:     files nis
    aliases:       files nis

    # for efficient getservbyname() avoid nis
    services:      files nis
    sendmailvars:  files



.. [1] http://man7.org/linux/man-pages/man5/nsswitch.conf.5.html