.. _curl:

curl命令简析
=================
常见用法::

    -v: 调试时用
    -i: 全部显示
    -I: 只显示头部
    -r: 断点续传指定传输范围

  用法: curl [选项...] <url>
  curl中数据为json时, 最好都用双引号,里面用 ``\"`` 进行转义

各类method请求::

    //GET method
    curl www.hotmail.com/when/junk.cgi?birthyear=1905&press=OK
    //POST method::
    curl -d "birthyear=1905&press=OK" www.hotmail.com/when/junk.cgi
    //新的POST method(将本地的文件用POST上传到服务器)::
    curl -F upload=@localfilename -F press=OK URL
    //使用PUT::
    curl -T uploadfile www.uploadhttp.com/receive.cgi
    curl -X PUT -d "field1=value1&field2=value2" http://testzgapi4.taojoy.com.cn
    // 请求指定并显示请求内容，常用于请求可执行文件，并执行
    curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sudo sh -s 

有关认证(参数中指定用户名而空着密码，curl可以交互式的让用户输入密码)::

    curl -U proxyuser:proxypassword http://curl.haxx.se

referer 引用::

    -e, --referer <URL>
    如:
    curl -e Url1 Url2

指定用户端::

    curl -A "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" URL
    // ipad safari
    curl -A "Mozilla/5.0 (iPad; CPU OS 7_1_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D201 Safari/9537.53" <URL>
    // iphone 5c weixin
    "Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B440 MicroMessenger/6.0.2 NetType/WIFI"
    // 华为 微信
    "Mozilla/5.0 (Linux; U; Android 4.2.2; zh-cn; HUAWEI G716-L070 Build/HuaweiG716-L070) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30 MicroMessenger/6.0.0.54_r849063.501 NetType/WIFI"
    // 华为 内置浏览器
    "Mozilla/5.0 (Linux; U; Android 4.2.2; zh-cn; HuaweiG716-L070_LTE Build/HuaweiG716-L070_LTE) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
    
COOKIES::

    curl -b cookies.txt -c newcookies.txt www.cookiesite.com

加密HTTP::

    curl https://that.secure.server.com

json請求的語法::

    curl http://192.168.10.102:8000/tongji/baseinfo -H "Accept:application/json"
    curl http://192.168.10.102:8022/tongji/baseinfo -H "Accept:application/json" -d "rid=\"rid\"&sim=\"sim\"&mac=\"mac\"&imei=\"imei\"&device=\"device\"\&&resolution=\"resolution\"&os=\"android\"&&osversion=\"osversion\"&&timestamp=\"431432143214\""   

multipart/form-data 类型请求::

    // 这种是正式的
    // http.content_type: multipart/form-data; boundary=----------------------------8ed7c16ae35a
    // 多个form间用boundary关联，多个form使用同一个boundary
    curl -v http://127.0.0.1:9090/addservice -include --form key=1122-3434 --form destName=hello.test.unit --form upload=@/tmp/localfile
    // 指定boundary的例子@undo
    curl -X POST -H "Content-Type: multipart/form-data; boundary=----------------------------4ebf00fbcf09" -d $'------------------------------4ebf00fbcf09\r\nContent-Disposition: form-data; name="example"\r\n\r\ntest\r\n------------------------------4ebf00fbcf09--\r\n' http://localhost:3000/test

    //指定文件类型@undo
    curl -H "Content-Type: multipart/related" \
    --form "data=@example.jpg;type=image/jpeg" http://localhost:3000/test


    // 指定为multipart/form但没有
    curl -v -XPOST -H 'Content-Type: multipart/form-data' http://192.168.35.141:9090/addservice?key=1122-3434&destName=hello.test.unit&zkidc=qa


翻墙相关::

    // -x, --proxy <[protocol://][user:password@]proxyhost[:port]>
    // 默认为http协议
    curl -x socks5://192.168.14.40:6500 "http://www.youtube.com"   // 要注意dns混乱问题


实例::

  // -L: --location, 如果有301等跳转的话，自动访问新location
  // -O: --remote-name, 下载后的文件名同远程文件相同
  curl -LO https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.4.9.tgz









选项
--------

