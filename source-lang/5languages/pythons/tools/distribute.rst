distribute的使用
===========================


简介::

  Distribute是对标准库disutils模块的增强，我们知道disutils主要是用来更加容易的打包和分发包，特别是对其他的包有依赖的包
  Distribute被创建是因为Setuptools包不再维护了


安装Distribute::

  通过easy_install, pip来安装
  通过源文件来安装
  不过使用distribute_setup.py来安装是最简单和受欢迎的方式::
  
    $ curl -0 http://python-distribute.org/distribute_setup.py
    $ sudo python distribute_setup.py

