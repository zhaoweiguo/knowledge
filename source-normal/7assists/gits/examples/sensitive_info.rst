.. _git_sensitive:

git实例-敏感信息过滤 [1]_
#########################


* git提供了一组后缀为.sample的钩子，将其pre-commit.sample重命名为pre-commit至于仓库.git/hooks下即可保证pre-commit在提交前被执行。
* git config –global配置全局和不同仓库的敏感词列表。
* 拷贝(如无则创建)git-template/hooks文件夹，并设置为init.templatedir,这样每次用户执行git init(任意一次)时，都会将其git-templates目录下的内容全部拷贝到当前仓库的.git目录下。
* 编辑pre-commit文件，提取提交内容并判断是否包含了已配置的敏感词列表，如果包含，错误提醒用户并终止commit。



.. literalinclude:: /files/gits/commit-guard.sh

.. literalinclude:: /files/gits/pre-commit


.. [1] https://kangwang1988.github.io/tech/2016/07/08/filter-sensitive-words-pre-git-commit.html