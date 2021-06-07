pip的使用
#########



安装Pip：

* ``Pip`` 是安装python包的工具, 提供了安装包, 列出已经安装的包, 升级包以及卸载包的功能
* ``Pip`` 是对 ``easy_install`` 的取代, 提供了和easy_install相同的查找包的功能, 因此可以使用easy_install安装的包也同样可以使用pip进行安装


* 通过easy_install来安装::

    $ easy_install pip

* get_pip.py 脚本安装::

    $ curl -0 https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    $ sudo python get-pip.py

* 通过源文件来安装::

    $ wget http://pypi.python.org/packages/source/p/pip/<pip-0.7.2>.tar.gz  # 替换为最新的包
    $ tar xzf pip-0.7.2.tar.gz
    $ cd pip-0.7.2
    $ python setup.py install


Pip的使用：

* 安装package::

    $ pip install Markdown

* 列出安装的packages::

    $ pip freeze
    or
    $ pip list

* 安装特定版本的package::

    通过使用==, >=, <=, >, <来指定一个版本号
    $ pip install 'Markdown<2.0'
    $ pip install 'Markdown>2.0,<2.0.3'
    $ pip install applicationName==version


* 升级包::

    升级包到当前最新的版本，可以使用-U 或者 --upgrade
    $ pip install -U Markdown

* 卸载包::

    $ pip uninstall Markdown

* 查询包::

    $ pip search "Markdown"


PS -- 包安装后的py文件路径：/usr/local/lib/python2.7/dist-packages


实例::

    # 配置清华PyPI镜像（如无法运行，将pip版本升级到>=10.0.0）
    $ pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    Writing to /Users/zhaoweiguo/.config/pip/pip.conf

    # 重置
    $ pip config unset global.index-url


requirements.txt
================

生成requirements.txt的方法::

    1. 适用于「单虚拟环境」
    pip freeze > requirements.txt
    说明: 会将环境中的依赖包全都加入，所以只适合「单虚拟环境」
    2. 推荐用法: 使用pipreqs
    pip install pipreqs
    pipreqs . --encoding=utf8 --force

使用requirements.txt安装依赖的方法::

    $ pip install -r requirements.txt

