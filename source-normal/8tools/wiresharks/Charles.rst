Charles
#######

* 官网: https://www.charlesproxy.com/


.. note:: Fiddler 或 Charles 这类使用的代理的抓包软件与Wireshark是完全不同的（Wireshark 使用的网卡数据复制，只要是经过指定网卡都会被抓取），其只能对使用代理的应用层网络协议生效，比如常见的HTTP（https），Websocket  。

.. image:: /images/fanqiangs/proxy_principle1.png




客户端需要完成一次HTTP请求，通常需要先找到服务器，客户端会根据http请求中url的主机名（实际会使用host中的主角名）及其端口与目标主机建立tcp连接，建立连接后会将http报文发送给目标服务器 （更多细节请参考https://tools.ietf.org/html/rfc7232）

接下来我来看下HTTP代理是如何运作的，我们启动Fiddler 或 Charles就是启动了一个HTTP代理服务器，这类工具会通知操作系统，“现在我在系统上创建了一个HTTP代理，IP为XXXXXX端口为XX。如果您使用的是linux您可以手动通知操作系统(export http_proxy=ip:port export https_proxy=$http_proxy),如果您使用的是手机等移动设备您可以在当前wifi设置处告诉系统你要使用http代理。 现在我们已经告诉系统我们想要使用代理，这个时候运行在系统上的http客户端再去发送请求的时候，他就不会再去进行DNS解析，去连接目标服务器，而是直接连接系统告诉他代理所在的地址（代理的ip及端口，注意无论是http或https或其他支持代理的协议都会连接同一个端口）。然后代理服务器会与客户端建立连接，再然后代理服务器根据请求信息再去连接真正的服务器。



常见问题
========

https相关::

    启动https:
    Proxy -> Start SSL Proxying

    启动后是https或wss协议
    不启动是http或ws协议

本机启动相关::

    启动本机抓包:
    Proxy -> macOS Proxy

iOS手机安装注意::

    1. 先打开代理再安装证书，安装操作目录为:
    通用-> 描述文件与设备管理
    2. 证书安装后记得要信任证书，操作为:
    通用-> 关于本机-> 证书信任设置





参考
====

* https://cloud.tencent.com/developer/article/1490033

