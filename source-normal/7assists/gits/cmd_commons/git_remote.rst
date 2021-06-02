git remote命令
#####################

::

    $git init
    $git remote add origin git://github.com/someone/another_project.git

    // -u: 在推送成功后自动建立本地分支与远程版本库分支的追踪
    $ git push -u origin master

git remote命令::

    git remote show origin
    git ls-remote --heads origin
    git remote -v

    git remote add <Name> git@git.xxx.com:/path/to/name.git
    git remote remove <Name>
    git remote rename origin oldorigin

    // 修改url地址
    git remote set-url origin https://github.com/USERNAME/REPOSITORY.git


定期使用项目仓库内容更新自己仓库内容::

  $ git remote add upstream https://github.com/yeasy/blockchain_guide
  $ git fetch upstream
  $ git checkout master
  $ git rebase upstream/master
  $ git push -f origin master
