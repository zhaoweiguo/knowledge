.. _jupyter:

Jupyter
#######

* 官网 [1]_

发音::

    音标:/ˈdʒuːpɪtə(r)/
    与 “木星（jupiter）” 谐音

打开Jupyter记事本::

    $ jupyter notebook

安装::

    pip3安装
    $ pip3 install --upgrade pip
    $ pip3 install jupyter

    conda安装
    $ conda install jupyter
    $ conda install jupyter=1.0.0

常见问题
========

远程server执行时, 如果不配置ip
------------------------------

::

    (gluon) [root@GPU1 d2l-zh]# jupyter notebook
    Traceback (most recent call last):
      File "/root/miniconda2/envs/gluon/bin/jupyter-notebook", line 8, in <module>
        sys.exit(main())
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/jupyter_core/application.py", line 270, in launch_instance
        return super(JupyterApp, cls).launch_instance(argv=argv, **kwargs)
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/traitlets/config/application.py", line 663, in launch_instance
        app.initialize(argv)
      File "<decorator-gen-7>", line 2, in initialize
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/traitlets/config/application.py", line 87, in catch_config_error
        return method(app, *args, **kwargs)
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/notebook/notebookapp.py", line 1769, in initialize
        self.init_webapp()
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/notebook/notebookapp.py", line 1490, in init_webapp
        self.http_server.listen(port, self.ip)
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/tornado/tcpserver.py", line 151, in listen
        sockets = bind_sockets(port, address=address)
      File "/root/miniconda2/envs/gluon/lib/python3.6/site-packages/tornado/netutil.py", line 174, in bind_sockets
        sock.bind(sockaddr)
    OSError: [Errno 99] Cannot assign requested address

解决方法::

    jupyter远程访问配置:
    1. 生成配置文件（~/.jupyter/jupyter_notebook_config.py）
       $ jupyter notebook --generate-config
    2. 生成密钥
       $ jupyter notebook password  # 自己造一个密码输入一确认一次
       $ vim ~/.jupyter/jupyter_notebook_config.json
       // 记下密钥，sha1:03c74e2b144e:7…
    3. 编辑配置文件
       $ vim ~/.jupyter/jupyter_notebook_config.py
       c.NotebookApp.ip='*'                                  # 就是设置所有ip皆可访问  
       c.NotebookApp.password = u'sha1:03...       # 刚才复制的那个密文'  
       c.NotebookApp.open_browser = False       # 禁止自动打开浏览器  
       c.NotebookApp.port =1234                         #随便指定一个端口  

解决方法2::

    $ jupyter notebook --ip=192.168.168.77   # 指定ip
    or
    $ jupyter notebook --ip=*

libomp.dylib
------------

问题::

    OMP: Error #15: Initializing libomp.dylib, but found libiomp5.dylib already initialized.

解决方法::

    import os
    os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"




.. [1] https://jupyter.org/