配置文件
##########

store.backend
=============

::

    Default: "memory"

Key-Value backends::

    btree: An in-memory store, used mostly to quickly verify KV backend functionality.
    leveldb: A persistent on-disk store backed by LevelDB.
    bolt: Stores the graph data on-disk in a Bolt file. 
        Uses more disk space and memory than LevelDB for smaller stores, 
        but is often faster to write to and comparable for large ones, 
        with faster average query times.

NoSQL backends::

    mongo: Stores the graph data and indices in a MongoDB instance.
    elastic: Stores the graph data and indices in a ElasticSearch instance.
    couch: Stores the graph data and indices in a CouchDB instance.
    pouch: Stores the graph data and indices in a PouchDB. Requires building with GopherJS.

SQL backends::

    postgres: Stores the graph data and indices in a PostgreSQL instance.
    cockroach: Stores the graph data and indices in a CockroachDB cluster.
    mysql: Stores the graph data and indices in a MySQL or MariaDB instance.
    sqlite: Stores the graph data and indices in a SQLite database.

store.address
=============

::

    Type: String
    Default: ""
    Alias: store.path

store.read_only
===============

::

    Type: Boolean
    Default: false

Configuration File Location
===========================

Cayley looks in the following locations for the configuration file (named cayley.yml or cayley.json)::

    Command line flag
    The environment variable $CAYLEY_CFG
    Current directory
    $HOME/.cayley/
    /etc/



