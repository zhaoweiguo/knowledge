常见问题
########

AttributeError module object has no attribute <xxxx>::

    一般是因为有*.pyc文件有问题导致，如
    Traceback (most recent call last):
      File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site.py", line 62, in <module>
          import os
      File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/os.py", line 400, in <module>
          import UserDict
      File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/UserDict.py", line 83, in <module>
          import _abcoll
      File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/_abcoll.py", line 11, in <module>
          from abc import ABCMeta, abstractmethod
      File "abc.py", line 9, in <module>
          from PyQt4 import uic
    ... ...

安装高版本的python后，会遇到一些问题::

  1.要把/usr/bin下面的python改成新版本的python; 但这会导致一个问题——yum的使用:

  这个是python2与python3不同的原因
  python2目前受众还是比python3多

  解决方法:
  因为yum默认的是使用python2.4,为了使yum命令能正确执行,需要修改
  [root@CNC-BJ-5-3N1 bin]# vi yum
  将#!/usr/bin/python 改为 #!/usr/bin/python2.4

  注意:
  原来用easy_install安装的包都需要重新安装

遇到这个总是 ``ImportError: No module named pkg_resources`` , 解决方案::

    curl -O http://python-distribute.org/distribute_setup.py
    python distribute_setup.py

``ImportError: No module named Image`` 错误解决, 到　`这儿Python Imaging Library (PIL) <http://www.pythonware.com/products/pil/>`_ 下载Images安装::

    python setup.py install


matplotlib 1.3.1 requires tornado, which is not installed::

  兼容性问题，可使用如下命令检查:
  pip check

  上面问题说明没有安装tornado依赖，可执行如下命令解决:
  sudo pip install tornado


Cannot uninstall 'pyparsing'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall::

  一般是兼容问题，你可能使用了不同的方法安装了这个包（个人分析）
  如: pip, easy_insall或brew, apt-get, yum等

  如果使用easy_install安装的，可使用
  easy_install -mxN <PackageName>
  然后根据冲突的提示，卸载掉networkx对应的egg
  最后，不要忘记重启命令行

  PS：
  如果没有安装相关的元信息的话，最简单的方式就是删除对应的egg文件

  
py2 VS py3
==========

Python3中出现“No module named 'StringIO'”错误处理方法::

    python2用法:
    import StringIO
    iost = StringIO.StringIO()
 

    Python3中已将StringIO归入io，调用方法如下：
    import io
    iost = io.StringIO()







    
