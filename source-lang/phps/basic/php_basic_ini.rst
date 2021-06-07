php ini文件相关
======================

不是所有有效的选项都能够用 ini_set() 来改变的。 这里有个有效选项的清单附录http://php.net/manual/zh/ini.list.php

::

   // 设置
   string ini_set ( string $varname , string $newvalue )
   设置指定配置选项的值。这个选项会在脚本运行时保持新的值，并在脚本结束时恢复
   
   // 读取
   echo ini_get('display_errors');

   gc_maxlifetime: 此值指定秒后,存储的数据会被垃圾回收







