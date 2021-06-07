常用
####


来自客户端的查询消息包含以下 3 种信息::

    1. 域名
    2. Class
    3. 记录类型

Class::

    在最早设计 DNS 方案时，DNS 在互联网以外的其他网络中的应用也被考虑到了
    而 Class 就是用来识别网络的信息。
    不过，如今除了互联网并没有其他的网络了，因此 Class 的值永远是代表互联网的 IN

记录类型::

    1. A
      Address 的缩写
      返回值:
        ip 地址
        如: 192.168.0.23

    2. MX
      Mail eXchange，邮件交换
      返回值:
        域名和优先级
        如: 10 mail.qq.com
      说明: 优先级数值较小的邮件服务器代表更优先

    3. PTR
      根据 IP 地址反查域名

    4. SOA
      查询域名属性信息

    5. NS
      查询 DNS 服务器 IP 地址

    6. CNAME
      查询域名相关别名

DNS服务器存储「资源记录」表格式::

    域名              Class     记录类型        响应数据
    ===========      ======     =======       =============
    www.zwg.com       IN          A           192.168.0.23
    zwg.com           IN          MX          10 mail.zwg.com
    mail.zwg.com      IN          A           192.168.1.23


.. figure:: /images/protocols/dns1.png

   找到目标 DNS 服务器













