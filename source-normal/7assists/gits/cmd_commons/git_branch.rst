git branch命令
########################
查看分支列表::

    git branch
    or
    git branch -r  //查看远程分支
    or
    git branch -a  //查看全部分支（-a, --all）

新建分支::

    git branch <branchName>
    or
    git checkout -b <new_branch_name> <tag_name>


删除分支::

    说明:
    -D, --delete --force
    -d, --delete
    -r, --remotes
    实例:
    git branch -d <branchName>   //删除本地分支
    git branch -D <branchName>   //删除未提交的分支

    git branch -d -r origin/<branchName>    //删除远程分支
    git push origin :<branchName>

删除远程分支后，其他本地版本同步::

    git fetch -p // -p, --prune
    // After fetching, remove any remote-tracking branches which no longer exist on the remote.

合并分支(把<branchName>分支合并到当前分支)::

    git merge <branchName>
    or
    git merge --no-ff <branchName>   //每次都会生成一个commit对象

upstream分支::

    git branch --set-upstream-to=origin/master
    or
    git branch -u origin
    // 参见文件 .git/config

    git push -u




