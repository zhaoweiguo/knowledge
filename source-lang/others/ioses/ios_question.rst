ios常见问题
====================

Could not find Developer Disk Image问题::

  这是由于真机系统过高或者过低，Xcode中没有匹配的配置包文件，我们可以通过这个路径进入配置包的存放目录：
  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
  

  
配置方法::

  cmd+shift+G  输入
  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
  把下载的指定包放入
  重启xcode
