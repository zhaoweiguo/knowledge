.. _emacs_usage:

emacs使用
######################
常用命令::

  显示行号: M-x linum-mode
  保存并退出: C-x C-c (M-x save-buffers-kill-emacs)
  打开文件、目录: C-x C-f (M-x find-file)
  以只读模式打开: C-x C-r (M-x find-file-read-only)
  保存 : C-x C-s (M-x save-buffer)
  另存为文件: C-x C-w (M-x write-file)



基础编辑::

    按指定行数前进、后退 ``M-g g    M-g M-g``
    按行号跳转 ``M-x goto-line``
    按段落前进、后退: M-{    M-}


    剪切光标至行末 ``C-k  (M-x kill-line)``
    剪切整行 ``C-S-backspace   (M-x kill-whole-line)``

    复制 ``M-w (M-x kill-ring-save)``
    粘贴 ``C-y (M-x yank)``
    粘贴之前的 ``M-y (M-x yank-pop)`` (和上面命令联合使用)
    撤消之前的修改 ``C-/ (M-x undo)``
    撤消之前的修改 ``C-_ (M-x undo)``
    撤消之前的修改 ``C-x u (M-x advertised-undo)``


搜索和替换::

    // 增量搜索:
    向前增量搜索 ``C-s (M-x isearch-forward)``
    向后增量搜索 ``C-r (M-x isearch-backward)``
    正则表达式向前增量搜索 ``C-M-s (M-x isearch-forward-regexp)``
    正则表达式向后增量搜索 ``C-M-r (M-x isearch-backward-regexp)``

    // 询问替换:
    询问替换 ``M-% (M-x query-replace)``
    正则表达式询问替换 ``C-M-% (M-x query-replace-regexp)``

    // 搜索:
    向前搜索 ``(M-x search-forward)``
    向后搜索 ``(M-x search-backward)``
    正则表达式向前搜索 ``(M-x search-forward-regexp)``
    正则表达式向后搜索 ``(M-x search-backward-regexp)``

    // 替换:
    替换后面所有的 ``(M-x replace-string)``
    正则表达式替换 ``M-x replace-regexp``

其他::

    把后面单词变大写: M-u
    把后面单词变小写: M-l

    Shell 模式 ``(M-x shell)``


帮助命令列表::

    Emacs快捷指南 ``C-h t``
    Emacs使用手册 ``C-h r``
    在线帮助 ``C-h i``
    搜索命令 ``C-h a (M-x apropos-command)
    函数说明 ``C-h f (M-x describe-function)
    变量说明 ``C-h v (M-x describe-variable)
    键绑定说明 ``C-h k (M-x describe-key)
    键绑定简略说明 ``C-h c  (M-x describe-key-briefly)
    查找键绑定 ``C-h w   ``C-h w (M-x where-is)



查询内部命令::

  查询键盘操作绑定的命令 C-h k <你输入键盘操作>
  以简洁模式查询键盘操作绑定的命令 C-h c  <你输入键盘操作>

Emacs 终端::

  激活 Emacs 终端, 可以在 Emacs 终端中使用外部命令:
  M-x shell

  临时执行一条外部命令, 并输出在名为 *Shell Command Output* 的缓冲区中:
  M-!

  临时执行一条外部命令, 并输出到光标位置:
  C-u M-! 

中止执行::

  C-g (M-x keyboard-quit)
  ESC ESC ESC (M-x keyboard-escape-quit)``





常见编程语言支持::

  ``M-x <语言>-mode``, 其中语言有(关键字 ``Emacs 语言 mode``)::

    erlang
    sh

    rst
    emacs-lisp

    php
    python
    perl
    

命令使用列表::

    C-       按住 Ctrl键
    M-       按住 Meta键, 在 PC 上, Meta键, 通常对应 Alt 键
    C-M-     同时按住 Ctrl键 和 Meta键
    S-       Shift键
    s-       Linux 下对应 WIN 键
    RET      回车键
    TAB      Tab键
    ESC      Esc键
    SPC      空格键
    DEL      退格键
    Delete   删除键







