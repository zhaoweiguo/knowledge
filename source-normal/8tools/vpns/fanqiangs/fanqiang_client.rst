proxy client使用
=======================

普通设置(好像只适用于linux)
--------------------------------

* 注意是sockets v5代理
* 代理设置成 localhost <port>
* 需要是socket代理, 大部分支持sokcet代理
* 命令行程序用tsocket


最简单使用
----------------
::

    export http_proxy=<proxyHost>:<proxyPort>

    export http_proxy=socks5://127.0.0.1:1080
    export https_proxy=$http_proxy

实战过的::

    # proxy list
    alias proxy='export all_proxy=socks5://127.0.0.1:1086'
    alias unproxy='unset all_proxy'
    # http proxy
    alias httpproxy='export http_proxy=127.0.0.1:1087;export https_proxy=$http_proxy'
    alias unhttpproxy='unset http_proxy;unset https_proxy'

    $> proxy
    // 使用的代理
    $> unproxy
    // 不使用代理

git的使用
-------------
::

    // 新增
    git config --global https.proxy http://127.0.0.1:1080
    git config --global https.proxy https://127.0.0.1:1080

    git config --global http.proxy 'socks5://127.0.0.1:1080'
    git config --global https.proxy 'socks5://127.0.0.1:1080'

    // 删除
    git config --global --unset http.proxy
    git config --global --unset https.proxy


    // 查看
    git config --global --get http.proxy
    git config --global --get https.proxy

    编辑文件~/.gitconfig
    [http]
    proxy = socks5://127.0.0.1:10800
    [https]
    proxy = socks5://127.0.0.1:10800



client-proxy工具——tsocks
-----------------------------
* ubuntu下安装配置::

    //经测试认证过的
    sh>sudo apt-get install tsocks
    sh>sudo nano /etc/tsocks.conf

    #local表示本地的网络，也就是不使用socks代理的网络
    # [注意]下面server下的值要在这里面
    local = 192.168.1.0/255.255.255.0

    server = 127.0.0.1 # SOCKS 服务器的 IP
    server_type = 5 # SOCKS 服务版本
    server_port = 9999 # SOCKS 服务使用的端口

* 软件运行::

    tsocks 你的软件 &
    // .e.g
    tsocks gwibber &

client-proxy工具——proxychains
----------------------------------
* ubuntu下安装配置::

   sh> sudo apt-get install proxychains

   sh> sudo nano /etc/proxychains.conf
   dynamic_chain
   chain_len = 2

   [ProxyList]
   socks5 127.0.0.1 9999
   socks4 127.0.0.1 9050

* 软件运行::

   运行 proxychains 跟运行 tsocks 完全一样。在终端中:
   proxychains 你的软件 &
   比如说:
   proxychains chromium-browser &





