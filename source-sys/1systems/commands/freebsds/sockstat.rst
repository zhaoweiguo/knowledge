sockstat命令
####################

::

    list open sockets

常用命令::

    sockstat -4L
    sockstat -c     // Show connected sockets.
    sockstat -l     // show listening sockets
    sockstat -p <ports>     // Only show sockets if port number is specified list.
    sockstat -P <protocols>     // Only show sockets of the specified protocols.<protocols>is comma-seperated list of protocol names.




