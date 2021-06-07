conda的使用 [1]_
################

* anaconda官网 [2]_

官方定义::
  
    Package, dependency and environment management for any language—
        Python, R, Ruby, Lua, Scala, Java, JavaScript, C/ C++, FORTRAN, and more.

Anaconda是Python的一个开源发行版本，主要面向科学计算。包管理器和环境管理器。

Conda是一种通用包管理系统，旨在构建和管理任何语言的任何类型的软件。因此，它也适用于Python包。　　因为conda来自于Python(更具体地说是PyData)社区，许多人错误地认为它基本上是一个Python包管理器。情况并非如此：conda旨在管理任何软件堆栈中的包和依赖关系。在这个意义上，它不像pip，更像是apt或yum等跨平台版本。

安装::

    安装过程: 印象笔记(20200229Docker安装Conda)

    conda分为anaconda和miniconda
    anaconda是包含一些常用包
    miniconda则是精简版，需要啥装啥
    
    下载网站:
    miniconda:
    https://conda.io/miniconda.html
    
    anaconda:
    https://www.anaconda.com/distribution/

    下载后直接执行sh命令,如:
    ./Miniconda3-latest-MacOSX-x86_64.sh



Docker::

    $ docker pull continuumio/miniconda3
    $ docker pull continuumio/miniconda2
    $ docker pull continuumio/anaconda2
    $ docker pull continuumio/anaconda3


命令使用::

    $ conda install pytorch torchvision -c pytorch
    $ conda env create -f environment.yml
    $ cat environment.yml
    name: gluon
    dependencies:
    - python=3.6
    - pip:
      - mxnet==1.5.0
      - d2lzh==0.8.11
      - jupyter==1.0.0
      - matplotlib==2.2.2
      - pandas==0.23.4
    $ conda activate gluon

    // 升级conda
    $ conda update conda

    If you'd prefer that conda's base environment not be activated on startup:
    $ conda config --set auto_activate_base false

安装命令::

    $ conda install gatk
    # 安装到指定channel
    $ conda install gatk -c channel
    搜索需要的安装包:
    $  conda search gatk
    
    如需要安装特定的版本:
    $ conda install 软件名=版本号
    $ conda install gatk=3.7

    查看已安装软件:
    $ conda list

    更新指定软件:
    $ conda update gatk
    卸载指定软件:
    $ conda remove gatk



添加频道::

    官方channel：
    $ conda config --add channels bioconda
    $ conda config --add channels conda-forge

    $ conda config --add channels genomedk

    $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
    $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/

    显示安装的频道
    $  conda config --set show_channel_urls yes

    查看已经添加的channels:
    $ conda config --get channels

文件::

    已添加的channel在哪里查看
    ~/.condarc


conda环境::

    1. 查看当前存在的环境:
    $ conda env list  (or $ conda info --envs)
    # conda environments:
    #
    base                  *  /Users/zhaoweiguo/9tool/miniconda3
    gluon                    /Users/zhaoweiguo/9tool/miniconda3/envs/gluon

    2. 创建conda环境:
    conda create -n python2 python=2
    #-n: 设置新的环境的名字
    #python=2 指定新环境的python的版本

    3. 启动python2环境:
    $ conda activate python2

    4. 退出环境
    $ conda deactivate

    5. 删除环境
    $ conda remove -n myenv --all

    6. 重命名环境(把一个原来叫做py2的环境重新命名成python2)
    $ conda create -n python2 --clone py2
    $ conda remove -n py2 --all


镜像
====

直接修改文件 ``~/.condarc`` ::

    channels:
      - defaults
    show_channel_urls: true
    channel_alias: https://mirrors.tuna.tsinghua.edu.cn/anaconda
    default_channels:
      - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
      - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
      - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
      - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
      - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
    custom_channels:
      conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
      msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
      bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
      menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
      pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
      simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud

* https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/
* https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

参考
====

* https://zhuanlan.zhihu.com/p/25198543
* https://www.zhihu.com/question/58033789/answer/254673663


.. [1] https://conda.io
.. [2] https://www.anaconda.com/