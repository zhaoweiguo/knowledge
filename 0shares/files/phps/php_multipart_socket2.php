<?php
/**
 * Created by zhaoweiguo.
 * User: zhaoweiguo
 * Date: 14-9-11
 * Time: PM12:07
 */

/*

POST /addservice HTTP/1.1
User-Agent: curl/7.30.0
Host: 192.168.35.141:9090
Accept: * /*[Action!]
Content-Length: 356
Expect: 100-continue
Content-Type: multipart/form-data; boundary=----------------------------927e2256526c
Connection: close

------------------------------927e2256526c
Content-Disposition: form-data; name="key"

1122-3434
------------------------------927e2256526c
Content-Disposition: form-data; name="destName"

hello.test.unit
------------------------------927e2256526c
Content-Disposition: form-data; name="zkidc"

qa
------------------------------927e2256526c--

// 结果
HTTP/1.1 200 OK
Date: Thu, 11 Sep 2014 09:13:37 GMT
Content-Length: 45
Content-Type: text/plain; charset=utf-8

{"code":0,"reason":"zk: node already exists"}
*/


$hostname = "192.168.35.141";
$host = "192.168.35.141:9090";
$port = 9090;
$uri = "/addservice";
$boundary = "----------------------------".substr(md5(rand(0,32000)),0,12);  // 设定boundary


// 设定请求内容
$data = "";
$data .= "--$boundary\r\n";
$data .= "Content-Disposition: form-data; name=\"key\"\r\n\r\n";   // 多个form间是两个换行
$data .= "1122-3434\r\n";
$data .= "--$boundary\r\n";
$data .= "Content-Disposition: form-data; name=\"destName\"\r\n\r\n";
$data .= "hello.test.unit3\r\n";
$data .= "--$boundary\r\n";
$data .= "Content-Disposition: form-data; name=\"zkidc\"\r\n\r\n";
$data .= "qa\r\n";
$data .= "--$boundary--\r\n";


$fp = @fsockopen($hostname, $port, $errno, $errstr, 1.1);


$out = "POST /addservice HTTP/1.1\r\n";
$out .= "User-Agent: Gordon test HTTP client\r\n";
$out .= "Host: $host\r\n";
$out .= "Accept: */*\r\n";
$out .= "Content-Length: " . strlen($data) . "\r\n";
//$out .= "Expect: 100-continue\r\n";  // what's this?
$out .= "Content-Type: multipart/form-data; boundary=$boundary\r\n";

// http/1.1需要增加这一句，默认为keep-alive
// http/1.0则不需要增加这一句
$out .= "Connection: close\r\n\r\n";  //请求最后要两个换行（切记！）
$out .= $data;

fwrite($fp, $out);

$rtn = '';
while (!feof($fp)) {
  $result = fread($fp, 512);
  $rtn .= $result;
 }
fclose($fp);
echo "-----------------\n";
var_dump($rtn);
echo "-----------------\n";



