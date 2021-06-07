Coap协议client [1]_
#######################


.. contents::
   :depth: 1
   :local:
   :backlinks: none

.. _libcoap:

libcoap
-----------
安装::

  % brew安装
  brew install libcoap
  % 好像只安装了.a文件没有对应的coap_server和coap_client文件

  % 源码安装1
  https://github.com/miri64/libcoap
  > autoconf
  > ./configure
  > make
  > sudo make install

  % 源码安装2(最新版)
  https://github.com/obgm/libcoap
  ./autogen.sh
  ./configure --disable-manpages --disable-dtls
  make


启一个CoAP服务::

  coap-server

使用::

  > coap-client -m get coap://localhost
  v:1 t:0 tkl:0 c:1 id:37109
  This is a test server made with libcoap (see http://libcoap.sf.net) 
  Copyright (C) 2010--2013 Olaf Bergmann <bergmann@tzi.org>

  % 把结果打印到result.txt文件中
  > ./coap-client -m get -o result.txt coap://localhost




.. _coap_cli:

Node CoAP CLI
----------------
安装::

     npm install coap-cli -g 

用法::

  get        performs a GET request
  put        performs a PUT request
  post       performs a POST request
  delete     performs a DELETE request

实例::

  coap get coap://localhost
  (2.05)  ************************************************************
  I-D
  coap get coap://localhost/id/1
  (4.04)  Not Found

  coap put  -p 1 coap://10.13.11.116/light
  (2.05)  1
  coap get coap://10.13.11.116/light
  (2.05)  1


.. _browser_plugin:

浏览器插件
------------------
Firefox Copper::

  https://addons.mozilla.org/en-US/firefox/addon/copper-270430/
  说明:
  1.最新的firefox不支持了

Chrome::

  https://github.com/mkovatsc/Copper4Cr.git
  ./install.sh
  chrome://extensions/
  点击「加载已解压的扩展程序」选择「app文件夹」
  同样操作选择「extension文件夹」
  具体使用方法: https://www.cnblogs.com/liuyunxiang/p/8894596.html


wireshark
------------
::

  sudo tcpdump -i lo -w ~/temp/coap-json.cap
  在wireshark中,搜索
  udp.port==5683

coap测试服务器
---------------
::

  coap://wsncoap.org:5683
  coap://wsncoap.org:5683/.well-known/core
  coap://wsncoap.org:5683/obs



.. [1] http://coap.technology/impls.html
