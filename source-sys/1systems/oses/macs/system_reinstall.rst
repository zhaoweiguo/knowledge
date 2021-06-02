系统重装参考
############

基本、简单的
============

更改同类型文件的默认打开方式::

    右键单击该文件，然后选择「显示简介」选项

.. image:: /images/macs/default_open.png




快捷键-关机、锁屏 [1]_
=========================

* 修改前：

.. figure:: /images/macs/shortcut_key1.png
   :width: 50%

* 修改后：

.. figure:: /images/macs/shortcut_key2.png
   :width: 50%

* 修改步骤::

    系统偏好设置----->键盘------>快捷键----->应用快捷键

    1. 实例1: 锁定屏幕功能
      菜单标题: 锁定屏幕
      键盘快捷键: Command + L
      注意: 如果是英文版，菜单标题是 『Lock Screen』
    2. 实例2: 关机
      菜单标题: 关机...
      键盘快捷键: Command + R
    注: 带有省略号的关机…会有关机前询问，没有省略号的关机会立即关机


.. figure:: /images/macs/shortcut_key3.png
   :width: 50%

修改主机名和计算机名 [2]_
===========================

对于 Mac OS 来说，主机名和计算机名是不同的概念，因为 Mac OS 可以通过“计算机名”来自定义主机在局域网内显示的名称

修改主机名::

    // 查看当前的“主机名”
    echo $HOSTNAME
    // 修改主机名
    sudo scutil --set HostName 新的主机名
    注: 执行命令后，再输入 exit 结束当前终端进程。重新打开终端，就会发现主机名已经修改为新的主机名了

自定义当前主机在局域网内显示的主机名::

    有两种方法:
    1.在“设置”——“共享”下，修改电脑名称。
    2.在终端下，通过命令实现。

    方法1 - 在“设置”——“共享”下，修改电脑名称:
    方法2 - 在终端下输入命令：
    sudo scutil --set ComputerName 新的计算机名


重建索引 [3]_
================

方案1（未生效）::

    1. Choose Apple menu, then System Preferences, and then Spotlight.
    2. Select the Privacy tab.
    3. In Finder:
      a. On the Go menu, select Go to Folder...
      b. Copy and paste the following location into the "Go to the folder:" dialog box and select Go:
          ~/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles/
    4. Drag the "Main Profile" folder to the Privacy tab. Once added, remove the folder, 
        and Spotlight will re-index the folder. 
        You must perform this step for any additional profile folders you have.

方案2(生效) [4]_::

    1. 删除Outlook，且删除 ~/Library/Group Containers/UBF8T346G9*
    2. 重新下载Outlook
    3. 重新添加帐号
    注: 可能只需要删除~/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles就行


软件安装(带界面)
=====================

工具::

    // MarkDown工具
    brew cask install macdown

开发专用
========


* brew安装如下软件::
    
    brew install emacs tmux htop jq ng

* 快捷::

    1. sublime 命令行专用  
    ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
    echo "export EDITOR='subl' -w" >> ~/.zshrc


Shell Application
=================

* `iTerm <iterm2>`_: https://www.iterm2.com/
* Hyper: https://hyper.is/




.. [1] https://www.jianshu.com/p/da6de97c33bb
.. [2] https://www.jianshu.com/p/dbf2fa105f26
.. [3] https://docs.microsoft.com/en-us/outlook/troubleshoot/outlook-for-mac/useful-tools
.. [4] https://support.office.com/en-us/article/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3