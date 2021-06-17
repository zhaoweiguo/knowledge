les Namespace
#############

此ns是默认开放的2个ns之一

les_serverInfo
==============

+---------+--------------------------------------------+
| Client  | Method invocation                          |
+=========+============================================+
| Go      | les.ServerInfo() map[string]interface{}    |
+---------+--------------------------------------------+
| Console | les.serverInfo()                           |
+---------+--------------------------------------------+
| RPC     | {"method": "les_serverInfo", "params": []} |
+---------+--------------------------------------------+

Example::

    > les.serverInfo
    {
      freeClientCapacity: 16000,
      maximumCapacity: 1600000,
      minimumCapacity: 16000,
      priorityConnectedCapacity: 180000,
      totalCapacity: 1600000,
      totalConnectedCapacity: 180000
    }








