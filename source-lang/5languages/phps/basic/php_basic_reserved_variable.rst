.. _php_basic_reserved_variable:

php预定义变量
==================

* 超全局变量:

    * $GLOBALS: 引用全局作用域中可用的全部变量, 一个包含了全部变量的全局组合数组。变量的名字就是数组的键
    * $_SERVER: 服务器和执行环境信息
    * $_GET: http的GET方法，$_GET["param"]
    * $_POST: http的POST方法，$_POST["param"]
    * $_FILES: 通过 HTTP POST 方式上传到当前脚本的项目的数组
    * $COOKIE: 通过 HTTP Cookies 方式传递给当前脚本的变量的数组 ``$_COOKIE["name"]``
    * $_REQUEST: 默认情况下包含了 $_GET，$_POST 和 $_COOKIE 的数组
    * $_SESSION: 当前脚本可用 SESSION 变量的数组
    * $_ENV: 通过环境方式传递给当前脚本的变量的数组 ``$_ENV["USER"]``

* 其他预定义变量:

    * $php_errormsg: 前一个错误信息, 这个变量仅在 php.ini 文件中的 track_errors 配置项开启的情况下可用
    * $HTTP_RAW_POST_DATA — 原生POST数据
    * $http_response_header — HTTP 响应头
    * $argc — 传递给脚本的参数数目
    * $argv — 传递给脚本的参数数组


