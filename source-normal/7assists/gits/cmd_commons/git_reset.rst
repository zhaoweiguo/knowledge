git reset命令
#######################


::

  git reset: 将当前的工作目录完全回滚到指定的版本号
  //例:
  $git reset bbaf6fb5060b4875b18ff9ff637ce118256d6f20 //


reset命令有3种方式::

  git reset --mixed：此为默认方式，不带任何参数的git reset，即时这种方式，它回退到某个版本，只保留源码，回退commit和index信息
  git reset --soft  HEAD^：回退到某个版本，只回退了commit的信息，不会恢复到index file一级。如果还要提交，直接commit即可
  git reset --hard：彻底回退到某个版本，本地的源码也会变为上一个版本的内容





