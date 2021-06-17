.. _command_ssh:

ssh命令
#########################

各参数含义::

    -C 传输时压缩数据
    -f 输入密码登陆后，ssh进入后台运行
    -N 不执行远程命令，只提供端口转发。仅用于ssh2协议
    -g 允许远程主机连接ssh转发端口
    -D 设置socks代理地址和监听端口，如果是只允许本地访问则指定IP为127.0.0.1
    -l ssh登陆用户名
    -i 指定ssh登陆用的私钥，如果是用公钥、私钥对登陆则需要指定

-L选项
------

::

     -L [bind_address:]port:host:hostport
     -L [bind_address:]port:remote_socket
     -L local_socket:host:hostport
     -L local_socket:remote_socket


* 把远端的端口3306影射到本地的3308(把远端的mysql通过本地访问,有bindaddress配置的mysql)::

    $ ssh -L 3308:<ip>:3306 <user>@<host>

-D选项
------

::

     -D [bind_address:]port

* 指定一个动态应用级端口做转发,然后可以在浏览器做代理,通过指定服务器进行访问（如翻墙）::

    ssh -D 7070 username@yourserver.com

实例::

    ssh -CfNg -D 0.0.0.0:1080 -l username xxx.xxx.xxx.xxx


ssh-keygen命令
-----------------
::

    // 删除known_hosts中对应host/ip的记录
    ssh-keygen -R <hostname>
    ssh-keygen -R <ip_address>

    // 显示key and ascii art representation
    ssh-keygen -l -f <filePath>
    ssh-keygen -lv -f ~/.ssh/known_hosts  //以图形化的方式展示

    // 生成pem格式的密钥
    ssh-keygen -t rsa -m pem
    // 生成到指定文件
    ssh-keygen -t rsa -m pem -f <file>.pem


ssh-add命令相关
----------------
::

  // ssh-add命令是把专用密钥添加到ssh-agent的高速缓存中
  // 语法
  ssh-add [-cDdLlXx] [-t life] [file ...]
  ssh-add -s pkcs11
  ssh-add -e pkcs11

选项::

  -D: 删除ssh-agent中的所有密钥.
  -d: 从ssh-agent中的删除密钥
  -e: pkcs11：删除PKCS#11共享库pkcs1提供的钥匙。
  -s: pkcs11：添加PKCS#11共享库pkcs1提供的钥匙。
  -L: 显示ssh-agent中的公钥
  -l: 显示ssh-agent中的密钥
  -t: life：对加载的密钥设置超时时间，超时ssh-agent将自动卸载密钥
  -X: 对ssh-agent进行解锁
  -x: 对ssh-agent进行加锁

实例::

  把专用密钥添加到 ssh-agent 的高速缓存中:
  ssh-add ~/.ssh/id_dsa
  2、从ssh-agent中删除密钥:
  ssh-add -d ~/.ssh/id_xxx.pub
  3、查看ssh-agent中的密钥:
  ssh-add -l

mac专用 [1]_::

    -K: When adding identities, each passphrase will also be stored in the user's keychain.  
      When removing identities with -d, each passphrase will be removed from it.
    $ ssh-add -K [path/to/your/ssh-key]

ssh-copy-id
-----------

ssh-copy-id 将本机的公钥复制到远程机器的authorized_keys文件中，ssh-copy-id也能让你有到远程机器的home, ~./ssh , 和 ~/.ssh/authorized_keys的权利

用ssh-copy-id将公钥复制到远程机器中::

    $  ssh-copy-id -i .ssh/id_rsa.pub  username@192.168.x.xxx


常见问题
----------
::

    * Agent admitted failure to sign using the key.
    * Permission denied (publickey,gssapi-with-mic).
    * Permission denied (publickey,keyboard-interactive).
    * Permission denied (publickey,password).    // 3次密码输入错误
    * ssh_exchange_identification: read: Connection reset by peer(1.运营商2.尝试次数太多ip被防火墙干掉了)


常见问题 => Too many authentication failures::

    >> ssh root@58.56.108.133
    Received disconnect from 58.56.108.133: 2: Too many authentication failures for root

  //原因: .ssh/文件夹下面的东西太多了



