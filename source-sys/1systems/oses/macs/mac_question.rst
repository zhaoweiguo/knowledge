问题解决方案
############

mac突然显示蓝牙不可用::

  // 现象
  变成了蓝牙标志中间多了一道波浪线
  // 解决方案
  1.搜索尝试按住SHIFT+CONTROL+OPTION+开机键重置SMC
  按住4、5秒，松手后等待30秒以上再次开机尝试
  如果不行，您可以
  2.再次尝试开机之后，迅速按住COMMAND+OPTION+P+R键不松手，等到出现4次开机声音后松手。尝试进入

  // 遇到问题第1部就解决了

键盘部分键不可用::

  具体说是jkluio789m.这几个键不可用
  原因:
    连续点击5次「option」进入了『内键触控板』
  解决方法:
    再次连续点击5次「option」

macOS Sierra老是出现检测到了网络变化::

  这是支付宝安全控件的问题
  sudo rm -rf /Library/Application/Support/Alipay
  sudo rm -rf /Library/LaunchDaemons/com.alipay.DispatcherService.plist
  sudo rm -rf ~/Library/LaunchAgents/com.alipay.adaptor.plist
  sudo rm -rf ~/Library/LaunchAgents/com.alipay.refresher.plist
  sudo rm -rf ~/Library/Internet/Plug-Ins/aliedit.plugin
  sudo rm -rf ~/Library/Internet/Plug-Ins/npalicdo.plugin

SIP问题::

  // 当你遇到你用root用户也删除不了的文件时，你可能遇到SIP了
  // 查看SIP状态：
  $ csrutil status

  关闭SIP:
  重启电脑，按住Command+R(直到出现苹果标志)进入Recovery Mode(恢复模式)
  左上角菜单里找到实用工具 -> 终端
  输入$ csrutil disable回车
  重启Mac即可
  如果想重新启动SIP机制重复上述步骤改用$ csrutil enable即可

Mac 如何开启任何来源选项::

    sudo spctl --master-disable


dyld: Library not loaded::

    直接brew reinstall xxx解决

.. _mac_chrome_question:

chrome相关
==========

Your connection is not private [1]_ [2]_ ::

    解决方案:
    存盲打「thisisunsafe」解决
    In the chrome browser whilst on the page, type “thisisunsafe”

如何开启一个热点
================

第一步，先连上有线
第二步，共享wifi设置

.. image:: /images/macs/wifi_hotpot1.png



第3步，设置WiFi密码：

.. image:: /images/macs/wifi_hotpot2.png

备注:

.. image:: /images/macs/wifi_hotpot2.png



.. [1] https://podtech.io/os/mac-osx/chrome-catalina-certificate-issue/
.. [2] https://support.google.com/chrome/thread/16648034?hl=en