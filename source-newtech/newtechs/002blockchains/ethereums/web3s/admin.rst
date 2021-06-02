admin Namespace
---------------

::

    > admin
    // 看看 networkid
    > admin.nodeInfo.protocols.eth.network

    // 确保网络可用 
    > net.listening
    // 节点地址
    > admin.nodeInfo.enode      

    查看节点
    // 列出节点IP地址
    > admin.peers.forEach(function(p) {console.log(p.network.remoteAddress);})
    // networkid
    > admin.nodeInfo.protocols.les.network

查看节点数量::

    > net.peerCount
    2


admin_addPeer(添加节点)
=======================

+---------+----------------------------------------------+
| Client  | Method invocation                            |
+=========+==============================================+
| Go      | admin.AddPeer(url string) (bool, error)      |
+---------+----------------------------------------------+
| Console | admin.addPeer(url)                           |
+---------+----------------------------------------------+
| RPC     | {"method": "admin_addPeer", "params": [url]} |
+---------+----------------------------------------------+

Example::

    > admin.addPeer('enode://9f6490ffb5236f2ddc5710ae73d47c740e0a3644bbd2d67029cf4a6c4693d2f470b642fd2cc3507f7e851df60aaeb730a1270b7a477f91ec5b6b17a8a4b40527@172.16.0.1:30303') 
    true  

admin_datadir(查看存储目录)
===========================

+---------+---------------------------------+
| Client  | Method invocation               |
+=========+=================================+
| Go      | admin.Datadir() (string, error) |
+---------+---------------------------------+
| Console | admin.datadir                   |
+---------+---------------------------------+
| RPC     | {"method": "admin_datadir"}     |
+---------+---------------------------------+

Example::

    > admin.datadir
    "/home/john/.ethereum"


admin_nodeInfo(显示当前节点信息)
================================

+---------+-----------------------------------------+
| Client  | Method invocation                       |
+=========+=========================================+
| Go      | admin.NodeInfo() (p2p.NodeInfo, error)  |
+---------+-----------------------------------------+
| Console | admin.nodeInfo                          |
+---------+-----------------------------------------+
| RPC     | {"method": "admin_nodeInfo"}            |
+---------+-----------------------------------------+

实例::

    > admin.nodeInfo
    {
      Name: 'Geth/v0.9.14/darwin/go1.4.2',
      NodeUrl: 'enode://3414c01c19aa75a34f2dbd2f8d0898dc79d6b219ad77f8155abf1a287ce2ba60f14998a3a98c0cf14915eabfdacf914a92b27a01769de18fa2d049dbf4c17694@[::]:30303',
      NodeID: '3414c01c19aa75a34f2dbd2f8d0898dc79d6b219ad77f8155abf1a287ce2ba60f14998a3a98c0cf14915eabfdacf914a92b27a01769de18fa2d049dbf4c17694',
      IP: '::',
      DiscPort: 30303,
      TCPPort: 30303,
      Td: '2044952618444',
      ListenAddr: '[::]:30303'
    }

    > admin.nodeInfo
    {
      enode: "enode://44826a5d6a55f88a18298bca4773fca5749cdc3a5c9f308aa7d810e9b31123f3e7c5fba0b1d70aac5308426f47df2a128a6747040a3815cc7dd7167d03be320d@[::]:30303",
      id: "44826a5d6a55f88a18298bca4773fca5749cdc3a5c9f308aa7d810e9b31123f3e7c5fba0b1d70aac5308426f47df2a128a6747040a3815cc7dd7167d03be320d",
      ip: "::",
      listenAddr: "[::]:30303",
      name: "Geth/v1.5.0-unstable/linux/go1.6",
      ports: {
        discovery: 30303,
        listener: 30303
      },
      protocols: {
        eth: {
          difficulty: 17334254859343145000,
          genesis: "0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3",
          head: "0xb83f73fbe6220c111136aefd27b160bf4a34085c65ba89f24246b3162257c36a",
          network: 1
        }
      }
    }


admin_peers(连接结点详情)
=========================

