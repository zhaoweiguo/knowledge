hexo常见应用
=================

主要网站::

  https://hexo.io/
  https://github.com/hexojs/hexo

安装::

    $ npm install -g hexo-cli

    // 图片相关
    $ npm install hexo-asset-image --save


基本用法::

  // 初始化
  $ hexo init <folder>
  $ cd <folder>
  $ npm install

  // 新增文章
  $ hexo new [layout] <title>

  // 生成静态文件
  $ hexo generate

  // 启动本地服务
  $ hexo server

  // 部署网站
  $ hexo deploy
  -g, --generate  部署前先生成静态文件
  $ hexo deploy -g

文件结构::

  .
  ├── _config.yml
  ├── package.json
  ├── scaffolds
  ├── source
  |   ├── _drafts
  |   └── _posts
  └── themes

git::

  $ npm install hexo-deployer-git --save
  deploy:
    type: git
    repo: <repository url>
    branch: [branch]
    message: [message]














