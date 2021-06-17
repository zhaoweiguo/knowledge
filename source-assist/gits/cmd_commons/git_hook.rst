git hook命令
======================

* 官网 [1]_

Git Hook 最常见的使用场景包括::

  1.推行提交信息规范
  2.根据仓库状态来改变项目环境
  3.接入持续集成工作流。

​ git hook(钩子)是一种方便用户在git的各阶段执行自定义操作的机制，默认情况下，所有的hook都存储在git仓库的.git/hooks文件夹里。

服务端支持的钩子包括::

    pre-receive:当服务器处理来自客户端的push请求时。
    update:当每个分支上，pusher意图更新内容时。
    post-receive:当整个receive过程结束可用来update时。

客户端支持的钩子包括::

    pre-commit:在键入commit消息之前执行，返回非零可以中止commit。可以在此阶段执行代码检查等工作，git commit --no-verify可以越过pre-commit钩子。
    prepare-commit-msg:在commit message编辑器被唤醒后，但默认消息创建前执行。可结合commit 模板在此阶段编程插入信息。
    commit-msg:传入一个包含提交信息的临时文件路径作为参数，可在此验证工程状态，提交信息等，返回非零值将中止提交过程。
    post-commit:当整个commit过程结束后执行。通常用来做类似通知的事情。
    pre-rebase:在rebase之前执行，可通过返回非零值中断此过程。
    post-rewrite:当执行替换commit如(git commit --amend或git rebase)的时候执行。
    post-checkout:当成功执行git checkout之后执行，可在此阶段配置正确的项目开发环境。
    post-merge:当成功执行merge之后执行，可使用它恢复权限数据等git无法追踪的工作树数据。
    pre-push:当远端已经updated，但在所有对象被传输之前执行。可使用它来验证更新引用，返回非零可中断push过程。
    pre-auto-gc: git会时不时在操作中调用git gc --auto执行垃圾收集操作，在垃圾收集之前pre-auto-gc钩子被执行。


实例
------

:ref: `敏感信息过滤 <git_sensitive>`_









.. [1] https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks