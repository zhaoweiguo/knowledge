.. _emacs_command_window:

窗格和缓冲区管理
====================
多窗格::

    分隔出两个垂直窗格, 水平分隔线 ``C-x 2 (M-x split-window-vertically)``
    分隔出两个水平窗格, 垂直分隔线 ``C-x 3 (M-x split-window-horizontally)``
    只保留当前窗格 ``C-x 1 (M-x delete-other-window)``
    只保留当前窗格 ``ESC ESC ESC (M-x keyboard-escape-quit)``
    关闭当前窗格 ``C-x 0 (M-x delete-window)``
    在下一个窗格中激活光标 ``C-x o (M-x other-window)``
    向下卷动下一个窗格, 使用负参数可以向上卷动 ``C-M-v (M-x scroll-other-window)``

多缓冲区::

    查看缓冲区列表 ``C-x C-b (M-x list-buffers)``
    切换到其它缓冲区 ``C-x b (M-x switch-to-buffer)``
    关闭当前缓冲区 ``C-x k (M-x kill-buffer)``
    建议使用 ibuffer.el 这个扩展(Emacs 自带), 在配置文件中添加如下语句::

    (require 'ibuffer)
    (global-set-key ( kbd "C-x C-b ")' ibuffer)

另一个缓冲区列表的扩展(Emacs 自带)::

    ;;CRM bufer list
    (global-set-key "\C-x\C-b" 'electric-buffer-list) 
