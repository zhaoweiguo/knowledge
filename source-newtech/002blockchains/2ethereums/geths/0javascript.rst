JavaScript Console
##################

Interactive Use: The Console
============================

连接::

    $ geth console
    $ geth attach

指定ipc连接::

    # geth attach /some/custom/path.ipc
    # geth attach http://191.168.1.1:8545
    # geth attach ws://191.168.1.1:8546

注::

    默认不打开rcp端口, 可以用
    1. geth结点启动时指定: --rpcapi and --wsapi
    2. 使用命令 admin.startRPC and admin.startWS.
       > admin.startRPC("127.0.0.1", 8545)
      true
      > admin.startWS("127.0.0.1", 8546)
      true

Non-interactive Use: Script Mode
================================

简单实例::

    $ geth attach --exec "eth.blockNumber"

复杂实例::

    $ geth attach http://geth.example.org:8545 --exec 'loadScript("/tmp/checkbalances.js")'
    $ geth attach http://geth.example.org:8545 --jspath "/tmp" --exec 'loadScript("checkbalances.js")'



