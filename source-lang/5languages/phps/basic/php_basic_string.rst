.. _php_basic_string:

php基本的字符串使用
======================

* 基本使用::

    22 == "22"; // 返回 true 
    22 === "22"; // 返回false
    0 == "我爱你"; // 返回true 
    1 == "1 我爱你";// 返回true

* 字符串比较函数::

    strcmp,strcasecmp,strncasecmp(), strncmp()
    //如果前者比后者大,则返回大于0的整数；如果前者比后者小，则返回小于0的整数；如果两者相等，则返回0

    echo strcmp("Hello world!","Hello world!");
    // 0, 二进制安全的，且对大小写敏感

    echo strcasecmp("Hello world!","HELLO WORLD!");
    // 0, 二进制安全的，且对大小写不敏感

    echo strncasecmp("Hello world!","Hello earth!",6);
    // 0, 二进制安全的，且对大小写不敏感

    echo strncmp("Hello world!","Hello earth!",6);
    // 0, 二进制安全的，且对大小写敏感

::

   // 字串分离
   explode("fff,ffff", ",")
   // 字串长度
   strlen("fff,ffff")
   // 字串包含
   //demo1
   if(strstr($a,"exe"))   // 返回一个从被判断字符开始到结束的字符串,如果没有返回null值(stristr不区分大小写)
   {
       echo "exe\n";
   }
   // demo2
   $c=explode($b,$a);
   if(count($c)>1){
      echo "true";
   }
   // demo3
   if(strpos("$abc","a")==-1)  // strpos: 返回boolean值
   {
       echo "没有a";
   }
   
   // 字串大写
   string strtoupper ( string $string )


substr/mb_substr函数::

   string substr ( string $string , int $start [, int $length ] )
   例:
   substr("Hello world",6)
   >> world
   $rest = substr("abcdef", -1);    // 返回 "f"
   $rest = substr("abcdef", -2);    // 返回 "ef"
   $rest = substr("abcdef", -3, 1); // 返回 "d"

   $rest = substr("abcdef", 0, -1);  // 返回 "abcde"
   $rest = substr("abcdef", 2, -1);  // 返回 "cde"
   $rest = substr("abcdef", 4, -4);  // 返回 ""
   $rest = substr("abcdef", -3, -1); // 返回 "de"
   

strpos/mb_strpos函数::

  mixed strpos ( string $haystack , mixed $needle [, int $offset = 0 ] )
  例:
  $mystring = 'abc';
  $findme   = 'a';
  $pos = strpos($mystring, $findme);

  if ($pos === false) { // 要用===,反面为 else if($pos !=== true)
      echo "在字符串 '$mystring' 中找到字符串 '$findme'";
  } else {
     echo "在字符串 '$mystring'中找不到字符串'$findme'";
     echo "存在找到位置 $pos";
  }

  
  






  
