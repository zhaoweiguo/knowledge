.. _source:

源码分析
##############

cowboy
===========
::

    cowboy_sup -> cowboy_clock



ets表
-------
cowboy_clock::

    {rfc1123, "Sun, 06 Nov 1994 08:49:37 GMT"}




ranch
============

ranch_sup::

    ranch_server
    {ranch_listener_sup, Ref}

ranch_listener_sup::

    // 参数:[Ref, Transport, TransOpts, Protocol, ProtoOpts]}
    // Transport: ranch_tcp
    // Protocol: cowboy_clear
    ranch_conns_sup
        参数: [Ref, Transport, Protocol]
    ranch_acceptors_sup
        参数: [Ref, Transport]

ranch_acceptors_sup::

    {{acceptor, self(), N}, {ranch_acceptor, start_link, [
        LSocket, Transport, Logger, ConnsSup
      ]}, permanent, brutal_kill, worker, []}

TransOpts::
    
    [{
        port = 8081, 
        connection_type = supervisor,
        max_connections = 1024,
        shutdown = 5000,
        handshake_timeout = 5000,
        logger = error_logger,
        num_acceptors = 10,
        socket = undefined,
        socket_opts = [],
    }],
    
ProtoOpts::

    #{env => #{
        dispatch => Dispatch, 
        connection_type = supervisor,
        proxy_header = false,
        max_keepalive = 100,
        
    }},

其他::

    ranch:start_listener(Ref, ranch_tcp, TransOpts, cowboy_clear, ProtoOpts).


gen_server
----------------

ranch_server::

    #state{monitors=[
        {{MonitorRef, Pid}, {listener_sup, Ref}}
    ]




ets表
---------

ranch_server::

    // [ordered_set, public, named_table]
    {{conns_sup, Ref}, Pid}
    {{listener_sup, Ref}, Pid}
    {{max_conns, Ref}, MaxConns}
    {{trans_opts, Ref}, TransOpts}
    {{proto_opts, Ref}, ProtoOpts}
    {{listener_start_args, Ref}, StartArgs}
        StartArgs = [Ref, Transport, TransOpts, Protocol, ProtoOpts]
    {{addr, Ref}, Addr}







