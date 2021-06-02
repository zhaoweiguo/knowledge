.. _emacs_command_bookmark:

书签管理
=============

* 设置书签 ``C-x r m <name> (M-x bookmark-set)``
* 跳转到书签 ``C-x r b <name> (M-x bookmark-jump)``
* 书签列表 ``C-x r l (M-x bookmark-bmenu-list)``
* 删除书签 ``(M-x bookmark-delete)``
* 读取存储书签文件 ``(M-x bookmark-load)``

* 书签默认存储在 ``~/.emacs.bmk`` 文件中
* 在配置文件中，可以设置书签存储的文件::

    ;; 书签文件的路径及文件名
    (setq bookmark-default-file "~/.emacs.d/.emacs.bmk")

    ;; 同步更新书签文件 ;; 或者退出时保存
    (setq bookmark-save-flag 1)


