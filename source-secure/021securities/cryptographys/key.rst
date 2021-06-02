密钥——秘密的精华
################

说明::

    信息的机密性不应该依赖于密码算法本身
    而应该依赖于妥善保管的密钥

各种不同的密钥::

    密钥的用途
     确保机密性的密钥
    * 对称密码
    * 公钥密码
     用于认证的密钥
    * 消息认证码
    * 数字签名
    密钥的使用次数
     会话密钥(session key)
     主密钥(master key)
    加密的对象
     CEK(Contents Encrypting Key, 内容加密密钥)
     KEK(Key Encrypting Key, 密钥加密密钥)
     KEK 是为了减少密钥数量

密钥的管理::

    生成密钥
     生成密钥最好的方法是随机数
    * 密码学用途的伪随机数生成器必须是专门针对密码学设计的
     用口令生成密钥
    * 基于口令的密码(Password Based Encryption, PBE)
    配送密钥
     1. 事先共享密码
     2. 密钥分配中心
     3. Diffie-Hellman 密钥交换
     4. 公钥密码
    更新密钥(key updating)
     时间点: 定期(如每发送1000字节)改变密钥
     方法: 用当前密钥的散列值作为下一个密钥
     好处: 前向安全(forward security)
     原因: 借助单向散列函数的单向性, 防止破译过去的通信内容的机制
    保存密钥
     KEK: 减少需保管的密钥数量
    作废密钥
     作废与生成密钥同等重要

Diffie-Hellman::

    定义
     Diffie-Hellman 密钥交换(Diffie-Hellman key exchange)
     Diffie-Hellman 密钥协商(Diffie-Hellman key aggreement)
     基于:「离散对数」
    椭圆曲线Diffie-Hellman
     基于: 「椭圆曲线上的离散对数问题」

PBE::

    基于口令的密码(Password Based Encryption, PBE)
     加密步骤
     1. 生成 KEK
     2. 生成会话密钥(CEK)并加密
     3. 加密消息
    解密步骤
     1. 重建 KEK
     2. 解密会话密钥
     3. 解密消息
    作用
     盐的作用: 防御字典攻击
     口令作用: 全球人脑记忆
     改良PBE: 多次迭代散列函数来「拉伸 stretching」







