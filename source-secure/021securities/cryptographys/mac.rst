消息认证码(MAC, Message Authentication Code)
############################################

简介::

    由单向散列函数和密钥组成
    输入: 任意消息+发送者和接收者共享的「密钥」
    输出: 固定长度的消息(即:MAC值)
    定义: 一种与密钥相关联的单向散列函数

实例::

    SWIFT
     Society for Worldwide Interbank Financial Telecommunication
     环球银行金融电信协会: 银行间传递消息
    IPsec
     IP 增加安全性
    SSL/TLS

实现方法::

    HMAC: 使用单向散列函数构造消息认证码
     HMAC-SHA1
     HMAC-SHA-256
     HMAC-SHA-512
    AES-CMAC: 使用 AES 等分组密码构造消息认证码
    其他: 流密码、公钥密码

认证加密::

    定义: 将「对称密码」和「消息认证码」相结合
    同时满足「机密性」「完整性」「认证」
    实例
     Encrypt-then-MAC
    * 先用对称密码对明文加密
    * 然后计算密文的 MAC 值
     Encrypt-and-MAC
    * 将明文用对称密码加密
    * 并对明文计算 MAC 值
     MAC-then-Encrypt
    * 先计算明文的 MAC 值
    * 然后将明文和 MAC 值同时用对称密码加密

攻击::

    重放攻击(replay attack)
     防御-序号
     防御-时间戳
     防御-nonce
    密钥推测攻击
     暴力破解&生日攻击

无法解决的问题::

    对第三方证明
    防止否认(nonrepudiation)




