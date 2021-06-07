npm命令
##################

* http://npmjs.org/::

    git clone https://github.com/isaacs/npm.git


常见命令
========

基本::

    npm -v #显示版本，检查npm 是否正确安装。
    npm init    //初使化, 生成package.json文件(可以用此察看此文件的结构)

install命令::

    npm install express #安装express模块
    npm install -g express #全局安装express模块
    npm install --global express    //--global进行全局安装，这样我们才可以在任何路径下使用gulp命令
    npm install express --save  // 添加--save-dev选项，把express模块安装依赖里
    // save-dev选项，把gulp模块安装在开发依赖里
    npm install express --save-dev  // gulp仅仅是开发辅助工具，只在本地开发机器上使用，因此上述命令添加--

run命令::

    npm run xxx 命令基本是执行「package.json」文件中的scripts字段下面的命令, 如:
    "scripts": {
      "prebuild": "rm -rf dist/files",
      "build": "cross-env NODE_ENV=production webpack"
    }
    则:
    npm run build 本质是执行 cross-env NODE_ENV=production webpack


其他::

    npm list #列出已安装模块
    npm show express #显示模块详情
    npm update #升级当前目录下的项目的所有模块
    npm update express #升级当前目录下的项目的指定模块
    npm update -g express #升级全局安装的express模块
    npm uninstall express #删除指定的模块



配置相关::

  npm config list

  // 设定配置
  npm config set registry=http://registry.npmjs.org
  npm -g --registry http://registry.cnpmjs.org  install appium
  
  // taobao版
  npm config set registry https://registry.npm.taobao.org --global
  npm config set disturl https://npm.taobao.org/dist —global



  step 1. 下载源代码，比如 https://github.com/appium/appium/archive/v0.17.6.tar.gz， 0.17.6 的源代码。
  step 2. 解压到目录，比如 appium-0.17.6
  step 3. sudo npm config set registry=http://registry.npmjs.org 或者 npm config set registry=http://registry.npmjs.org
  step 4. npm install -g appium-0.17.6

  
npm国内镜像介绍::

    1.通过config命令

    npm config set registry https://registry.npm.taobao.org
    npm info underscore （如果上面配置正确这个命令会有字符串response）
    2.命令行指定

    npm --registry https://registry.npm.taobao.org info underscore
    3.编辑 ~/.npmrc 加入下面内容

    registry = https://registry.npm.taobao.org
    搜索镜像: https://npm.taobao.org

    建立或使用镜像,参考: https://github.com/cnpm/cnpmjs.org

  
node之版本升级和管理::

    $ curl https://raw.github.com/creationix/nvm/v0.4.0/install.sh | sh//安装nvm管理器
    nvm install 0.11.12//安装node0.11.12版本
    nvm ls//查看当前已经安装的版本，上面第一种方法n也可以通过ls查看

    nvm use 0.11.12//使用0.11.12作为当前版本。

    https://github.com/creationix/nvm
