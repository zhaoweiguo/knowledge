git describe命令
################

git describe命令显示离当前提交最近的标签。

格式::

    $ git describe [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>…​]
    $ git describe [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]

输出::

    <tag>_<numCommits>_g<hash>

    说明:
    // tag 表示的是离 ref 最近的标签
    // numCommits 是表示这个 ref 与 tag 相差有多少个提交记录
    // hash 表示的是你所给定的 ref 所表示的提交记录哈希值的前几位

实例1::

    $ git describe
    v1.0.3-6-g0c2b1cf　

    说明:
    1、6:表示自打tag v1.0.3以来有6次提交（commit）
    2、g0c2b1cf：g 为git的缩写，在多种管理工具并存的环境中很有用处
    3、0c2b1cf：7位字符表示为最新提交的commit id 前7位

实例2::

    $ git describe --tags --always --dirty="-dev"
    v1.0.3-6-g0c2b1cf-dev

    说明:
    1、如果当前版本已经有tag则直接输出此tag名：v1.0.3
    2、如果不是，则输出v1.0.3-6-g0c2b1cf，含义如上面所述
    3、如果本地仓库有修改，则认为是dirty的，则追加-dev，表示是开发版：v1.0.3-6-g0c2b1cf-dev


其他::

    类似命令
    $ git log --abbrev-commit --pretty=oneline -1 | cut -c 1-7