通用::

    (H) 指只适用于http/https
    (F)指只适用于ftp

    -a/--append
    Append to target file when uploading

    -A/--user-agent
    User-Agent to send to server

    --anyauth
    Pick "any" authentication method

    -b/--cookie
     Cookie string or file to read cookies from

    -d, --data <data>

时间相关::

    -m/--max-time <seconds>
     整个过程中要花费的最长时间(秒), 防止因网络慢或链接失效(参考:--connect-timeout).

    --connect-timeout <seconds>
     允许到

    -I/--head
    (HTTP/FTP/FILE)只获取http头！当使用FTP or FILE文件,curl只显示文件大小和最后修改时间

    -s/--silent
     静默模式！不显示进度条和错误显示！

    -o/--output <file>
     把输入改为写入到指定文件(默认是stdout):
         curl http://{one,two}.site.com -o "file_#1.txt"
         curl http://{site,host}.host[1-5].com -o "#1_#2"

    -O/--remote-name
     Write output to a local file named like the remote file we get. (Only the file part of the remote file is used, the path is cut off.)::

         curl -O http://<url>/<file>.tar.gz

    -L/--location
     (HTTP/HTTPS) If the server reports that the requested page has moved to a different location (indicated with a Location: header and a 3XX  response  code),  this  option will make curl redo the request on the new place.(php等动态语言的文件需要加L才能下载下来)

证书相关::

    --cacert <CA certificate>
    设定ca证书,证书必须是PEM格式,可以包含多个CA证书.
    自动查找名为curl-ca-bundle.crt的文件(当前目录、curl.exe文件对应目录、PATH目录)
    --capath <dir>

断点续传::

    -C, --continue-at <offset>
    -r, --range <range>
        (HTTP FTP SFTP FILE) Retrieve a byte range (i.e a partial document) 
          from  a  HTTP/1.1,  FTP  or  SFTP server or a local FILE. 
        Ranges can be specified in a number of ways.


.. warning::

   为啥有的时候要对url地址加入到双引号中?


实例::

    % default: "text/html"
    curl -i http://localhost:8080
    curl -i -H "Accept: application/json" http://localhost:8080
    curl -i -H "Accept: text/plain" http://localhost:8080
    curl -i -H "Accept: text/css" http://localhost:8080

HTTP/2
------------
::

    nghttp -v http://localhost:8080
    nghttp -v -H "accept: application/json" http://localhost:8080
    nghttp -v -H "accept: text/plain" http://localhost:8080
    nghttp -v -H "accept: text/css" http://localhost:8080

实例::

  curl -i --data-urlencode paste@- localhost:8080
  curl -i --data-urlencode paste@my_file localhost:8080
  curl -i --data-urlencode paste@priv/index.html localhost:8080

查看此网站web服务器::

  curl -s -I http://blog.programfan.info | grep Server




实例
----------

断点续传::

    // normal(explicitly specified start AND end)
    curl -v -X GET -H "range: bytes=1-8" http://localhost:8080/bbb/test

    // specified ONLY start(end will be specified at the end of file)
    curl -v -X GET -H "range: bytes=10-" http://localhost:8080/bbb/test

    // specified ONLY one negative value(last N bytes of file will be retrieved)
    curl -v -X GET -H "range: bytes=-11" http://localhost:8080/bbb/test

    // multi(specified multi ranges by using comma)
    curl -v -X GET -H "range: bytes=0-8,10-" http://localhost:8080/bbb/test

    // ?
    curl -v -r 0-500 http://somefile -o localfile

上传json文件::

    curl -v -i -X POST -H "Content-Type: application/json" \
        -H "Accept: application/json" -H "Authorization:Basic <用户名和密码的base64>=" \
        http://localhost:3000/api/dashboards/db -d@1.json

    用户名和密码的base64: base64(user:passwd)
    $ echo -n "user:passwd" | base64
    dXNlcjpwYXNzd2Q=

    $ curl -v -X POST   http://localhost:3000/api/dashboards/db  \
         -H 'Accept: application/json'   -H 'Authorization: Basic dXNlcjpwYXNzd2Q='  \
         -H 'Content-Type: application/json'   -d @abc.json

.. warning:: 注意，-X后面的POST是大写





