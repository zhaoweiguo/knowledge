通用
####

配置文件::

  html_theme: 主题名,有buildin主题,也可以自己安装新主题,如sphinx_rtd_theme
    内置主题有:
    basic: 最简单的
    classic
    blue
  html_theme_path: 自定义主题目录地址
  html_static_path: 静态css文件等的目录地址
  html_show_sourcelink: 是否显示‘查看源码’功能

  extensions: 扩展，如ablog
  

rst_epilog::

    # 一串reStructuredText，它将包含在每个读取的源文件的末尾

    如: 
    rst_epilog = """
    .. |psf| replace:: Python Software Foundation
    """

html_static_path::

    包含自定义静态文件（例如样式表或脚本文件）的路径列表

    如:
    html_static_path = ['_static', '_static/.htaccess']




