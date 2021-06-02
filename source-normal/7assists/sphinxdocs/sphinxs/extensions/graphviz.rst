***********************
使用graphviz来画图 [1]_
***********************


配置文件修改::

    # 通过配置开启graphviz插件
    extensions = ['sphinx.ext.graphviz']

    # 设置 graphviz_dot 路径
    graphviz_dot = 'dot'
    # 设置 graphviz_dot_args 的参数，这里默认了默认字体
    # 过-G, -N, -E 来设置全局的 graph、node、edge 属性(注意是单引号)
    graphviz_dot_args = ['-Gfontname=Georgia', 
                         '-Nfontname=Georgia',
                         '-Efontname=Georgia']
    # 输出格式，默认png，这里我用svg矢量图
    graphviz_output_format = 'svg'


开始使用Graphviz::

    .. graphviz::

      digraph abc{
          a;
          b;
          c;
          d;

          a -> b;
          b -> d;
          c -> d;
      }

    or

    .. graphviz:: external.dot


.. image:: /images/sphinxdocs/sphinx-docs-with-graphviz1.png


实例
=======

测试一下你的graphviz能否支持好中文(在中文label的前面增加一个空白字符):

.. literalinclude:: /files/sphinxdocs/graphviz.dot

显示:

.. image:: /images/sphinxdocs/sphinx-docs-with-graphviz1.png




.. [1] https://www.chenyudong.com/archives/sphinx-docs-draw-graphic-with-graphviz.html