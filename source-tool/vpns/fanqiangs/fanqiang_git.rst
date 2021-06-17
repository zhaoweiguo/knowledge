git使用ssh隧道翻墙
========================

Git 目前支持的三种协议 ``git://`` 、 ``ssh://`` 和 ``http://``
其代理配置各不相同::

  git:// 协议需要配置 core.gitproxy
  http:// 协议需要配置http.proxy
  ssh:// 协议的代理需要配置 ssh 的 ProxyCommand 参数

GIT 协议的配置::

  1.建立 /path/to/socks5proxywrapper 文件
  2.使用 connect工具(https://bitbucket.org/gotoh/connect)进行代理转发,注:行版一般打包为 proxy-connect 或者 connect-proxy
  3.在/path/to/socks5proxywrapper 文件中输入以下内容:
  #!/bin/sh
  connect -S 127.0.0.1:7070 "$@"
  4.配置 git
  [core]
          gitproxy = /path/to/socks5proxywrapper
  or
  使用命令行
  export GIT_PROXY_COMMAND="/path/to/socks5proxywrapper"


SSH 协议的配置::

  1.建立 /path/to/soks5proxyssh 文件
  #!/bin/sh
  ssh -o ProxyCommand="/path/to/socks5proxywrapper %h %p" "$@"
  2.配置 git 使用该 wrapper
  export GIT_SSH="/path/to/socks5proxyssh“

HTTP 协议的配置::

  [http]
      #这里是因为 Git 使用 libcurl 提供 http 支持
      proxy = socks5://127.0.0.1:7070
  or
  [http]
      proxy = http://127.0.0.1:8087


所有协议全部使用 http 代理::

    1./path/to/socks5proxywrapper 文件
    #!/bin/sh
    connect -H 192.168.1.100:8080 "$@"
    2.HTTP 协议配置
    [http]
        proxy = http://192.168.1.100:8080

针对域名启用代理::

    gitproxy 参数提供 * for * 结构，具体看 man git-config 的 core.gitproxy 部分



      

