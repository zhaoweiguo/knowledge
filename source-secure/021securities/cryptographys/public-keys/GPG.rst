pgp/gpg相关
================

其他命令::

  gpg --version

  // 生成密钥
  > gpg --gen-key



基本命令使用
''''''''''''''


1.生成key::

  $> gpg --gen-key
  //之后会要求输入一些个人信息

显示::

  gpg: key A250EE4B marked as ultimately trustedpublic and secret key created and signed.gpg: checking the trustdbgpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust modelgpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1upub   2048R/A250EE4B 2018-07-20      Key fingerprint = D619 878B 3657 16EC ECC9  D72C DB76 2EDA A250 EE4B
  uid                  Gordon (This just a test gpg) <gordon@163.com>
  sub   2048R/FA6A273C 2018-07-20

说明::

  A250EE4B: 用户ID的hash，可以代替用户ID


2.列出key列表::

  $> gpg --list-keys

显示::

  /home/pzsh/.gnupg/pubring.gpg
  -----------------------------
  pub   2048R/A250EE4B 2018-07-20
  uid                  Gordon (This just a test gpg) <gordon@163.com>
  sub   2048R/FA6A273C 2018-07-20

说明::

  第一行显示公钥文件名（pubring.gpg）
  第二行显示公钥特征（2048位，Hash字符串和生成时间）
  第三行显示"用户ID"
  第四行显示私钥特征

3.生成一个撤销证书，以便以后密钥作废时，请求公钥服务器撤销你的公钥::

  $> gpg --gen-revoke [用户ID]

4.删除密钥::

  // 删除私钥
  $> gpg --delete-secret-keys [用户ID]
  // 删除公钥
  $> gpg --delete-key [用户ID]

5.签名::

  5.1对文件签名:
  // 在当前目录下生成一个名为<filename>.asc的文件
  // --clearsign参数表示生成ASCII形式的签名文件
  $> gpg --clearsign filename
  // 在当前目录下生成一个名为<filename>.gpg的文件
  // 使用--sign参数表示以二进制形式存储

  $> gpg --sign haha.txt
  // 生成单独的签名文件，与文件内容分开存放，可以使用detach-sign参数
  gpg --detach-sign demo.txt
  // 如果想采用ASCII码形式，要加上armor参数
  gpg --armor --detach-sign demo.txt

  5.2签名+加密
  gpg --local-user [发信者ID] --recipient [接收者ID] --armor --sign --encrypt demo.txt

  5.3验证签名
  gpg --verify demo.txt.asc demo.txt



6.输出密钥::

  // 公钥文件（.gnupg/pubring.gpg）以二进制形式储存，armor参数可以将其转换为ASCII码显示
  // --output: 参数指定输出文件名（public-key.txt）
  // --export: 指定哪个用户的公钥
  gpg --armor --output public-key.txt --export [用户ID]
  // 输出私钥
  gpg --armor --output private-key.txt --export-secret-keys

7.上传公钥::

  // 公钥服务器是网络上专门储存用户公钥的服务器
  // 通过交换机制，所有的公钥服务器最终都会包含你的公钥
  gpg --send-keys [用户ID] --keyserver hkp://subkeys.pgp.net

  // 生成公钥指纹
  gpg --fingerprint [用户ID]

8.导入密钥::

  gpg --import [密钥文件]

  为了获得他人的公钥，可以让对方直接发给你，或者到公钥服务器上寻找:
  $> gpg --search-keys [用户ID]

9.加密文件::

  --recipient: -r
  --output: -o
  --encrypt: -e
  $> gpg --recipient [用户ID] --output <file.encrypt> --encrypt <file.txt>



10.解密文件::

  $> gpg --decrypt <file.txt> --output <file.encrypt>
  // GPG允许省略decrypt参数(下面2句相同)
  $> gpg --decrypt  <file.encrypt>
  $> gpg <file.encrypt>
  // 解密后的文件内容直接显示在标准输出


11.验证文件完整性::

  # gpg --verify haha.txt.asc






实例1验证加密文件完事性::

  1.下载安装文件:
    curl -LO https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.4.9.tgz

  2.下载public signature文件:
    curl -LO https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.4.9.tgz.sig

  3.下载并导入key文件:
    curl -LO https://www.mongodb.org/static/pgp/server-3.4.asc
    gpg --import server-3.4.asc

  4.验证:
    gpg --verify mongodb-osx-ssl-x86_64-3.4.9.tgz.sig mongodb-osx-ssl-x86_64-3.4.9.tgz

实例2:生成验证公私钥并签名::

  @todo








历史::

  　　1991年，程序员Phil Zimmermann为了避开政府的监视，开发了加密软件PGP
  因为这个软件非常好用，迅速流传开来成为许多程序员的必备工具
  但是，它是商业软不能自由使用
  所以，自由软件基金会决定，开发一个PGP的替代品取名为GnuPG，因此GPG就诞生了
  GPG是GNU Privacy Guard的缩写，是自由软件基金会的GNU计划的一部分
  它是一种基于密钥的加密方式，使用了一对密钥对消息进行加密和解密，来保证消息的安全传输
  一开始，用户通过数字证书认证软件生成一对公钥和私钥
  任何其他想给该用户发送加密消息的用户，需要先从证书机构的公共目录获取接收者的公钥
  然后用公钥加密信息，再发送给接收者
  当接收者收到加密消息后，他可以用自己的私钥来解密，而私钥是不应该被其他人拿到的






