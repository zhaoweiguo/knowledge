conf.py配置文件
###############

html_show_sourcelink::

    If true, links to the reST sources are added to the pages.
    
    实例:
    html_show_sourcelink = False

todo_include_todos::

    If it's True, todo and todolist produce output, else they produce nothing.

    实例:
    todo_include_todos = True

    说明:
    1. 需要增加extensions
    extensions = [
        'sphinx.ext.todo',
    ]
    2. 使用方法
    .. todo::

pygments_style::

    代码亮显格式

    实例:
    pygments_style = 'sphinx'








