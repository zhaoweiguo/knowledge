.. _emacs_command_outline:

大纲模式
============

* 大纲模式通常作为辅模式使用, ``M-x outline-minor-mode`` 启用
* 大纲模式默认以行首的 * 作为结构标识，每多一个 * 就是下一级分支
* 大纲模式默认的键绑定太过复杂，在配置文件中添加以下语句，将所有大纲模式操作的前缀键改为 Ctrl+o::

    (setq outline-minor-mode-prefix [(control o)])

* 简单的操作::

    C-o C-a     全部显示
    C-o C-t     显示主干
    C-o C-q     全部隐藏
    C-o C-i     显示下一级分支
    C-o C-k     显示分支
    C-o C-e     显示节点
    C-o C-d     隐藏分支


定制结构标识
'''''''''''''''''''
* 为了不影响代码的功能，通常要把结构标识放到注释中，这样作有可能会带来不便,例如在 XML 环境中就要像这样使用::

    <!--
    *结构标识
    -->

* 通过设置outline-regexp定制标识:

    .. figure:: /images/emacs/emacs_outline1.png
       :width: 20%

配置
''''''''
* emacs 大纲模式

    .. figure:: /images/emacs/emacs_outline2.png
       :width: 20%

操作列表
'''''''''''

* 全部显示::

    C-o C-a     show-all            全局
    C-o C-s     show-subtree        分支
    C-o C-e     show-entry          节点

* 只显示分支::

    C-o C-t     hide-body       全局
    C-o C-l     hide-leaves     分支1
    C-o C-k     show-branches   分支2
    C-o C-i     show-children   分支3

* 隐藏::

    C-o C-q     hide-sublevels  全局
    C-o C-d     hide-subtree    分支
    C-o C-c     hide-entry      节点
    C-o C-o     hide-other      其他

* 向前移动::

    C-o C-n     outline-next-visible-heading    全局
    C-o C-f     outline-forward-same-level      同级
    C-o C-u     outline-up-heading              上级

* 向后移动::

    C-o C-p     outline-previous-visible-heading     全局
    C-o C-b     outline-backward-same-level          同级

