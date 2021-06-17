常见问题
############

使用用chrome浏览器访问6000端口提示 ERR_UNSAFE_PORT [1]_
=======================================================

今天使用k8s测试服务使用指定slb问题时,遇到这么一个问题,服务指定7000，8000端口都没有问题，只有使用6000端口时报下面错误

.. image:: /images/chromes/chrome_question1.png

原因::

    Google Chrome 默认非安全端口列表,建议尽量避免以下端口:
      1,    // tcpmux
      7,    // echo
      9,    // discard
      11,   // systat
      13,   // daytime
      15,   // netstat
      17,   // qotd
      19,   // chargen
      20,   // ftp data
      21,   // ftp access
      22,   // ssh
      23,   // telnet
      25,   // smtp
      37,   // time
      42,   // name
      43,   // nicname
      53,   // domain
      77,   // priv-rjs
      79,   // finger
      87,   // ttylink
      95,   // supdup
      101,  // hostriame
      102,  // iso-tsap
      103,  // gppitnp
      104,  // acr-nema
      109,  // pop2
      110,  // pop3
      111,  // sunrpc
      113,  // auth
      115,  // sftp
      117,  // uucp-path
      119,  // nntp
      123,  // NTP
      135,  // loc-srv /epmap
      139,  // netbios
      143,  // imap2
      179,  // BGP
      389,  // ldap
      465,  // smtp+ssl
      512,  // print / exec
      513,  // login
      514,  // shell
      515,  // printer
      526,  // tempo
      530,  // courier
      531,  // chat
      532,  // netnews
      540,  // uucp
      556,  // remotefs
      563,  // nntp+ssl
      587,  // stmp?
      601,  // ??
      636,  // ldap+ssl
      993,  // ldap+ssl
      995,  // pop3+ssl
      2049, // nfs
      3659, // apple-sasl / PasswordServer
      4045, // lockd
      6000, // X11
      6665, // Alternate IRC [Apple addition]
      6666, // Alternate IRC [Apple addition]
      6667, // Standard IRC [Apple addition]
      6668, // Alternate IRC [Apple addition]
      6669, // Alternate IRC [Apple addition]

解决方法::

    1.选中Google Chrome 快捷方式，右键属性，在”目标”对应文本框添加:
    --explicitly-allowed-ports=6000
    2.允许多个端口以逗号隔开，最终如下:
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --explicitly-allowed-ports=6000，21

更好的解决方法::

    不使用这些「默认非安全端口列表」

  


其他相关
========

:ref:`Your connection is not private <mac_chrome_question>`



.. [1] https://blog.csdn.net/qq_28817739/article/details/84501454