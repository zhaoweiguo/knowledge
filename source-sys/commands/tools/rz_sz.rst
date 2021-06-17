rz/sz命令
#####################
注意::

  不要在tmux或screen中运行此命令

::

  sz：将选定的文件发送（send）到本地机器
  rz：运行该命令会弹出一个文件选择窗口，从本地选择文件上传到服务器(receive)


参数::

  -a 以文本方式传输（ascii）
  -b binary 用binary的方式上传下载，不解释字符为ascii
  -e 强制escape 所有控制字符，比如Ctrl+x，DEL等

  如果能够确定所传输的文件是文本格式的，使用 sz -a files
  如果是二进制文件，使用 sz -be files



安装::

   yum install lrzsz -y
   brew install lrzsz

说明::

  基于Zmodem协议


