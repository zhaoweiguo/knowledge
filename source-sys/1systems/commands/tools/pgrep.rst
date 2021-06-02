.. _pgrep:

pgrep命令(与命令pkill关系密切)
########################################


列出进程名为sshd，所有者为root的进程号列表::

    pgrep -u root sshd

列出所有者为root或daemon的进程号列表::

    pgrep -u root,daemon

列出进程名有nginx的进程列表::

    pgrep nginx

列出进程名exactly为nginx的进程号列表::

    pgrep -x nginx

列出进程名exactly为nginx的,并且进程号间用 ``,`` 分隔的列表::

    pgrep -d, -x nginx





