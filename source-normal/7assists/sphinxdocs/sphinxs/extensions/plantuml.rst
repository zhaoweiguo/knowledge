.. _sphinx-plantuml:

PlantUML插件
############

plantweb方法
============

安装::

    plantweb安装
    $ sudo pip3 install plantweb

说明::

    好像只能用于readthedocs
    Plantweb is an excellent way to display and render PlantUML, Graphviz and Ditaa diagrams 
        in ReadTheDocs published documentation.

* plantweb官网: https://plantweb.readthedocs.io/

PlantUML插件 [2]_
=================

安装::

    $ pip install sphinxcontrib-plantuml

启动扩展::

    extensions = ['sphinxcontrib.plantuml']

增加plantuml命令::
  
    1. 在conf.py指定命令
    plantuml = 'java -jar /path/to/plantuml.jar'

    或

    2. install a wrapper script in your PATH:
    $ cat <<EOT > /usr/local/bin/plantuml
    #!/bin/sh -e
    java -jar /path/to/plantuml.jar "$@"
    EOT
    % chmod +x /usr/local/bin/plantuml

使用1::

    .. uml::

       Alice -> Bob: Hi!
       Alice <- Bob: How are you?

使用2-指定文件::

    .. uml:: /folder/file/external.uml

指定height, width, scale and align::

    .. uml::
       :scale: 50 %
       :align: center

       Foo <|-- Bar

指定标题::

    .. uml::
       :caption: Caption with **bold** and *italic*
       :width: 50mm

       Foo <|-- Bar



假嵌入plantuml.jar [1]_
=======================

说明::

    本质是在make时生成对应的png文件
    使用方式不如上面直接使用『PlantUML插件』的方式好

在项目下::

    $ cd <project>
    $ mkdir _utils
    $ cp plantuml.jar _utils


新增cfg文件到_utils目录下:

.. literalinclude:: /files/sphinxdocs/plantuml.cfg


修改Makefile文件::

    // 本质是把 uml 文件夹下的 uml 文件编译成图片，放到同级别目录下的 uml_generated 文件夹中
    @java -jar _utils/plantuml.jar -charset UTF-8 -config _utils/plantuml.cfg \
      -psvg -o ../uml_generated/ ./uml/*.uml %SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%

使用::

    .. image:: uml_generated/test.png
      :align: center






.. [1] https://blog.csdn.net/techfield/article/details/83031177
.. [2] https://pypi.org/project/sphinxcontrib-plantuml/