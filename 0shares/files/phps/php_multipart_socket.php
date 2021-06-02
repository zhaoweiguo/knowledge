<?php
   
$remote_server = "webinno.cn";
 
$boundary = "---------------------".substr(md5(rand(0,32000)),0,10);
        
// Build the header
$header = "POST /api.php?action=twupload HTTP/1.0\r\n";
$header .= "Host: {$remote_server}\r\n";
$header .= "Content-type: multipart/form-data, boundary=$boundary\r\n";
 
/*
        // attach post vars
        foreach($_POST AS $index => $value){
            $data .="--$boundary\r\n";
            $data .= "Content-Disposition: form-data; name=\"".$index."\"\r\n";
            $data .= "\r\n".$value."\r\n";
            $data .="--$boundary\r\n";
        }
*/
$file_name = "aaa.jpg";
$content_type = "image/jpg";
 
$data = '';
// and attach the file
$data .= "--$boundary\r\n";
 
$content_file = file_get_contents('aaa.jpg');
$data .="Content-Disposition: form-data; name=\"userfile\"; filename=\"$file_name\"\r\n";
$data .= "Content-Type: $content_type\r\n\r\n";
$data .= "".$content_file."\r\n";
$data .="--$boundary--\r\n";
 
$header .= "Content-length: " . strlen($data) . "\r\n\r\n";
// Open the connection
 
 
$fp = fsockopen($remote_server, 80);
// then just
fputs($fp, $header.$data);
// reader
 
while (!feof($fp)) {
  echo fgets($fp, 128);
 }
 
fclose($fp);


