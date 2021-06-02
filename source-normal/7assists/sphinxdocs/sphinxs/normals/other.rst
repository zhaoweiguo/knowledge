其他
####

替换::

    # 1. 本地版
    // 在最后做如下定义, 在整个文中可用 |logo|代替此图片
    .. |logo| image:: ../images/wiki_logo_openalea.png  
      :width: 20pt
      :height: 20pt
      :align: middle

    // 代替一段话
    .. |longtext| replace:: this is a longish text to include within a table and which is longer than the width of the column.

    # 2. 全局版
    // In your conf.py:
    my_config_value = 42
    rst_epilog = '.. |my_conf_val| replace:: %d' % my_config_value

    // In your .rst source:
    My config value is |my_conf_val|!

    // In your output:
    My config value is 42!


Cross-referencing::

    See :download:`this example script <../example.py>`
    :doc:`parrot` 
    :doc:`/people` or :doc:`../people`
    like usual: :doc:`Monty Python members </people>`

    .. only:: builder_html

        See :download:`this example script <../example.py>`.

    :abbr:
    :command:
    :dfn:
    :file:
        ... is installed in :file:`/usr/lib/python2.{x}/site-packages` ...
    :guilabel:
    :kbd:
    :mailheader:
    :makevar:
    :manpage:
    :menuselection:
        :menuselection:`Start --> Programs`
    :mimetype:
    :newsgroup:
    :program:
    :regexp:
    :samp:

Substitutions::

    |release|
    |version|
    |today|

Meta-information markup::

    .. sectionauthor:: name <email>
    .. sectionauthor:: Guido van Rossum <guido@python.org>
    .. codeauthor:: name <email>

Index-generating markup::

    .. index:: <entries>
    // 例
    .. index::
       single: execution; context
       module: __main__
       module: sys
       triple: module; search; path

    The execution context
    ---------------------

    ...



其他::

    .. productionlist::
       try_stmt: try1_stmt | try2_stmt
       try1_stmt: "try" ":" `suite`
                : ("except" [`expression` ["," `target`]] ":" `suite`)+
                : ["else" ":" `suite`]
                : ["finally" ":" `suite`]
       try2_stmt: "try" ":" `suite`
                : "finally" ":" `suite`


    % 索引与查询
    * :ref:`genindex`
    * :ref:`search`


