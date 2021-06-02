ios使用技巧
==================

常见命令::

  <shift> + <cmd> + k     // 清理缓存
  <cmd> + ,   // 打开配置
  Window -> Devices    // 打开设备管理


有帐号新加测试机操作::

  1. 打开develop网站,在device中增加一条记录(udid可以通过“设备管理器”查到)
  2. <cmd> + , 打开配置，点击“Accounts”
  3. 找到指定帐号, 双击打开
  4. 点击左下角的刷新与线上进行同步
  5. 完成后<shift> + <cmd> + k进行缓存清理
  6. done

修改应用显示名操作::

  “Build Setting”中搜索product然后找到“Product Name”

修改bundle id::

  有时遇到bundleid不能修改的
  “Info”中找“Bundle identifier”,在这儿进行修改就好了


导入第三方sdk时，有时会出现::

  Undefined symbols for architecture i386:和"_OBJC_CLASS_$_xx", referenced from:
  原因可查看evernote中的内容

  一般解决方案:
  删除报错的sdk，重新下载导入


Profile启动Instruments::

  CMD + i
  or
  界面操作: Product -> Profile

  // 其他
  界面操作: Product -> Schema -> Edit Schema   // 可以弄成debug模式



iOS模拟器::

  Shift + Command + k: 启动输入法
  Shift + Command + h: Home键

