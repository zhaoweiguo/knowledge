CSRF
####

* Cross-Site-Request-Forgery(跨站请求伪造)::
    
    也被称为 one-click attack 或者 session riding，通常缩写为 CSRF 或者 XSRF
    
    定义:
      是一种挟制用户在当前已登录的 Web 应用程序上执行非本意的操作的攻击方法。
      跟XSS相比， XSS 利用的是用户对指定网站的信任，CSRF 利用的是网站对用户网页浏览器的信任。



实例::

    用户 A 正常登录，后保存下 SessionID
    然后请求修改个人信息接口，修改用户 B 的信息











