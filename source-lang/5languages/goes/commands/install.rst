.. _go_install:

go install命令
###################

usage::
  
    go install [build flags] [packages]
    go help install


.. warning:: go install命令不允许 go.mod 中有`replace` 和 `exclude` 指令。因为这会导致安装时版本歧义。