+---------+----------------------------------------+
| Client  | Method invocation                      |
+=========+========================================+
| Go      | admin.Peers() ([]p2p.PeerInfo, error)  |
+---------+----------------------------------------+
| Console | admin.peers                            |
+---------+----------------------------------------+
| RPC     | {"method": "admin_peers"}              |
+---------+----------------------------------------+

::

    > admin.peers
    [{
      ID: 'a4de274d3a159e10c2c9a68c326511236381b84c9ec52e72ad732eb0b2b1a2277938f78593cdbe734e6002bf23114d434a085d260514ab336d4acdc312db671b',
      Name: 'Geth/v0.9.14/linux/go1.4.2',
      Caps: 'eth/60',
      RemoteAddress: '5.9.150.40:30301',
      LocalAddress: '192.168.0.28:39219'
    }, {
      ID: 'f4642fa65af50cfdea8fa7414a5def7bb7991478b768e296f5e4a54e8b995de102e0ceae2e826f293c481b5325f89be6d207b003382e18a8ecba66fbaf6416c0',
      Name: '++eth/Zeppelin/Rascal/v0.9.14/Release/Darwin/clang/int',
      Caps: 'eth/60, shh/2',
      RemoteAddress: '129.16.191.64:30303',
      LocalAddress: '192.168.0.28:39705'
    } ]

    > admin.peers
    [{
        caps: ["eth/61", "eth/62", "eth/63"],
        id: "08a6b39263470c78d3e4f58e3c997cd2e7af623afce64656cfc56480babcea7a9138f3d09d7b9879344c2d2e457679e3655d4b56eaff5fd4fd7f147bdb045124",
        name: "Geth/v1.5.0-unstable/linux/go1.5.1",
        network: {
          localAddress: "192.168.0.104:51068",
          remoteAddress: "71.62.31.72:30303"
        },
        protocols: {
          eth: {
            difficulty: 17334052235346465000,
            head: "5794b768dae6c6ee5366e6ca7662bdff2882576e09609bf778633e470e0e7852",
            version: 63
          }
        }
    }, 
    ...]

admin_startRPC
==================

+---------+---------------------------------------------------------------------------------------------+
| Client  | Method invocation                                                                           |
+=========+=============================================================================================+
| Go      | admin.StartRPC(host string, port rpc.HexNumber, cors string, apis string) (bool, error)     |
+---------+---------------------------------------------------------------------------------------------+
| Console | admin.startRPC(host, port, cors, apis)                                                      |
+---------+---------------------------------------------------------------------------------------------+
| RPC     | {"method": "admin_startRPC", "params": [host, port, cors, apis]}                            |
+---------+---------------------------------------------------------------------------------------------+

Example::

    > admin.startRPC("127.0.0.1", 8545)
    true

admin_startWS
=============

+---------+--------------------------------------------------------------------------------------------+
| Client  | Method invocation                                                                          |
+=========+============================================================================================+
| Go      | admin.StartWS(host string, port rpc.HexNumber, cors string, apis string) (bool, error)     |
+---------+--------------------------------------------------------------------------------------------+
| Console | admin.startWS(host, port, cors, apis)                                                      |
+---------+--------------------------------------------------------------------------------------------+
| RPC     | {"method": "admin_startWS", "params": [host, port, cors, apis]}                            |
+---------+--------------------------------------------------------------------------------------------+

Example::

    > admin.startWS("127.0.0.1", 8546)
    true

admin_stopRPC
=============

+---------+-------------------------------+
| Client  | Method invocation             |
+=========+===============================+
| Go      | admin.StopRPC() (bool, error) |
+---------+-------------------------------+
| Console | admin.stopRPC()               |
+---------+-------------------------------+
| RPC     | {"method": "admin_stopRPC"}   |
+---------+-------------------------------+

Example::

    > admin.stopRPC()
    true

admin_stopWS
============

+---------+------------------------------+
| Client  | Method invocation            |
+=========+==============================+
| Go      | admin.StopWS() (bool, error) |
+---------+------------------------------+
| Console | admin.stopWS()               |
+---------+------------------------------+
| RPC     | {"method": "admin_stopWS"    |
+---------+------------------------------+

Example::

    > admin.stopWS()
    true



