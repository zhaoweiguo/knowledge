使用ELPA, MELPA安装
====================

说明::

  Starting with emacs 24 (year 2012)


快速开始::

  1.在emacs初始页面增加
  ;; load emacs 24's package system. Add MELPA repository.
  (when (>= emacs-major-version 24)
    (require 'package)
    (add-to-list
      'package-archives
      ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
      '("melpa" . "http://melpa.milkbox.net/packages/")
    t))

  2.重启emacs
  
使用::

  emacs>Alt+x list-packages

  Enter: package-menu-describe-package,展开详细描述
  i: package-menu-mark-install,标注安装
  u: package-menu-mark-unmark,取消标注
  d: package-menu-mark-delete,标注删除
  x: package-menu-execute,执行
  r: package-menu-refresh,刷新
  U: package-menu-mark-upgrades, 标注升级(注意:最好是先删除再安装)

卸载::

  删除文件夹 ~/.emacs.d/elpa/
  重启emacs就行

摘自::

  http://ergoemacs.org/emacs/emacs_package_system.html
  
