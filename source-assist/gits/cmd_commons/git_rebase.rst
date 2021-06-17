git rebase命令
######################
Reapply commits on top of another base tip

::

        A---B---C topic
        /
   D---E---F---G master


执行::

  git rebase master   // 当前在topic节点
  git rebase master topic

结果::

                 A'--B'--C' topic
                /
   D---E---F---G master

使用::

  git rebase:
  // 可以用来修改commit的内容
  $git rebase -i <branch>/<tag>/<version>
  //实例:
  git rebase -i master


定期使用项目仓库内容更新自己仓库内容::

  $ git remote add upstream https://github.com/yeasy/blockchain_guide
  $ git fetch upstream
  $ git checkout master
  $ git rebase upstream/master
  $ git push -f origin master

  // 撤销修改
  $ git rebase --abort







