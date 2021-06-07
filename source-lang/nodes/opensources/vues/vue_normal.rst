vue常见资料
###############


安装::

  # 全局安装 vue-cli
  $ npm install --global vue-cli
  # 创建一个基于 webpack 模板的新项目
  $ vue init webpack my-project
  # 安装依赖，走你
  $ cd my-project
  $ npm run dev



1 使用nodeJs安装Vue-cli::

    1.1 sudo apt-get install nodejs     # 安装nodejs
    1.2 sudo apt-get install npm        # 安装npm
    1.3 cnpm install --global vue-cli   # 全局安装 vue-cli

2 初始化项目::

    2.1 vue init webpack my-project    # 使用webpack初始化项目:
    输入命令后，会询问我们几个简单的选项，我们根据自己的需要进行填写就可以了。
    a)  Project name :项目名称 ，如果不需要更改直接回车就可以了。注意：这里不能使用大写，所以我把名称改成了my-project
    b)  Project description:项目描述，默认为A Vue.js project,直接回车，不用编写。
    c)  Author：作者，如果你有配置git的作者，他会读取。
    d)  Install  vue-router? 是否安装vue的路由插件，我们这里需要安装，所以选择Y
    e)  Use ESLint to lint your code? 是否用ESLint来限制你的代码错误和风格。
          我们这里不需要输入n，如果你是大型团队开发，最好是进行配置。
    f)  setup unit tests with  Karma + Mocha? 
          是否需要安装单元测试工具Karma+Mocha，我们这里不需要，所以输入n。
    g)  Setup e2e tests with Nightwatch?
          是否安装e2e来进行用户行为模拟测试，我们这里不需要，所以输入n。

    2.2 cd my-projcet   # 进入vue项目目录
    2.3 npm install       # 安装 项目依赖包，也就是package.json里的包
    2.4 npm run dev    # 开发模式下运行程序
    2.5 浏览器访问：localhost:8080  #默认端口8080

3 Vue项目结构::

    .
    |-- build                            // 项目构建(webpack)相关代码
    |   |-- build.js                     // 生产环境构建代码
    |   |-- check-version.js             // 检查node、npm等版本
    |   |-- dev-client.js                // 热重载相关
    |   |-- dev-server.js                // 构建本地服务器
    |   |-- utils.js                     // 构建工具相关
    |   |-- webpack.base.conf.js         // webpack基础配置
    |   |-- webpack.dev.conf.js          // webpack开发环境配置
    |   |-- webpack.prod.conf.js         // webpack生产环境配置
    |-- config                           // 项目开发环境配置
    |   |-- dev.env.js                   // 开发环境变量
    |   |-- index.js                     // 项目一些配置变量
    |   |-- prod.env.js                  // 生产环境变量
    |   |-- test.env.js                  // 测试环境变量
    |-- src                              // 源码目录
    |   |-- components                     // vue公共组件
    |   |-- store                          // vuex的状态管理
    |   |-- App.vue                        // 页面入口文件
    |   |-- main.js                        // 程序入口文件，加载各种公共组件
    |-- static                           // 静态文件，比如一些图片，json数据等
    |   |-- data                           // 群聊分析得到的数据用于数据可视化
    |-- .babelrc                         // ES6语法编译配置
    |-- .editorconfig                    // 定义代码格式
    |-- .gitignore                       // git上传需要忽略的文件格式
    |-- README.md                        // 项目说明
    |-- favicon.ico 
    |-- index.html                       // 入口页面
    |-- package.json                     // 项目基本信息

4 解读Vue的模板:

* 4.1 npm run dev命令::

    package.json的scripts 字段：
      "scripts": {
        "dev": "node build/dev-server.js",
        "build": "node build/build.js"
      },

* 4.2 main.js文件
    main.js是整个项目的入口文件,在src文件夹下

.. image:: /images/languages/nodes/vues/vue_install1.jpg


* 4.3 App.vue文件

.. image:: /images/languages/nodes/vues/vue_install2.jpg
     
* 4.4 router/index.js

.. image:: /images/languages/nodes/vues/vue_install3.jpg
     
* 4.5 Hello.vue

.. image:: /images/languages/nodes/vues/vue_install4.jpg






