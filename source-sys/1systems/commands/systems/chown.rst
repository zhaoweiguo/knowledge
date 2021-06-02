.. _chown:

chown命令使用
=======================
::

    chown <归属用户>[:归属群组] <文件|目录>

更改文件的归属用户。可以使用用户名或者 UID::

     -R 递归
     -v 显示过程
     -c 类似 -v ,仅显示更改部分
     –reference=<参考文件或目录> 以指定文件为参考更改权限

示例::

     chown user:admin path
     chown -R user.admin path
     chown user path

