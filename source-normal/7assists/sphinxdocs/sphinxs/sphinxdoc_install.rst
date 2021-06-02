.. _sphinxdoc_install:

sphinx安装与使用核心命令
################################

::

    sudo apt-get intall python-setuptools
    sudo easy_install -U Sphinx      #用别的方法可以没有安装sphinx-apidoc

    or
    sudo pip install -U Sphinx

    sphinx document的基本命令:
    * sphinx-build
    * sphinx-quickstart
    * sphinx-apidoc
    * sphinx-autogen

各基本命令结构::

    sphinx-build结构:
        sphinx-build [options] sourcedir builddir [filenames...]
          -b buildername
             html, dirhtml, singlehtml, htmlhelp, qthelp, devhelp, epub, latex(pdflatex), 
             man, texinfo, text, gettext, doctest, linkcheck
          -a
             输出所有文件.默认是只输出新的或修改过的文件
          -d path
             the cached environment and doctree files的目录地址.默认目录是outdir/.doctrees
          -c path
             配置文件 "conf.py"的目录地址.默认是source/conf.py文件
        注:其他的请用命令 sphinx-build --help来察看

    sphinx-quickstart:
        快速建立一sphinx文档.





