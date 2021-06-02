git diff命令
====================

git diff简单使用::

  查看变更还未载入(changed but unstaged)的文件比对:
  git diff
  查看载入(stage)而并未提交(commit)的变更:
  git diff --staged
  查看最后一次提交之后工作目录中文件的变更:
  git diff HEAD
  从一个特定点开始文件的修改情况:
  git diff v1.6.0 -- readme

  //两个版本的变更情况:
  git diff v1.6.0 cf9957875c3a27b6ae4593e1fa9d4dabbde68433 --stat

  两个分支的变更情况:
  git diff <branchName>...master    //比较的是<branchName>与创建之时的差异
  注意:
  git diff <branchName> master     //比较的是master当前快照与<branchName>的差异

  git diff --since=1.week.ago --until=1.minute.ago //还可以根据时间来比较哦  


patch::

  --patch
  Generate patch (see section on generating patches). This is the default.




实战::

  // 展示改变的文件名和状态
  git diff --name-status -r

  // 展示修改文件名和修改长度
  git diff --stat

实例::

  git diff > dispatch.diff

  dispatch












