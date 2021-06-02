多因素认证
##########


* HOTP: HMAC-Based One-time Password
* TOTP: Time-based One-time Password
* MFA: 多因素认证（Multi-factor authentication


多因素认证（Multi-factor authentication，缩写为 MFA）是一种安全系统，是为了验证一项交易的合理性而实行多种身份验证。MFA 的目的是建立一个多层次的防御，使未经授权的人访问计算机系统或网络更加困难。

MFA 是通过结合两个或三个独立的凭证::

    用户知道什么（知识型的身份验证）
    用户有什么（安全性令牌或者智能卡）
    用户是什么（生物识别验证）

    而单因素身份验证（SFA）与之相比，只需要用户现有的知识。


``虚拟 MFA 设备`` 是能产生 6 位数字认证码的应用程序，遵循基于时间的一次性密码 （TOTP）标准（RFC 6238）。此类应用程序可在移动硬件设备（包括智能手机）上运行，而且这个应用程序不需要连接网络即可工作。


HOTP
============

HOTP 的工作原理如下::

    客户端和服务器事先协商好一个密钥 K，用于一次性密码的生成过程，此密钥不被任何第三方所知道。
    此外，客户端和服务器各有一个计数器 C，并且事先将计数值同步。
    
    进行验证时，客户端对密钥和计数器的组合 (K,C) 使用 HMAC（Hash-based Message Authentication Code）算法计算一次性密码
    
    公式如下：
    HOTP(K,C) = Truncate(HMAC-SHA-1(K,C))
    说明:
    HMAC 算法得出的值位数比较多，不方便用户输入，因此需要截断（Truncate）成为一组不太长十进制数（例如 6 位）

    计算完成之后客户端计数器 C 计数值加 1。
    用户将这一组十进制数输入并且提交之后，服务器端同样的计算，并且与用户提交的数值比较
    如果相同，则验证通过，服务器端将计数值 C 增加 1。
    如果不相同，则验证失败。

.. note:: 这儿有个问题。如果验证失败或者客户端不小心多进行了一次生成密码操作，那么服务器和客户端之间的计数器 C 将不再同步，因此需要有一个重新同步（Resynchronization）的机制。详情可以参看 RFC 4226


TOTP
====

介绍完了 HOTP，TOTP也就容易理解了。TOTP 将 HOTP 中的计数器 C 用当前时间 T 来替代，于是就得到了随着时间变化的一次性密码。

问题一：时间 T 的值怎么选取::

    因为时间每时每刻都在变化，如果选择一个变化太快的 T（秒），那么用户来不及输入密码。
    如果选择一个变化太慢的 T（小时），那么第三方攻击者就有充足的时间去尝试所有可能的一次性密码
      （6 位数字的一次性密码仅仅有 10^6 种组合），降低了密码的安全性。

    除此之外，变化太慢的 T 还会导致另一个问题:
      如果用户需要在短时间内两次登录账户，由于密码是一次性的不可重用，用户必须等到下一个一次性密码被生成时才能登录，
      这意味着最多需要等待 59 分 59 秒！这显然不可接受。

    综合以上考虑，Google 选择了 30 秒作为时间片
    T 的数值为从 Unix epoch（1970 年 1 月 1 日 00:00:00）来经历的 30 秒的个数

问题二：网络延时等，导致验证经常失败::

    由于网络延时，用户输入延迟等因素，可能当服务器端接收到一次性密码时，T 的数值已经改变
    这样就会导致服务器计算的一次性密码值与用户输入的不同，验证失败。

    解决这个问题个一个方法是:
      服务器计算当前时间片以及前面的 n 个时间片内的一次性密码值，只要其中有一个与用户输入的密码相同，则验证通过。
      当然，n 不能太大，否则会降低安全性，通常这个 n 被设置为 3。

操作流程
========

实现 Google Authenticator 功能需要服务器端和客户端的支持::

    服务器端负责密钥的生成、验证一次性密码是否正确。
    客户端记录密钥后生成一次性密码。

步骤一：开启 Google Authenticator 服务时::

    1. 服务器随机生成一个类似于『xxxxxxxxxxxx』的密钥，并且把这个密钥保存在数据库中。
    2. 在页面上显示一个二维码，内容是一个 URI 地址（otpauth://totp/ 发行方：账号？secret = 密钥），如:
       『otpauth://totp/issuer:accountName?secret=xxxxxxxxxxxxx』
    3. 客户端扫描二维码，把密钥和用户名及发行方保存在客户端。

步骤二：用户登陆时::

    1. 客户端每 30 秒使用密钥和时间戳通过一种『算法』生成一个 6 位数字的一次性密码。
    2. 用户登陆时输入一次性的 6 位数密码。
    3. 服务器端使用保存在数据库中的密钥『xxxxxxxxxxxx』和时间戳通过同一种『算法』生成一个 6 位数字的一次性密码。
       如果算法相同、密钥相同，又是同一个时间（时间戳相同），那么客户端和服务器计算出的一次性密码是一样的。
       服务器验证时如果一样，就登录成功了。

相关链接
========

* https://github.com/google/google-authenticator
* https://github.com/google/google-authenticator-android
  * 下载地址: https://github.com/google/google-authenticator-android/releases
* JAVA 版本的一个实现: https://github.com/wstrange/GoogleAuth
* PHP 版本的一个实现: https://github.com/PHPGangsta/GoogleAuthenticator

* PAM Module: https://github.com/google/google-authenticator-libpam::

    The PAM module can add a two-factor authentication step to any PAM-enabled application. 
    It supports:
      Per-user secret and status file stored in user's home directory
      Support for 30-second TOTP codes
      Support for emergency scratch codes
      Protection against replay attacks
      Key provisioning via display of QR code
      Manual key entry of RFC 4648 base32 key strings


* 使用 Google Authenticator 实现两步验证加固 SSH 安全: https://cloud.tencent.com/developer/article/1444296






