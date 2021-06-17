.. _telnet:

telnet命令
#################


* telnet命令::

    >>telnet $Url $Port
    Trying $Url...
    Connected to $Url. 
    Escape character is '^]'
    >>GET /$Path HTTP/1.1 
    >>Accept: text/plain 
    >>
    HTTP/1.1 200 OK

* 想输入命令::

    Ctrl + ]

* telnet "miku.acm.uiuc.edu" #这个telnet其实是ssh之前时实现远程登录的命令，明碼显示，不安全




