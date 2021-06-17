常见问题
########

通配符证书Wildcard SSL只能支持域名本身及下一级的所有子域名，而不是无限级支持子域名::

    用户为domain.com购买通配符证书Wildcard SSL *.domain.com，该证书可以保护  
    mail.domain.com 
    login.domain.com 
    test.domain.com 
    vpn.domain.com 

    但该证书无法保护3级子yum.mail.doamin.com，对于该域名证书无效。 
     
    如果一定要用于3级子域名，请为sub.domain.com 购买通配符证书Wildcard SSL*.sub.domain.com.







