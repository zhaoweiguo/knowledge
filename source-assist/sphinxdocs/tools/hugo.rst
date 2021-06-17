Hugo
####

类似hexo的md静态网站生成器

* 官网 [1]_
* netlify官网 [2]_
* github [3]_
  
netlify类似gitlab的静态网站托管

安装::

    brew install hugo

    源码安装:
    $ go get -v github.com/spf13/hugo

使用
====

1. 生成站点::

    $ hugo new site /path/to/site

2. 创建文章::

    创建一个 about 页面(生成到content目录)
    $ hugo new about.md

    创建第一篇文章，放到 post 目录
    $ hugo new post/first.md

3. 运行Hugo::

    执行 Hugo 命令进行调试：
    $ hugo server --theme=hyde --buildDrafts
    浏览器里打开： http://localhost:1313

4. 部署::

    $ hugo --theme=hyde --baseUrl="http://zhaoweiguo.github.io/"

.. note:: 注意，以上命令并不会生成草稿页面，如果未生成任何文章，请去掉文章头部的 draft=true 再重新生成。如果一切顺利，所有静态页面都会生成到 public 目录。








站点目录结构::

    ▸ archetypes/
    ▸ content/
    ▸ layouts/
    ▸ static/
      config.toml

.. [1] https://www.gohugo.org/
.. [2] https://www.netlify.com/
.. [3] https://github.com/gohugoio/hugo