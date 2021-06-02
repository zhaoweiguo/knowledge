vue的webpack
======================

QuickStart::

  $ npm install -g vue-cli
  $ vue init webpack my-project
  $ cd my-project
  $ npm install
  $ npm run dev

Project Struct::

  build/
    目录里面是「开发」和「生产」环境webpack的真实配置文件
  config/index.js
    build安装时常见的配置选项
  src/
    主要的应用代码
  static/
    静态文件，不需要webpack的
  test/unit
    单元测试代码
  test/e2e
    end to end test
  index.html
    入口文件

Build Commands::

  npm run dev     // 开发环境
  npm run build   // 生产环境
  npm run unit
  npm run e2e
  npm run lint


















