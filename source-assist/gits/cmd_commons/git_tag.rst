git tag命令
##################
查看标签列表::

    git tag    //查看本地标签列表
    or
    git ls-remote origin     //查看远端标签列表

    //查看指定标签详情:
    git show <tagName>


删除标签::

    git tag -d <tagName>
    git push origin :refs/tags/<tagName>   // 删除远端服务器的标签
    or
    git push origin :<tagname>

    git show 命令查看相应标签的版本信息，并连同显示打标签时的提交对象:
    git show <tagName>

    git fetch <Name>   // 要抓取所有<Name>有的,但本地仓库没有的信息,可以运行


新建标签::

    git tag <tagName>
    or
    git tag -a <tagName> -m "<commit>"
    or
    git tag -a <tagName> <recordId>  %在历史上指定的记录上加tag


把本地标签push到远程分支::

    git push refs/tags/<tagName>
    or
    git push origin --tags
    or
    git push --tags
    or
    git push origin <tagname>






