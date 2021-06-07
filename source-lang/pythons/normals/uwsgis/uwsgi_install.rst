.. -*- coding: utf-8 -*-
.. _uwsgi_install:

uwsgi安装与基本用法
################################

前提::

    yum install python-devel -y		//
    yum install python-setuptools -y

安装::

    wget http://projects.unbit.it/downloads/uwsgi-latest.tar.gz
    tar zxvf uwsgi-latest.tar.gz
    cd <dir>
    make  // or python uwsgiconfig.py --build		//
    python setup.py install		//
    //ps
    make clean		// python uwsgiconfig.py --clean
		


uwsgi option::

    -s|--socket                            bind to the specified UNIX/TCP socket using default protocol
    -s|--uwsgi-socket                      bind to the specified UNIX/TCP socket using uwsgi protocol
    -p|--processes                         spawn the specified number of workers/processes
    -d|--daemonize                         daemonize uWSGI
    --env                                  set environment variable
    --ini                                  load config from ini file
    --touch-reload                         reload uWSGI if the specified file is modified/touched
    -w|--module                            load a WSGI module
    -R|--max-requests                      reload workers after the specified amount of managed requests
    -t|--harakiri                          set harakiri timeout
    --limit-as                             limit processes address space/vsz
    
    
example::

    //并发4个thread
    uwsgi -s :9090 -w myapp -p 4
    //主控thread+4个thread
    uwsgi -s :9090 -w myapp -M -p 4
    //运行超30秒的client直接忽略
    uwsgi -s :9090 -w myapp -M -p 4 -t 30
    //限制memory空间128M
    uwsgi -s :9090 -w myapp -M -p 4 -t 30 --limit-as 128
    //服务超10000req自动respawn
    uwsgi -s :9090 -w myapp -M -p 4 -t 30 --limit-as 128 -R 10000
    后台运行
    uwsgi -s :9090 -w myapp -M -p 4 -t 30 --limit-as 128 -R 10000 -d uwsgi.log

更多：http://projects.unbit.it/uwsgi/wiki/Doc
