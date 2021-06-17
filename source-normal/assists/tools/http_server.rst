http server工具
###############

各语言版http server
------------------------

node版::

    // http server软件
    npm install -g http-server
    // 使用
    http-server &


python版::

    python -m SimpleHTTPServer 8888 &

    如果是Python 3+
    python -m http.server 8888 &

shell版::

    nc命令

golang版::

    $ go get -u github.com/shurcooL/goexec

    $ goexec 'http.ListenAndServe(`:8080`,http.FileServer(http.Dir(`.`)))'


轻量级的http server
------------------------

tinyhttpd [1]_::

  源码分析:https://blog.csdn.net/jcjc918/article/details/42129311
  其他:
    http://www.acme.com/software/mini_httpd/


Mongoose [2]_::

  官网: https://cesanta.com/
  其他:
    https://github.com/liigo/tinyweb/
    https://github.com/Akagi201/libuv-webserver
    https://github.com/haywire/haywire
    https://github.com/h2o/h2o



.. [1] https://github.com/EZLippi/Tinyhttpd
.. [2] https://github.com/cesanta/mongoose










