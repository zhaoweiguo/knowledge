laravel5.1
================
::

   // 启动一个新的laravel项目
   laravel new <blog>
   or
   composer create-project laravel/laravel <blog> --prefer-dist
   or
   git clone https://github.com/laravel/quickstart-basic quickstart
   cd quickstart
   composer install
   php artisan migrate

上线前其他准备工作::

   // 生成密钥(本质是修改.env文件)
   php artisan key:generate
   // 配置相关
   //Directory Permissions目前权限——以下目录要有可定权限
   storage/
   bootstrap/cache/

其他配置::
   
   // Configuration Caching
   php artisan config:cache     //生产环境用，把配置文件合并到一个文件中，加快framework的load
   //Application Key
   key should been set by the key:generate command
   //修改配置文件config/app.php
   timezone
   locale

   // 配置文件的设置
   $value = config('app.timezone');                  // get方法
   config(['app.timezone' => 'America/Chicago']);    // set方法

   // 修改你的应用（暂不用）
   php artisan app:name Horsefly

   //维护模式
   php artisan down    // 启用
   php artisan up      // 关闭
   // 启用时会抛出code为503的HttpException，并打开默认页面resources/views/errors/503.blade.php

   //Database Migrations
   //在database/migrations目录下生成数据表操作文件
   php artisan make:migration create_tasks_table --create=<tasks>
   // 执行database/migrations目录下文件的数据表修改
   php artisan migrate

   //Eloquent is Laravel's default ORM (object-relational mapper).
   php artisan make:model <Task>
   

   
日志::

   single —— 将日志记录到单个文件中。该日志处理器对应Monolog的StreamHandler。
   daily —— 以日期为单位将日志进行归档，每天创建一个新的日志文件记录日志。该日志处理器 对应Monolog的RotatingFileHandler
   syslog —— 将日志记录到syslog中。该日志处理器 对应Monolog的SyslogHandler。
   errorlog —— 将日志记录到PHP的error_log中。该日志处理器 对应Monolog的ErrorLogHandler

   
   //如果这四种方式满足不了你的需求，还可以使用configureMonologUsing方法完全控制Monolog的日志处理器
   //必须将上述这段代码置于bootstrap/app.php文件返回$app之前处才能生效
   $app->configureMonologUsing(function($monolog) {
       $monolog->pushHandler(...);
   });

Exception::

  所有异常都由类App\Exceptions\Handler处理，该类包含两个方法：report和render
  report方法用于记录异常并将其发送给外部服务如Bugsnag
  
队列::

  // 会一直请求队列
  nohup php artisan queue:listen &
  // 如果队列里没有数据，会暂停3秒
  nohup php artisan queue:listen --sleep=3 &


  // 执行一次,但可以把此句放到crontab中实现定时
  php artisan queue:work

  有时需要指定哪个队列,如
  php artisan queue:work <queueName>
  or
  php artisan queue:listen <queueName>
  //这儿的<queueName>是从 config/queue.php 中取得

  Artisan::command('email:send {user}', function (DripEmailer $drip, $user) {
      $drip->send(User::find($user));
  });
  