避免SSH连接因超时闲置断开::

  用SSH过程连接电脑时，经常遇到长时间不操作而被服务器踢出的情况，常见的提示如:
    Write failed: Broken pipe

  这是因为如果有一段时间在SSH连接上无数据传输，连接就会断开。解决此问题有以下几种方法:

  1. 修改 ``/etc/ssh/ssh_config`` 文件(可分在服务器端还是客户端)(需要root权限):
    * 在客户端设置, 添加如下一行(此后该系统里的用户连接SSH时，每60秒会发一个KeepAlive请求，避免被踢):

         ServerAliveInterval 60

    * 在服务器端设置, 添加如下设置(应注意启用该功能后，安全性会有一定下降[比如忘记登出时……]):

        ClientAliveInterval 60


    * 注意，执行完上面修改后，需要重启sshd服务::

        service sshd reload 


  2. 修改 ``~/.ssh/config`` 文件，在此文件中增加如下一句::

    ServerAliveInterval 60

    保存退出，重新开启用户的shell，则再ssh远程服务器的时候，不会因为长时间操作断开。应该是加入这句之后，ssh客户端会每隔一段时间自动与ssh服务器通信一次，所以长时间操作不会断开。

  3. 修改 ``/etc/profile`` 配置文件,增加::

    TMOUT=1800
    这样30分钟没操作就自动LOGOUT

  4. 利用expect 模拟键盘动作，在闲置时间之内模拟地给个键盘响应,将下列代码保存为xxx，然后用expect执行::

    #!/usr/bin/expect  
    set timeout 60  
    spawn ssh user@host   
          interact {          
            timeout 300 {send "\x20"}  
          } 
    expect xxx

    接着按提示输入密码就可以了，这样每隔300秒就会自动打一个空格(\x20)，具体的时间间隔可以根据具体情况设置。

  5. 如果你在windows下通过工具连接，可以设置为
    secureCRT：选项---终端---反空闲 中设置每隔多少秒发送一个字符串，或者是NO-OP协议包
    putty：putty -> Connection -> Seconds between keepalives ( 0 to turn off ), 默认为0, 改为300.



ssh中“Host key verification failed.“的解决方案::

    这个问题的原理和比较长久的解决方案:

    用OpenSSH的人都知ssh会把你每个你访问过计算机的公钥(public key)都记录在~/.ssh/known_hosts。当下次访问相同计算机时，OpenSSH会核对公钥。如果公钥不同，OpenSSH会发出警告，避免你受到DNS Hijack之类的攻击。
    SSH对主机的public_key的检查等级是根据StrictHostKeyChecking变量来配置的。默认情况下，StrictHostKeyChecking=ask。简单所下它的三种配置值：

    1.StrictHostKeyChecking=no  

    #最不安全的级别，当然也没有那么多烦人的提示了，相对安全的内网测试时建议使用。如果连接server的key在本地不存在，那么就自动添加到文件中（默认是known_hosts），并且给出一个警告。

    2.StrictHostKeyChecking=ask  #默认的级别，就是出现刚才的提示了。如果连接和key不匹配，给出提示，并拒绝登录。

    3.StrictHostKeyChecking=yes  #最安全的级别，如果连接与key不匹配，就拒绝连接，不会提示详细信息。

    对于我来说，在内网的进行的一些测试，为了方便，选择最低的安全级别。在.ssh/config（或者/etc/ssh/ssh_config）中配置：

    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null




有了openssh密钥，如何生成putty ssh密钥::

  假设openssh的私钥名为Identity则，在linux上，使用puttygen命令如下:
    puttygen Identity -o Identity.ppk -O private

  这样可以使用生成的.ppk文件登陆openssh服务器了。




如何实现只能通过ssh私钥登录::

  修改/etc/ssh/sshd_config文件:
    PermitRootLogin no          //修改为no(禁止root登陆)
    PubkeyAuthentication yes    //允许ssh登陆
    AuthorizedKeysFile     .ssh/authorized_keys         //設定ssh登陆
    PasswordAuthentication no              //禁止密码登陆

    //可以让你在远程机器上执行gui程序然后在"本地"显示图形
    AllowTcpForwarding yes
    X11Forwarding yes


ssh服务相关文件::

    > cat /etc/ssh/sshd_config
    AuthorizedKeysFile      %h/.ssh/authorized_keys
    PasswordAuthentication   no: 指定不允许密码登录
    PermitRootLogin          no: 不允许root用户登陆
    Port                     22: 指定登录端口,默认TCP 22端口
    AllowUsers happy test kaixin   指定允许登录用户

    ChallengeResponseAuthentication yes: @todo 未知是做啥的(估计是用于expect脚本登录)



.ssh/config文件内容格式::

    host eqitonghub
    user git
    hostname 60.216.116.245
    port 22
    identityfile ~/.ssh/gordon.git



mac使用跳板机时, 每次重启机器都要执行一次ssh-add命令输入密码 [1]_::

    原因:
    ssh-add 这个命令不是用来永久性的记住你所使用的私钥的
    实际上，它的作用只是把你指定的私钥添加到 ssh-agent 所管理的一个 session 当中
    而 ssh-agent 是一个用于存储私钥的临时性的 session 服务
    也就是说当你重启之后，ssh-agent 服务也就重置了。

    解决:
    Mac 系统内置了一个 Keychain 的服务及其管理程序，可以方便的帮你管理各种秘钥，其中包括 ssh 秘钥
    ssh-add 默认将制定的秘钥添加在当前运行的 ssh-agent 服务中
      但是你可以改变这个默认行为让它添加到 keychain 服务中，让 Mac 来帮你记住、管理并保障这些秘钥的安全性





.. [1] https://segmentfault.com/q/1010000000835302/a-1020000000883441

