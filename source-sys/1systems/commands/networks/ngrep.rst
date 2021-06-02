ngrep命令
#########

安装::

    $ brew install ngrep
    $ yum install ngrep

抓取所有包含有GET或POST请求::

    $ ngrep –q –W byline "^(GET|POST) .*"

所有流经Google的流量做一个过滤，只针对80端口且报文中包含“search”::

    $ ngrep –q –W byline “search” host www.google.com and port 80





