NETWORKING OPTIONS
==================

--bootnodes::

    指定服务发现的bootnodes
    $ geth --bootnodes enode://pubkey1@ip1:port1,enode://pubkey2@ip2:port2,enode://pubkey3@ip3:port3

--nodiscover::

    禁止服务发现
    一般只用于test node or an experimental test network

--port value::

    Network listening port (default: 30303)

--netrestrict value::

    Restricts network communication to the given IP networks (CIDR masks)

    $ geth <other-flags> --netrestrict 172.16.254.0/24

--nat value::

      NAT port mapping mechanism (any|none|upnp|pmp|extip:<IP>) (default: "any")

      $ geth --datadir data --networkid 15 --nat extip:172.16.254.4




