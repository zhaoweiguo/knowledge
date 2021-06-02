hexo常见问题
==================

执行hexo deploy -g没有反应::

  hexo使用的配置文件是yml，而yml需要在key和value间的:号后有个空格
  deploy:
    type: git
    repo: ssh://git@github.com:zhaoweiguo/abc123.git
    branch: master

hexo categories和tags页面不显示解决办法 [1]_ ::

    // 方法1
    1. scaffolds/draft.md
    ---
    title: {{ title }}
    tags: {{ tags }}
    ---

    2. scaffolds/post.md

    ---
    title: {{ title }}
    date: {{ date }}
    tags: {{ tags }}
    ---

    // 方法2
    3. 默认是没有 categories 和 tags 的需要

    3.1 tags
    hexo new page tags
    确认站点配置文件里有tag_dir: tags
    确认主题配置文件里有tags: /tags
    编辑站点的source/tags/index.md，添加

    编辑 /tags/index.md
    type: "tags"
    layout: "tags"

    3.2 categories
    hexo new page categories
    确认站点配置文件里有category_dir: categories
    确认主题配置文件里有categories: /categories
    编辑站点的source/categories/index.md，添加

    编辑 /categories/index.md
    type: "categories"
    layout: "categories"


hexo categories和tags页面去除commit方法 [2]_ ::

    // 编辑 /tags/index.md /categories/index.md, 增加
    comments: false




.. [1] https://blog.csdn.net/winter_chen001/article/details/79719154
.. [2] https://blog.csdn.net/qq_42247008/article/details/85003789