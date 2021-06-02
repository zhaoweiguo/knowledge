zookeeper.properties
###########################

.. code-block:: jproperties

    # the directory where the snapshot is stored.
    dataDir=/tmp/zookeeper
    # the port at which the clients will connect
    clientPort=2181
    # disable the per-ip limit on the number of connections since this is a non-production config
    maxClientCnxns=0

    initLimit=10
    syncLimit=5
    tickTime=200
    server.0=10.128.133.252:2888:3888
    server.1=10.128.132.1:2888:3888
    server.2=10.128.132.2:2888:3888







