mongoc
#############

client with automatic MongoDB topology discovery and monitoring


Connection
--------------

    {ok, Topology} = mongo_api:connect(Type, Hosts, Options, WorkerOptions)

    "hostname:27017"
    { single, "hostname:27017" }

    { rs, <<"ReplicaSetName">>, [ "hostname1:port1", "hostname2:port2"] }

    { sharded,  ["hostname1:port1", "hostname2:port2"] }

    { unknown,  ["hostname1:port1", "hostname2:port2"] }

Options::

    [
        { name,  Name },    % Name should be used for mongoc pool to be registered with
        { register,  Name },    % Name should be used for mongoc topology process to be registered with

        { pool_size, 5 }, % pool size on start
        { max_overflow, 10 }, % number of overflow workers be created, when all workers from pool are busy
        { overflow_ttl, 1000 }, % number of milliseconds for overflow workers to stay in pool before terminating
        { overflow_check_period, 1000 }, % overflow_ttl check period for workers (in milliseconds)

        { localThresholdMS, 1000 }, % secondaries only which RTTs fit in window from lower RTT to lower RTT + localThresholdMS could be selected for handling user's requests

        { connectTimeoutMS, 20000 },
        { socketTimeoutMS, 100 },

        { serverSelectionTimeoutMS, 30000 }, % max time appropriate server should be select by
        { waitQueueTimeoutMS, 1000 }, % max time for waiting worker to be available in the pool

        { heartbeatFrequencyMS, 10000 },    %  delay between Topology rescans
        { minHeartbeatFrequencyMS, 1000 },

        { rp_mode, primary }, % default ReadPreference mode - primary, secondary, primaryPreferred, secondaryPreferred, nearest

        { rp_tags, [{tag,1}] }, % tags that servers shoul be tagged by for becoming candidates for server selection  (may be an empty list)
    ]

WorkerOptions::

    -type arg() :: {database, database()}
    | {login, binary()}
    | {password, binary()}
    | {w_mode, write_mode()}.



