svn简单使用
###################

::

    svn checkout https://svn.sinaapp.com/newapp

    //查看svn地址
    svn info

做出修改::

    svn add <file>
    svn add <folder>/*
    svn delete something
    svn delete -m "delete something" https://svn.sinaapp.com/appname/appversion/something

提交你的修改::

    svn commit -m"<commit>"   // 设定评论并提交

可能会取消一些修改::

    svn revert

更新你的工作拷贝::

    svn update  // 更新本地版本内容

解决冲突(合并别人的修改)::

    svn update  // 更新后有冲突
    svn log    // 查看下日志情况
    svn log -r 5:9   //查看指定版本间的日志
    svn resolved

忽略文件::

  svn propedit svn:ignore <目录名称>
  注意，在使用这个SVN的属性编辑前，你得确保后面的“目录名称”是SVN版本控制的目录。
  


    
检验修改::

    svn diff    检验修改
    svn diff -r newversion:oldversion path

    svn status 
    svn status -q   // don't print unversioned items
    svn status -u -v [<file/folder>]   // 数字是“当前版本和最新版本”

* SVN命令帮助文档：http://www.subversion.org.cn/svnbook/1.4/svn.ref.html
* 中文完全帮助文档：http://svnbook.red-bean.com/index.zh.html




