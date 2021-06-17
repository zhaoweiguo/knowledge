puer基本安装
======================
:作者: 新溪-gordon <programfan.info#gmail.com>
:创建时间: 20180417

os相关(debian 9)::

  // 基本
  apt-get install -y tmux emacs vim git-core curl tcpdump

MySQL相关::

  // 给指定用户赋权限
  grant SELECT, UPDATE, DELETE, INSERT, DROP, CREATE, ALTER, CREATE TEMPORARY TABLES, INDEX,REFERENCES
  on *.* to 'puer'@'%';



node相关::

  apt-get install sudo
  //Node.js 8（稳定版）:
  curl -sL https://deb.nodesource.com/setup_8.x | bash -
  apt-get install -y nodejs
  //Node.js 10（最新版）:
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get install -y nodejs

  可选择的:
  apt-get install -y build-essential

  其他:
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn


php相关::

  apt-get install php7.0-fpm
  apt-get install nginx

  //如想安装php7.2
  apt-get install apt-transport-https lsb-release ca-certificates
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
  sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
  apt-get update

  //安装相关软件
  apt install php7.2-fpm php7.2-mysql php7.2-curl php7.2-gd php7.2-mbstring php7.2-xml php7.2-xmlrpc php7.2-zip php7.2-bcmath -y





laravel项目安装::

  chmod -R 777 storage/*
  chmod -R 777 bootstrap/cache
  cp .env.example .env
  >> 修改里面的配置信息

  //laravel内置命令
  php artisan key:generate     // 生成app key
  php artisan migrate:refresh --seed

  //定时命令
  php artisan iot:sync        // 从阿里云取数据
  php artisan calculate:data  // 整理阿里云数据

node项目::

  // 安装依赖
  npm install
  // 打包发布版
  npm run build
  // 打包开发版
  npm run dev

  //其他
  //修改请求url地址
  ./src/utils/url.vue

NAS文件系统相关::

  // 安装依赖
  apt-get install -y nfs-common
  // 挂载
  sudo mount -t nfs -o vers=4.0 <挂载点域名>:<文件系统内目录> <当前服务器上待挂载目标目录>
  // 具体执行命令可在阿里云管理文件中看到









