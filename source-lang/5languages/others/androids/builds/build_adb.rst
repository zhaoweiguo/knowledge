adb命令
============

::

   // 先usb连接android手机,打开调试模式
   adb install <name.apk>    // 给此android手机安装应用

   adb shell    // 用shell用户登录手机

   adb pull /path/to/file   // 从手机指定目录下载文件
