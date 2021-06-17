.. _emacs_mode:

emacs架构
####################


.. figure:: /images/emacs/emacs_mode.jpg
   :width: 120%




::

    C_h v load-path
    (add-to-list 'load-path "/home/gordon/emacs")

emacs重新载入文件::

   M-x revert-buffer(if you want you can bind it to a key)
   or use a more practice trick: use C-x C-v RET


把連续两个回车换成一个回车::

    M-x replace-string RET C-Q C-J RET C-Q C-J C-Q C-J RET

在每行的开头增加一字符串"bloogie"::

    M-x replace-string RET C-Q C-J RET C-Q C-J bloogie SPACE RET

调出菜单::

    F10
    M+x menu-bar-open
    M+~

MySQL相关::

  M-x sql-help    // 查帮助
  M-x sql-mysql      // 可以直接登录mysql


其他::

  M-x list-packages RET    // 
