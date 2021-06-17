.. _emacs_command_other:

数字参数
===========

* Ctrl+u 向命令传递参数 ``C-u (#) command, C-u (#) M-x <universal-argument>``
* 实例(向前10个字符)::

    C-u 10 C-f
    C-u 10 M-x forward-char

* 不理解::

    M-(#) (command)
    negative-argument （负参数）
    M-[1-9] 快速参数
    digit-argument （数字参数）

其它
========

* 插入控制字符 ``C-q <control chars>``, 实例::

    C-q C-m = ^M

* 文本换位::

    字符    C-t         M-x transpose-chars
    单词    M-t         M-x transpose-words
    行      C-x C-t     M-x transpose-lines

* 将TAB 字符转换为空格, ``选中需要转换的区域 (M-x untabify)``
* 对齐文本块, ``选中需要对齐的区域 (M-x indent-region)``

* 服务器模式:

    * 启动一个 Emacs 的守护进程::

        emacs --daemon

    * 然后通过 emacsclient 来连接服务器::

        emacsclient  -t  --alternate-editor jed  file

    * **-t** 在当前控制台打开 emacs 窗口
    * **--alternate-editor jed** 如果不能连接到 emacs 服务器, 则使用 jed 编辑器

* 也可以使用 Emacs 服务器模式，M-x server-start 或者在配置文件中添加 (server-start) 启用 Emacs 服务器，使用 emacs-client 连接





基本操作::

  * 挂起(最小化) ``C-x C-z (M-x iconify-or-deiconify-frame)``
  * 打开文件、目录 ``C-x C-f (M-x find-file)``::

    /host:filename  
    /user@host:filename  
    /user@host#port:filename  
    /method:user@host:filename  
    /method:user@host#port:filename  

    * method可以是: ftp,ssh,rlogin,telnet等可以远程登录的程序, 其缺省的是 
    * 如果主机名称以"ftp."开始，那就用ftp
    * 如果用户名称是ftp或者anonymous，那也用ftp
    * 其余的缺省是ssh


  * 插入文件内容 ``C-x i M-x insert-file``
  * 询问, 保存所有未保存的缓冲区 ``C-x s  (M-x save-some-buffers)``
  * 以指定编码读取文件 ``C-x RET r  (M-x revert-buffer-with-coding-system)``
  * 以指定编码保存文件 ``C-x RET f  (M-x set-buffer-file-coding-system)``
  * 恢复到原始状态 ``(M-x revert-buffer)``


