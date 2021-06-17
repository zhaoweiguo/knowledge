网络相关其他命令
======================

arp-scan命令
---------------

::

  sudo apt-get install arp-scan

  //-interface 选项指明要使用的网口，我们这里是有线网口eth0，即以太网 Ethernet 的缩写
  //--localnet 是指明我们要在局域网的网段内使用ARP协议
  //
  sudo arp-scan -interface eth0 --localnet




