Laravel5.5
=====================


App相关命令::

  App::environment()   // 取.env里面APP_ENV的值
  App::environment(['local', 'stage'])    // .env里面APP_ENV的值是否等local或stage



常见命令::

  // 生成app_key
  php artisan key:generate  
  // 配置文件缓存化(注:env函数在config目录外不能再用)
  php artisan config:cache
  // 当更新代码等时可以暂停项目(Maintenance Mode)
  php artisan down
  php artisan down --message="Upgrading Database" --retry=60
  php artisan up

  // 查看make相关命令列表
  php artisan list make





  // 数据库相关
  php artisan migrate:refresh --seed




Migrations::

  $table->morphs('taggable'); 
  相当于增加2字段:
  taggable_id UNSIGNED INTEGER
  taggable_type VARCHAR



架构定义
------------


一个请求的生命周期(Request Lifecycle)::

  1.入口
  public/index.php
    ->bootstrap/app.php
      首先要做的事件是：create an instance of the application / service container.
      the HTTP kernel （http请求）
      or 
      the console kernel（console请求）
  2.下面基于http请求：
    app/Http/Kernel.php
      Illuminate\Foundation\Http\Kernel
        a.定义了bootstrappers数组（在请求被执行前运行）
          这个bootstrappers：
            a.配置错误处理
            b.配置日志
            c.检测应用环境
            d.运行其他请求前要处理的事
        b.定义一系列http中间件
    Service Providers
      最重要的Kernel bootstrapping actions是为你的应用载入「Service Providers」
      应用的所有Service Providers通过config/app.php文件的providers array配置
        1.the register method will be called on all providers
        2.the boot method will be called

      Service providers用于bootstrapping所有的framework's变量内容,如:
        database, queue, validation, and routing components.
          他们bootstrap and configure框架提供的每个属性, 
          他们是整个Laravel bootstrap进程中最重要的点.

    Dispatch Request
      一旦应用被bootstrapped且所有的service providers被注册，
      请求就会被handed off到the router for dispatching
      The router将分派请求到a route or controller或运行中间件

Service Container::

  「Service Container」是一强大工具，用于管理class dependencies 和 performing dependency injection
  
  深入理解Laravel service container对建立一个强大的应用
    或向Laravel核心贡献代码是非常必要的

    @todo
    https://laravel.com/docs/5.5/container









常见问题::

  1.SQLSTATE[42000]: Syntax error or access violation: 1071 Specified key was too long; max key length is 767 bytes (SQL: alter table `password_resets` add index `password_resets_email_index`(`email`))
  原因:如果你正在运行的 MySQL release 版本低于5.7.7 或 MariaDB release 版本低于10.2.2，为了MySQL为它们创建索引，你可能需要手动配置迁移生成的默认字符串长度，你可以通过调用 AppServiceProvider 中的 Schema::defaultStringLength 方法来配置它，或者你可以为数据库开启 innodb_large_prefix 选项，有关如何正确开启此选项的说明请查阅数据库文档。 
  实战：通过开启「innodb_large_prefix」参数成功
  2.