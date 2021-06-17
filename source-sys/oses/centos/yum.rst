yum命令
=======

有哪些可用版本::

    yum list docker-ce --showduplicates | sort -r

选择一个版本安装::

    $> yum install docker-ce-<VERSION STRING>
    如:
    $> yum install docker-ce-18.06.3.ce

update cache::

    $> yum clean all
    $> yum makecache
    $> yum repolist




因为yum默认的是使用python2.4,为了使yum命令能正确执行,需要修改::

    [root@CNC-BJ-5-3N1 bin]# vi yum
    //将#!/usr/bin/python 改为 #!/usr/bin/python2.4


增加repo安装::

    repo: http://puias.princeton.edu/data/puias/unsupported/5.7/x86_64/
    新建文件:/etc/yum.repos.d/puias-unsupported.repo

      [puias-unsupported]
      name=PUIAS Unsupported
      baseurl=http://puias.math.ias.edu/data/puias/unsupported/5/x86_64/
      enabled=1
      gpgcheck=0

    yum安装
      sudo yum install emacs23
      sudo yum --disablerepo=”*” --enablerepo=puias-unsupported install emacs23
      注:If you install it this way, it will be placed into /usr/emacs23/ . It does not replace the existing emacs21

本地安装::

    // 需要保证当前目录有指定的rpm包
    yum localinstall *
    如:
    yum localinstall mongodb-org-*




