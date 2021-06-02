hexo命令
===============

基本配置: https://hexo.io/docs/configuration.html

基本命令::

  // 新增文章
  $ hexo new [layout] <title>

  // 生成静态文件
  $ hexo generate

  // 发布草稿
  $ hexo publish [layout] <filename>

  // 启动本地服务
  $ hexo server

  // 部署网站
  $ hexo deploy
  -g, --generate  部署前先生成静态文件
  $ hexo deploy -g

  // render文件
  $ hexo render <file1> [file2] ...

  // 从其他系统中迁移
  $ hexo migrate <type>

  //清除缓存文件db.json和静态文件public
  $ hexo clean

  //列出所有路由
  $ hexo list <type>

  // 其他
  $ hexo version

可选用法::

  $ hexo --safe
  $ hexo --debug
  $ hexo --silent
  $ hexo --config custom.yml
  $ hexo --config custom.yml,custom2.json
  $ hexo --draft
  $ hexo --cwd /path/to/cwd


新增文章::

  $ hexo new [layout] <title>

  Layout  Path
  post  source/_posts
  page  source
  draft source/_drafts

文章标签::

  Setting Description Default
  layout  Layout  
  title Title 
  date  Published date  File created date
  updated Updated date  File updated date
  comments  Enables comment feature for the post  true
  tags  Tags (Not available for pages)  
  categories  Categories (Not available for pages)  
  permalink Overrides the default permalink of the post 

实例::

  categories:
  - Sports
  - Baseball
  tags:
  - Injury
  - Fight
  - Shocking
  tags: [Testing, Another Tag]

多目录层级::

  categories:
  - [Sports, Baseball]
  - Writes

