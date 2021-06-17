brew命令
#############

``/usr/local/`` 目录下::

    brew search <app>
    brew info <app>     //得到<pkg>应用的列表
    brew checkout <commit id> Library/Formula/<app>.rb  //设定到指定版本
    brew install <app>
    brew uninstall <app>


重新安装brew::

  $ brew update
  $ brew uninstall node
  $ brew install node
