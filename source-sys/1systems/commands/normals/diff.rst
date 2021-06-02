.. _diff:

diff命令使用
====================

diff <文件名>    比较文件

::

    // 目录级联比较
    diff -r ./<folder1> ./<folder2>

实例::

    // 使用<() 来指定变量?
    diff \
      <(kustomize build $OVERLAYS/staging) \
      <(kustomize build $OVERLAYS/production) |\
      more


