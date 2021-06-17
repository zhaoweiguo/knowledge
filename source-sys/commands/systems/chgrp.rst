.. _chgrp:

chgrp命令使用
=======================
::

    chgrp <归属群组> <文件|目录>

更改文件的归属群组。可以使用群组名或者 GID参数同上
::

    SUID、SGID、Sticky bit

某些情况下,需要以可执行文件归属用户的身份执行该文件,可以为该文件设置 SUID。同样,设置 SGID 能够以该文件归属群组的身份执行它。
例如:用户自行设定密码。出于安全方面的考虑, /etc/shadow 只能由 root 用户直接修改::

         -rw——- root root /etc/shadow

这个时候,可以为程序 /usr/bin/passwd 设置 SUID,当普通用户执行“passwd”命令时,便能够以该程序归属用户 root 的身份修改 /etc/shadow 文件。而“passwd”程序自身带有身份验证机制,不能通过验证时拒绝执行,从而保证了安全::

         ls -l /usr/bin/passwd
         -r-s–x–x root root /usr/bin/passwd

我们发现,归属用户的可执行权限位使用 s ,表示 SUID。同样,归属群组的可执行权限位使用 s , 表示 SGID。  任何用户或群组都拥有 其它用户 的权限,  所以不需要以 其它用户身份执行文件,其它用户的可执行权限位便不会出现 s 。该权限位可能出现的属性为 t ,也就是粘着位 Sticky bit::

         ls -ld /tmp
         drwxrwxrwt root root /tmp

粘着位表示任何用户都可能具有写权限,但只有该归属用户或 root 用户才能够删除SUID、SGID、Sticky bit 也可以像权限一样,使用一个八进制数表示,如下::

         4       SUID
         2       SGID
         1       Sticky bit

通过在“chmod”命令中使用 4 个八进制数的表达式, 4755 ,  如用第一位表示 SUID、SGID、或 Sticky bit,便能够为文件设置这些特殊权限。示例::

          chmod -R 4755 path

