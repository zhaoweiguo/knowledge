协议相关
================

数据协议::

  MQTT
  CoAP
  AMQP
  Websocket
  Node

硬件协议::

    smartConfig: udp广播、组播协议
    softAP: 软AP(热点) -> AP = access point
      无线接入点:wireless access point(wirelessAP)


所谓的smartconfig就是::

    手机APP端发送包含WIFI 用户名 WIFI密码的 UDP 广播包或者组播包
    智能终端的WIFI芯片可以接收到该UDP包，只要知道UDP的组织形式，就可以通过接收到的UDP包解密 出WIFI 用户名 密码
    然后智能硬件 配置受到的WIFI 用户名 密码到指定的WIFI AP 上

    esp8266先scan 下AP ，得到AP的相关信息,如工作的channel ,
      然后配置wifi芯片工作在刚才scan到的channel上去接收UDP包，
      如果没有接收到，继续配置ESP8266工作在另外的channel上，
      如此循环，直到收到UDP包为止，
      为什么要提前进行SCAN 下WIFI AP呢？就是为了提高配置效率。
      假设当前网络中只有两个AP,一个AP工作在CHANEL1，另外个 ap工作在channel13,
      我们现在需要配置智能硬件连接到AP2 ,就是channel13上，
      如果不提前scan就需要从1--13扫描浪费时间。
      就是需要从channel1-chane2 ---...channnel13一直扫描了，
      如果扫描了AP，芯片马上从AP CHANNNEL1 到channel13加快获取到UDP包；

::

    ALSA是Advanced Linux Sound Architectur。
    它在Linux操作系统上提供了音频和MIDI（Musical Instrument Digital Interface，音乐设备数字化接口）的支持。
    A2DP全名是Advanced Audio Distribution Profile（高级音频分发框架），蓝牙音频传输模型协定！ 
    A2DP是能够采用耳机内的芯片来堆栈数据，达到声音的高清晰度。


