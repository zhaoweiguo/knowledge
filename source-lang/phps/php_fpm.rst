fpm使用
=================

::

   pm.start_servers= min_spare_servers + (max_spare_servers - min_spare_servers) / 2

   max_spare_servers是根据服务器本身的内存来计算的，标准算法就是内存大小除以30M
   当然，有的php程序可能占用比较小，不到30M，这就看情况来计算了


   pm.max_requests = 500
   php-fpm recycles the process after it has processed 500个请求


   pm.max_children = 256
   
