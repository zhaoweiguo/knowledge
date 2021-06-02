laravel共有功能
=====================



laravel项目初使化::

  1.用Laravel Installer创建项目
  //用Composer下载Laravel installer
  composer global require "laravel/installer"
  laravel new <projectName>

  2.用Composer创建项目
  composer create-project --prefer-dist laravel/laravel <projectName>

   // 下载指定版本的laravel
   composer create-project --prefer-dist laravel/laravel=5.0.* <projectName> 




其他::

  
  php artisan key:generate     // 生成app key


打印日志::

  DB::connection()->enableQueryLog(); // 开启查询日志
  DB::table('xxx'); // 要查看的sql
  $queries = DB::getQueryLog(); // 获取查询日志
  print_r($queries); // 即可查看执行的sql，传入的参数等等



   
