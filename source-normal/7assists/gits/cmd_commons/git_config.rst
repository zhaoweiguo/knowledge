git config命令
######################



git config::

  //修改设置:
  $ git config --global user.name "Scott Chacon"
  $ git config --global user.email "schacon@gmail.com"
  $ git config --global core.editor 'emacs'
  $ git config core.ignorecase false //不忽略文件名的大小写
  $ git config core.filemode false //忽略权限修改

  git commit --amend --author='Your Name <you@example.com>'

  // 查看设置:
  git config user.name


  //将master的远程版本库设置为别名叫做origin版本库
  $git config branch.master.remote origin

配置文件::

  // 1. /etc/gitconfig
  // 2. ~/.gitconfig
  // 3. .git/config'

  [user]
      name = Gordon
      email = zhaoweiguo@maxvox.com.cn
  [core]
      editor = emac



