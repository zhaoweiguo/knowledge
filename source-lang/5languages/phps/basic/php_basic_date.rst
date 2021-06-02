php日期相关功能说明
#############################

* 修改时区::

    //修改php.ini文件
    date.timezone =Asia/Shanghai

    //文件修改
    <?php
    date_default_timezone_set('Asia/Shanghai');//'Asia/Shanghai'   亚洲/上海
    date_default_timezone_set('Asia/Chongqing');//其中Asia/Chongqing'为“亚洲/重庆”
    date_default_timezone_set('PRC');//其中PRC为“中华人民共和国”
    ini_set('date.timezone','Etc/GMT-8');
    ini_set('date.timezone','PRC');
    ini_set('date.timezone','Asia/Shanghai');
    ini_set('date.timezone','Asia/Chongqing');

date常见用法::

  date_default_timezone_set('UTC');
  // 每天的第一秒
  $t1 = mktime(0, 0, 0, date("n"),date("j"),date("Y"));
  $date1 = date("Y-m-d H:i:s", $t1);
  // 每天的最后一秒
  $t2 = mktime(23, 59, 59, date("n"),date("j"),date("Y"));
  $date2 = date("Y-m-d H:i:s", $t2);


* strtotime方法使用::

    echo strtotime("now"), "\n";
    echo strtotime("10 September 2000"), "\n";
    echo strtotime("+1 day"), "\n";
    echo strtotime("+1 week"), "\n";
    echo strtotime("+1 week 2 days 4 hours 2 seconds"), "\n";
    echo strtotime("next Thursday"), "\n";
    echo strtotime("last Monday"), "\n";





    
