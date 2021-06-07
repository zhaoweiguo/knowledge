laravel4.2版
=================


注意::
  
    每个文件对应一个类,文件名要和类一相同


  
* 要先安装 `composer <http://getcomposer.org>`_

* 安装::

    composer create-project laravel/laravel your-project-name --prefer-dist
    or
    wget https://github.com/laravel/laravel/archive/master.zip

* Serving Laravel::

    php artisan serve    // 默认为8000
    or
    php artisan serve --port=8080



* 部署环境时要在下载项目之后执行 ``composer install``
* 记得执行 ``composer dump-autoload`` 自动加载，以防止出现找不到类的情况(报 ``PHP Fatal error: Class '<xxxx>' not found in vendor/laravel/framework/src/Illuminate/Database/Migrations/Migration.php`` 错)

* 具体还要执行::

    cp server.php index.php
    chmod -R 777 app/storage/meta
    chmod -R 777 app/storage/sessions
    chmod -R 777 app/storage/logs
    chmod -R 777 app/storage/cache



::

    app/config/app.php
    bootstrap/paths.php
    app/database/migrations     // 生成的表结构文件
    app/start/global.php    // 定义
    

::

    Config::get('app.timezone');    //access a configuration value
    $timezone = Config::get('app.timezone', 'UTC');     // 'UTC', 'PRC'
    Config::set('database.default', 'sqlite');    // set a configuration value

::

    php artisan migrate:make <create_users_table>    // 创建表
    php artisan migrate:install
    php artisan migrate:refresh



要可写的目录::

    /storage
    
