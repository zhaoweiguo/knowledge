DNS
###



.. toctree::
   :maxdepth: 2

   DNS/normal
   DNS/root
   DNS/type
   DNS/httpdns


DNS（Domain Name System）是一个全球化的分布式数据库，用于存储域名与互联网 IP 地址的映射关系。


::

  正向查询指的是通过域名得到IP的查询,而反向查询就是通过IP得到域名
  例如用host命令:
    host ip就可以得到服务器的域名
    host domainName 就得到IP
  DNS服务器支持TCP和UDP两种协议的查询方式,而且端口都是53

大多数的查询都是UDP查询的，一般需要TCP查询的有两种情况::

  1.当查询数据太大以至于产生了数据截断(TC标志为1)时,需要利用TCP的分片能力来进行数据传输
  2.当主（master）服务器和辅（slave）服务器之间通信，辅服务器要拿到主服务器的zone信息的时候





