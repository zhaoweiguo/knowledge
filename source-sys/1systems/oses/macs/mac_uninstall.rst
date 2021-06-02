Mac删除软件相关
=====================

WireShark卸载::

  // wireshark是用pkg文件包安装的
  1.  Remove /Applications/Wireshark.app
  2.  Remove /Library/Application Support/Wireshark
  3.  Remove the wrapper scripts from /usr/local/bin
  4.  Unload the org.wireshark.ChmodBPF.plist launchd job
  5.  Remove /Library/LaunchDaemons/org.wireshark.ChmodBPF.plist
  6.  Remove the access_bpf group.
  7.  Remove /etc/paths.d/Wireshark
  8.  Remove /etc/manpaths.d/Wireshark





