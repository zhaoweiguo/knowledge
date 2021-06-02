http相关操作
######################################

请求修改header的案例::

    header("Cache-Control: private, must-revalidate, proxy-revalidate");
    header("ETag: " . substr($etag, 0, 18)); // 指定etag
    header("Content-type: image/jpeg");    //指定文本类型——图片
    header("Content-length: " . filesize("fingerprinting.jpg"));    // 指定图片内容
    readfile("fingerprinting.jpg");      //读出文本内容，即可显示出来


PHP获取当前URL URI 等server相关信息::

  $uri = $_SERVER['REQUEST_URI'];
  $port = $_SERVER["SERVER_PORT"];
  $http = (isset($_SERVER['HTTPS'])&&$_SERVER['HTTPS']!='off')?'https://':'http://';
  $url = 'http://'.$_SERVER['SERVER_NAME'].':'.$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];

  $_SERVER 是一个包含诸如头部(headers)、路径(paths)和脚本位置(script locations)的数组

  // 其他详细说明
  REQUEST_METHOD   如: “GET”、“HEAD”，“POST”，“PUT”
  SERVER_PROTOCOL  如: “HTTP/1.0”
  QUERY_STRING     查询(query)的字符串
  HTTP_REFERER
  HTTP_USER_AGENT
  REMOTE_ADDR:   正在浏览当前页面用户的 IP 地址


