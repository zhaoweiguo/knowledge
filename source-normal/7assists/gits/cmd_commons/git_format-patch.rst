git format-patch
#####################
使用::

  git format-patch <the SHA1>


实例::

  // 指定commit改变的内容
  git format-patch -1 <commit>
  // 提交此patch
  git am < file.patch

  // 把最新的10次commit打包到指定文件中
  git format-patch -10 HEAD --stdout > 10-commits.patch

实例::

   ---P---X---A---M---C
       \         /
        Y---Z---B
  git format-patch --base=P -3 C



