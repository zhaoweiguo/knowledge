.. _git_rev-parse:

版本表示法 git rev-parse
====================================

命令 ``git rev-parse`` 是Git的一个底层命令，功能非常丰富(或复杂).例如:

    * Git版本库的位置(``--git-dir``)
    * 当前工作区目录的深度(``--show-cdup``)
    * 甚至可以被与Git无关的应用用于解析命令行参数(--parseopt)

显示命令::

  //显示分支:
  $ git rev-parse --symbolic --branches
  //显示里程碑
  $ git rev-parse --symbolic --tags
  //显示定义里的所有引用
  $ git rev-parse --symbolic --glob=refs/*


