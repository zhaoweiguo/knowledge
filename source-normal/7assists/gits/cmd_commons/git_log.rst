.. _git_log:

git log浏览日志
#########################
常用命令::

    $git log //查看历史日志
    $ git log --pretty=fuller   // 查看详细日志

    git log -p
    -p, -u, --patch
    Generate patch (see section on generating patches).

    $ git log -p filepath 查看某个文件的详细修改

    % 此命令和上面不同的是rename的也会监控
    $ git log -p --follow

详细的git log 语法如下::

    git log [<options>] [<since>..<until>] [[--] <path>...]
    主要参数选项如下:
    -p：按补丁显示每个更新间的差异
    --stat：显示每次更新的修改文件的统计信息
    --shortstat：只显示--stat中最后的行数添加修改删除统计
    --name-only：尽在已修改的提交信息后显示文件清单
    --name-status：显示新增、修改和删除的文件清单
    --abbrev-commit：仅显示SHA-1的前几个字符，而非所有的40个字符
    --relative-date：使用较短的相对时间显示（例如："two weeks ago"）
    --graph：显示ASCII图形表示的分支合并历史
    --pretty：使用其他格式显示历史提交信息





显示统计补丁::

    git log --stat

调整显示格式::

    //<format>格式有oneline，short，medium，full，fuller，email，raw:
    git log --pretty=<format>

    //自定义格式:
    git log --pretty=format:"<format>"
    %ad  author date  // 日期
    %an author name // 作者名
    %cn committer name //提交者姓名
    %h SHA hash // hash值
    %s subject //commit的描述
    %d  ref names //对应的 branch 分支名
    %H      提交对象（commit）的完整哈希字串               
    %h      提交对象的简短哈希字串               
    %T      树对象（tree）的完整哈希字串                   
    %t      树对象的简短哈希字串                    
    %P      父对象（parent）的完整哈希字串               
    %p      父对象的简短哈希字串                   
    %an     作者（author）的名字              
    %ae     作者的电子邮件地址                
    %ad     作者修订日期（可以用 -date= 选项定制格式）                   
    %ar     作者修订日期，按多久以前的方式显示                    
    %cn     提交者(committer)的名字                
    %ce     提交者的电子邮件地址                    
    %cd     提交日期                
    %cr     提交日期，按多久以前的方式显示              
    %s      提交说明  
    //实例:
    git log --pretty=format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"

    //分枝拓扑图:
    // --pretty=oneline: 一个提交1行表示
    // --graph: 图形
    git log --pretty=oneline --graph

日期区间::

    //git log'命令后如果跟-before和-after选项，就会显示两个日期之间的提交条目:
    // 2018年6月26日到2周间这段时间
    // 
    git log --before="2 weeks ago" --after="2018-06-26" --pretty=oneline


贡献者过滤器::

    //查找作者名（author）为Gordon，在过去两周内的所有提交条目:
    git log --author=Gordon --since="14 days ago" --pretty=oneline

    //查找作者名为Gordon提交的补丁数对应的email列表:
    git log --author=Gordon --pretty=format:"%ae"

    //查找作者名为Gordon提交的补丁数:
    git log --author=Gordon --pretty=format:"%ae" | wc -l

    //在大型开源项目中一个author有多个作者
    //如下源码项目有113个gmail账户的作者贡献的1348个补丁:
    $ git log --author="赵 卫国" --pretty=format:"%ae" | wc -l
     1348
    $ git log --author="赵 卫国" --pretty=format:"%ae" | sort -u | wc -l
     113


查找相关::

    // 提交信息内容查找
    //搜索在提交信息中含有'c90'的所有提交内容:
    git log --grep='C90' --pretty=oneline

    //文件历史:
    //查看'notes.c'文件每一次的提交历史:
    git log --pretty=oneline -- notes.c

其他选项::

    //查看非合并的提交历史记录:
    git log --pretty=oneline --no-merges

    //在查看日志命令最后加上-N来查看满足条件的最近的N条历史记录:
    git log --pretty=oneline --no-merges -5

    //我们可以这样指定查询:
    git log --pretty=oneline ff7534..eff474

    //想查看'experiment'分枝上还没有合并的提交记录::

    git log master..experiment --pretty=oneline

查看不同时间段的 git log::

    git log --until=1.minute.ago // 一分钟之前的所有 log
    git log --since=1.day.ago //一天之内的log
    git log --since=1.hour.ago //一个小时之内的 log
    git log --since=`.month.ago --until=2.weeks.ago //一个月之前到半个月之前的log
    git log --since ==2013-08.01 --until=2013-09-07 //某个时间段的 log


实例
====

获取git commit版本::

    $ git log --abbrev-commit --pretty=oneline -1 | cut -c 1-7
    返回: b0f7ff5

    说明:

    --abbrev-commit: 使用简化的 commitID
    --pretty=oneline: 每个 commit 只保留第一行
    -1 取第一个 commitID 行
    cut -c 1-7 取 commitID 行中 commitID 号

    其他相关可参考git describe命令







