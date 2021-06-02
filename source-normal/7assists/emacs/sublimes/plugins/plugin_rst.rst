.. _plugin_rst:

reStructureText插件 [1]_
#########################

安装
----

* pandoc [3]_
* docutils [4]_

安装依赖 [2]_ ::

    $ apt-get install pandoc docutils rst2pdf

    # Mac下安装
    $ brew install pandoc
    $ pip install pandoc docutils rst2pdf

    # 注:
    rst2pdf只适用于pip2

安装(建议)::
    
    Cmd + Shift + p
    键入: Package Control: Install Package.
    键入: Restructured Text (RST) Snippets


安装(不建议)::

    # Clone the repository into your packages folder:
    $ git clone https://github.com/mgaitan/sublime-rst-completion.git

使用
----


标题::

    // 新增
    h1回车
    h2回车
    ...

    // 操作Adjust header level
    Alt + '+'  : 增大标题1级
    Alt + '-'  : 减小标题1级

    //Navigation
    Alt + 上箭头: 跳转到上一目录
    Alt + 下箭头: 跳转到下一目录

    // 补全
    ****<TAB>
    ---<TAB>

    // Folding/unfolding
    shift + TAB



边边角角::

    link回车
    linki回车
    code回车
    img回车

列::

    1. 回车 / A. 回车 / i. 回车 / X. 回车
    ...

    (a) 、(A)、(i)、(X)、
    a) 、A)、i)、X)、

    * 回车 / - 回车
    ...


表格::

    Col1    Col2    Col3
    1111111111  22222222    s33333333
    aaa   bbbbb   cccccccR

    <cmd> + <Shift> + t, <Enter>: 生成【Grid table】
    <cmd> + <Shift> + t, s: 生成【Simple table】


脚注::

    Alt + Shift + f  # 新增脚注
    shift+up   # 回到


Render preview
--------------

快捷键::

    ctrl+shift+r













.. [1] https://github.com/mgaitan/sublime-rst-completion
.. [2] :ref:`rst2pdf命令 <rst2pdf>`
.. [3] https://pandoc.org/
.. [4] http://docutils.sourceforge.net/