php内置web服务器
#####################

::

    php -S localhost:8080 -t foo/    // 指定php监听端口和web服务根目录

    // 在这个例子中，对图片的请求会返回相应的图片，但对HTML文件的请求会显示“Welcome to PHP
    php -S localhost:8000 router.php
    <?php
    // router.php
    if (preg_match('/\.(?:png|jpg|jpeg|gif)$/', $_SERVER["REQUEST_URI"])) {
      return false;    // serve the requested resource as-is.
    } else {
      echo "<p>Welcome to PHP</p>";
    }

    // 判断是否是在使用内置web服务器
    $ php -S localhost:8000 router.php
    <?php
    // router.php
    if (php_sapi_name() == 'cli-server') {
        /* route static assets and return false */
    }
        /* go on with normal index.php operations */

    // 处理不支持的文件类型
    $ php -S localhost:8000 router.php
    <?php
    // router.php
    $path = pathinfo($_SERVER["SCRIPT_FILENAME"]);
    if ($path["extension"] == "ogg") {
        header("Content-Type: video/ogg");
        readfile($_SERVER["SCRIPT_FILENAME"]);
    }
    else {
        return FALSE;
    }

    //远程访问这个内置Web服务器
    $ php -S 0.0.0.0:8000

