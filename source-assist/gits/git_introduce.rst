 .. _git_introduce:

基本介绍 [1]_ [2]_
######################
:作者: 新溪-gordon <programfan.info#gmail.com>
:时间: 2014-11-13

安装::

  //命令:
  1. $ yum install git-core
  2. $ apt-get install git-core
  //git地址
  http://www.kernel.org/pub/software/scm/git/



git状态::

  修改后进入<Changes not staged for commit>状态
  git add命令后, 文件改为<Changes to be committed>状态
  git commit后，文件改为<nothing to commit, working tree clean>状态

文件存储机制::

  1. 文件HEAD存放根节点的信息
  2. *目录refs* 存储了你在当前版本控制目录下的各种不同引用(引用指的是你本地和远程所用到的各个树分支的信息),它有如下几个文件
      * heads   //存储对不同的根?
      * remotes //远程版本库
      * stash   //Git栈
      * tags    //标签

     说明:可以通过命令 ``git show-ref`` 更清晰地查看引用信息
  3. 目录logs根据不同的引用存储了日志信息
     因此，Git只需要代码根目录下的这一个.git目录就可以记录完整的版本控制信息，而不是像SVN那样根目录和子目录下都有.svn目录


Git与SVN的不同之处::

  Git最大的优势在于两点：易于本地增加分支和分布式的特性

  1. 易于本地增加分支
  Git本地和服务器端结构都很灵活，所有版本都存储在一个目录中，你只需要进行分支的切换即可达到在某个分支工作的效果。而 SVN则完全不同，如果你需要在本地试验一些自己的代码，只能本地维护多个不同的拷贝，每个拷贝对应一个SVN服务器地址。
  Git只需要开一个分支或者转回到主分支上，就可以随时开始Bug修改的任务，完成之后，只要切换到原来的分支就可以优雅的继续以前的任务。只要你愿意，每一个新的任务都可以开一个分支，完成后，再将它合并到主分支上，轻松而优雅。


源码中各语言所占比例:

  .. figure:: /images/gits/git_used_language.png
     :width: 70%


一，基本命令::

    git clone git://github.com/someone/some_project.git some_project

    //还原一个版本的修改，必须提供一个具体的Git版本号,Git的版本号都是生成的一个哈希值
    $git revert bbaf6fb5060b4875b18ff9ff637ce118256d6f20

用Git ssh方式快速建立一个Git服务器::

    // 服务端命令如下(以test为例):
    cd /path/to/my/workspace
    mkdir test
    cd test
    git init
    cd ..
    git clone --bare test test.git (一定要执行这个命令)
    rm -rf test

    // 客户端获取命令如下:
    git clone git@server:/path/to/my/workspace/test.git





.. [1] `Git学习教程git简介1-7: <http://fsjoy.blog.51cto.com/318484/244397>`_
.. [2] `Pro Git: <http://progit.org/book/>`_


