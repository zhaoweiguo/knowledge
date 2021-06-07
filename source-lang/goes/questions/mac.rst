mac相关
#######

dyld: malformed mach-o image: segment __DWARF has vmsize < filesize
===================================================================

说明::

    升级到Catalina 10.15后，golang编译完成后，执行二进制文件报错：
    dyld: malformed mach-o image: segment __DWARF has vmsize < filesize

解决::

    升级到1.13.4后问题被修复


debugserver or lldb-server not found
-------------------------------------------

::

    debugserver or lldb-server not found: install XCode's command line tools or lldb-server


解决::

    重新安装下xcode-select就好了
    xcode-select --install




