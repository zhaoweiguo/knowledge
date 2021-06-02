整体说明
=========

目录结构::

    src/
       <project>.app.src
    ebin/
    priv/
    include/
    c_src/
    test/

支持的文件格式:

.. figure:: /images/languages/erlangs/erl_rebar_source_format.png
    :width: 80%

项目依赖:

.. figure:: /images/languages/erlangs/erl_rebar_dependance.png
    :width: 80%

动态配置::

    动态配置, 高级功能，暂不需要

内置模板::

    rebar create-app appid=<xxx>  ===> rebar create template=simpleapp appid=<xxx>
    rebar create-lib libid=<xxx>  ===> rebar create template=simplelib libid=<xxx>
    rebar create-node nodeid=<xx> ===> rebar create template=simplenode nodeid=<xxx>

发布处理:



::

    * 创建应用::

        ./rebar create-app appid=exemplar

    * 创建结点::

        mkdir rel; cd rel
        ../rebar create-node nodeid=exemplar

    * 在文件 ``myapp/rebar.config`` 中增加如下一行::

        {sub_dirs, ["rel"]}.

    * 运行::

        ./rebar generate
