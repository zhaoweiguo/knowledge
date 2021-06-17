mosquitto的使用
======================

网站: https://mosquitto.org/download/

Eclipse Mosquitto::

  // 轻量级的
  https://mosquitto.org/

::

  Eclipse Mosquitto is an open source (EPL/EDL licensed) message broker that implements the MQTT protocol versions 3.1 and 3.1.1. Mosquitto is lightweight and is suitable for use on all devices from low power single board computers to full servers.



安装::

  make
  sudo make install



mosquitto_sub命令::

  // Local Subscription
  mosquitto_sub -t '$local/topic'
  // Shared Subscription
  mosquitto_sub -t ‘$queue/topic’
  mosquitto_sub -t ‘$share/group/topic’

  // -t --topic: 指定topic
  // -m --message: 消息内容
  // -q --qos: 指定QoS的值（0,1,2）
  // -r --retain: 保持
  mosquitto_sub -t topic -m msg -q 1 -r

  // -p --port: 端口,默认1883
  // -d --debug: 调试模式
  // -h --host: 默认localhost
  mosquitto_sub -t sensor/# -h 10.140.2.6 -p 2883 -d




mosquitto_pub命令::

  // Local Subscription
  mosquitto_pub -t '$local/topic'

  mosquitto_pub -t topic -m msg -q 1 -r



遇到的问题::

  1.安装遇到的问题
  fatal error: uuid/uuid.h: No such file or directory
  // 解决方法
  yum install libuuid-devel

  2.使用时遇到的问题
  libmosquitto.so.1: cannot open shared object file: No such file or
 directory
  // 解决方法
  sudo ln -s /usr/local/lib/libmosquitto.so.1 /usr/lib/libmosquitto.so.1
  sudo ldconfig

  






