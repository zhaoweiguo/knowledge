virtualenv
##############

virtualenv::

    % 安装
    pip3 install virtualenv
    % 创建一个虚拟环境
    virtualenv <envName>

virtualenvwrapper::

    % virtualenv的扩展包，可以更方便的新增、删除、复制、切换虚拟环境
    pip3 install virtualenvwrapper

    # 修改~/.bash_profile
    export WORKON_HOME='~/python'        # 这个目录为创建虚拟环境是所在的目录
    source /usr/local/bin/virtualenvwrapper.sh
    # 执行
    source ~/.bash_profile

    mkvirtualenv env1       # 创建虚拟环境env1
    mkvirtualenv env2       # 创建虚拟环境env2

常用命令::

    # 退出当前虚拟环境
    py> deactivate
    # 列出虚拟环境列表
    py> lsvirtualenv -b
    # 切换虚拟环境
    py> workon env2
    # 进入当前虚拟环境
    py> cdvirtualenv
    # 删除虚拟环境
    py> rmvirtualenv env1
    # 进入当前环境的site-packages
    py> cdsitepackages
    # 查看环境中安装了哪些包
    py> lssitepackages
    # 复制虚拟环境
    py> cpvirtualenv env1 env3

其他相关::

    pyenv: pyenv是第三方的、开源的多版本Python管理工具，用以管理在一台机器上多个Python发行版本的共存问题，
        比如一台Linux机器上同时安装Python2.7、Python3.4、Python3.5三个版本的管理
    pyvenv: Python3.3之后标准库自带的虚拟环境创建和管理工具，在一定程度上能够替代virtualenv。
        但venv是Python3.3才有的，Python2.X不能使用，而virtualenv同时支持Python2.X和Python3.X，
        特别是在当前的生产环境中Python2.X还占有很大比例的情况下我们依然需要virtualenv

.. note:: conda 结合了 pip 和 virtualenv 两者的功能。virtualenv 是一个环境管理工具，使用 virtualenv 可以创建一个完全隔离的环境，但 virtualenv 只能创建基于本机已存在的 python 版本的虚拟环境。













