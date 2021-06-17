证书
####

简介::

    由数字签名和公钥组成
    认证业务准则(Certification Practice Statement, CPS)

     RFC 5280, X.509 证书

    扩展名:
     .DER 扩展名
     .PEM 扩展名
     .CRT 扩展名
     .CER扩展名
     .KEY 扩展名

    证书链


PKI::

    组成要素
     用户: 使用 PKI 的人
     认证机构: 颁发证书的人
     仓库: 保存证书的数据库
    其他
     根据采用的不同规格, PKI 有很多变种
     根CA(root ca)
     自签名(self-signature)

认证机构的工作::

    生成密钥对
    注册证书
    作废证书和 CRL

攻击::

    公钥注册之前进行攻击
    注册相似人名进行攻击
    窃取认证机构的私钥进行攻击
    伪装成谁机构进行攻击
    钻 CRL 的空子攻击
      利用 CRL 发布的时间差攻击
        * 解决方法:
        * 证书所有者: 尽快通知认证机构
        * 认证机构: 尽快发布 CRL
        * 证书使用/验证者: 及时更新 CRL
      钻 CRL 空子实现否认
        * OCSP, RFC2560
        * Online Certification Status Protocol









