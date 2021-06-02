桌面相关
########

Ubuntu
=======

常用::

  //右键里面添加一个“打开终端”的菜单:
  sudo apt-get install nautilus-open-terminal

  //配置中文环境 [这个在新系统中一般用不到了]:
  sudo apt-get install language-support-zh


工具包::

  pdfeditor(Xournal和Okular都可以实现添加批注，但pdfedit是真正的PDF编辑软件):
  $> sudo apt-get install pdfeditor


在ubuntu下close laptop lid, 不执行任何操作::

    Alt + F2 and enter this: gconf-editor 
    apps > gnome-power-manager > buttons
    Set lid_ac and lid_battery to nothing

    OR

    1.When on AC Power, do nothing when laptop lid is closed: 
    gconftool-2 -t string -s /apps/gnome-power-manager/buttons/lid_ac nothing 

    2.When on Battery Power, do nothing when laptop lid is closed: 
    gconftool-2 -t string -s /apps/gnome-power-manager/buttons/lid_battery nothing 



Backports::

    Backports默认在ubuntu11.10(不包括)之前的版本是关闭的。因为在这些版本中,在从Backport安装包之前必须手工开启Backports.
    详情察看 `这儿 <https://help.ubuntu.com/community/UbuntuBackports#Enabling_Backports>`_












