---
title: 源码分析基础工作
date: 2018-09-29 11:46:03
tags:
- erlang
- tsung
- source-analysis
categories:
- source-analysis
---

执行application:start(tsung_controller)时:

    {start_phases, [{load_config, []},{start_os_monitoring,[{timeout,30000}]},
                    {start_clients,[]}]}
    {mod,          {tsung_controller, []}}

### 应用启动相关

ts_config_server相关::

    global
    -record(state, {
      config,
      logdir,   % 日志文件目录
      curcfg = 0,       % number of configured launchers
      client_static_users = 0, % number of clients that already have their static users
      static_users = 0, % static users not yet given to a client
      ports,            % dict, used if we need to choose the client port
      users=1,          % userid (incremental counter)
      start_date,       %
      hostname,         % controller的hostname
      last_beam_id = 0, % last tsung beam id (used to set nodenames)
      ending_beams = 0, % number of beams with no new users to start
      lastips,          % store next ip to choose for each client host
      total_weight      % total weight of client machines
    }

<!--more-->

ts_mon::
  
    global
    -record(state, {
      log,          % 日志文件的fd
      backend,      % type of backend: text|...
      log_dir,      % 
      fullstats,    % fullstats fd
      dump_interval,% 从配置文件中取值:10000
      dumpfile,     % file used when dumptrafic is set light or full
      client=0,     % number of clients currently running
      maxclient=0,  % max of simultaneous clients
      stats,        % 下面的record:Stats
      stop = false, % true if we should stop
      laststats,    % 下面的record:Stats
      lastdate,     % 时间
      type,         % type of logging (none, light, full)
      launchers=0,  % number of launchers started
      timer_ref,    % timer reference (for dumpstats)
      wait_gui=false% wait gui before stopping
    }).

    -record(stats, {
      users_count         = 0,
      finish_users_count  = 0,
      os_mon,   % dict:new():[Mean, Var, Max, Min, Count, MeanFB,CountFB,Last]
      session             = []
    }).

ts_stats_mon::

    global
    % connect,page,request
    -record(state, {
      log,          % log fd
      backend,      % type of backend: text|rrdtool|fullstats
      dump_interval,% 从配置文件中取值:10000
      type = connect,page,request
      fullstats,    % fullstats fd
      stats,        % [0,0,0,0,0,0,0,0]:
      laststats     % values of last printed stats
    }).

    % [id]
    -record(state, {
      log,          % log fd
      backend,      % type of backend: text|rrdtool|fullstats
      dump_interval,% 从配置文件中取值:10000
      type = ts_stats_mon,
      fullstats,    % fullstats fd
      stats,        % 字典:dict:new()
      laststats     % values of last printed stats
    }).

ts_match_logger:

    global
    -record(state, {
      filename,     % "mach.log"
      level,        % type of backend: text|rrdtool|fullstats
      dumpid=1,     % current dump id
      logdir,
      fd            % "mach.log"的fd
    }).


ts_os_mon_sup:

    local，监控专用，【参数】monitor
    ts_os_mon_erlang
    ts_os_mon_munin
    ts_os_mon_snmp

    ts_os_mon_erlang:
    % monitor在同一机器上
    #state{node=node(),mon=MonServer, host=Host, interval=Interval, options=Options}
    % 不在同一机器
    #state{host=Host, mon=MonServer, interval=Interval, options=Options}



ts_timer:

    global,fsm
    -record(state, {
      nclient    = 0, % number of unacked clients
      maxclients = 0, % total number of clients to ack
      pidlist = [],
      timeout=3600000
    }).

ts_msg_server:

    global
    -record(state, {number=0}).

ts_user_server_sup:

    simple_one_for_one

    ts_user_server:
    -record(state, {
      offline,        %ets table
      last_offline,
      connected,      %ets table
      last_connected,
      online,         %ets table
      last_online,
      first_client,   % id (integer)
      random_server_id,  % file_server id for random users
      offline_server_id, % file_server id for initial offline users
      delimiter = << ";" >>,   % delimiter for file_server id username
      userid_max      % max number of ids (starts at 1)
    }).

ts_job_notify:



ts_interaction_server:

    #state{
      to=ets:new(to, []), 
      notify=ets:new(notify, [bag])
    }


### start_phases相关{load_config, []}
作用:

    1.读tsung.xml文件
    设定ts_config_server的status的

config:

    -record(config, {
          name,
          duration, % 超时时间,单位秒.超时会往ts_config_server发送end_tsung的timeout消息
          loglevel = ?WARN,   % 【xml】loglevel
          dump = none,    % 【xml】dumptraffic：
                   "false" -> none;
                   "true"  -> full;
                   "light" -> light;
                   "protocol" -> protocol;
                   "protocol_local" -> protocol_local
          stats_backend,    % 【xml】backend:text
          controller,         % controller machine
          clients = [],       %  [{client,"localhost",10.0,200000,
                                    [{10,140,2,245},
                                     {10,140,2,244},
                                     {10,140,2,241},
                                     {10,140,2,5}],
                                    undefined}]
          servers = [],       % [#server{host  = Server,
                                       port  = Port,
                                       weight= Weight,
                                       type  = Type
                                     }|ServerList]
                              % [{server,"idc-iot-pr-server-2",443,ts_tcp,10}],
          ports_range,        % client ports range
          monitor_hosts = [], % [{"idc-iot-pr-server-4",{erlang,[]}}],
          arrivalphases = [], % [{arrivalphase,1,6000000,undefined,0.001,infinity,6000,[],
                              false,1}],
          thinktime,          % default thinktime specs
          subst    = false,   % Substitution should be applied on the request
          match,              % Match regexp in response
          dynvar   = [],
          main_sess_type , % main type of session
          sessions = [], %  [{session,1,100,ts_http,"http-example",true,false,10000,
                         {proto_opts,negotiate,negotiate,"/http-bind/",false,
                                     false,false,"/chat","binary",[],10,3,
                                     600000,infinity,infinity,32768,32768,
                                     32768,32768,[],true,true},
                         undefined,10,undefined,undefined,undefined,undefined,
                         undefined}]
          static_users=[],
          session_tab,  % 表:ets:new(sessiontable, [ordered_set, protected]),
          use_controller_vm = false, % if true, start the first launcher in the
                                     % same vm as the controller if possible
          curthink,  % temporary var (current request think)
          curid = 0, % temporary var (current request id (can be transaction))
          cur_req_id  = 0,   % temporary var (current real request id)
          file_server = [],  % filenames for file_server
          load_loop,         % loop phases if > 0
          hibernate = 10000, % hibernate timeout (millisec) 10sec by default
          proto_opts,        % tcp/udp buffer sizes，参见后面的proto_opts
          seed = now,        % random seed: (default= current time)
          vhost_file = none, % file server user for virtual host jabber testing
          user_server_maxuid = none, % user_id max
          oids=[],  % [{OID,Name,Type,Fun}| OIDS]
          rate_limit,
          total_popularity = 0, % should be 100 if we use probabilites; sum of all weights if we use weights
          use_weights      , % true if we use weights instead of probabilities
          total_server_weights=0, % 总weights
          job_notify_port,
          max_ssh_startup = 20,
          tag
         }).

    -record(proto_opts,
        {ssl_ciphers   = negotiate, % for ssl only
         ssl_versions  = negotiate, % for ssl only
         bosh_path = "/http-bind/",  % for bash only
         tcp_reuseaddr  = false,  % for tcp reuseaddr
         tcp_reuseport  = false,  % for tcp reuseport
         ip_transparent = false,  % set IP_TRANSPARENT option on the socket
         websocket_path = "/chat",  % for websocket only
         websocket_frame = "binary",  % for websocket only
         websocket_subprotocols = [],     % for websocket only
         retry_timeout = 10,        % retry sending in milliseconds
         max_retries = 3,           % maximum number of retries
         idle_timeout  = 600000,    % timeout for local ack
         connect_timeout  = infinity,   % timeout for gen_tcp:connect/4 (infinity OR time in milliseconds)
         global_ack_timeout = infinity, % timeout for global ack
         tcp_rcv_size  = 32768,     % tcp buffers size
         tcp_snd_size  = 32768,
         udp_rcv_size  = 32768,     % udp buffers size
         udp_snd_size  = 32768,
         certificate = [],          % for ssl
         reuse_sessions = true,     % for ssl
         is_first_connect = true   % whether it's the first connection
        }).



### start_phases相关{start_os_monitoring,[{timeout,30000}]}

  ts_os_mon_sup启动子
  启动monitor,把要监控的server中的cpu,内存,load等信息


### start_phases相关{start_clients,[]}]}

  ts_mon启动子
  加载tsung,并启动
  % ts_launcher_static:
  gen_fsm:send_event({?MODULE, Node}, {launch, Sessions, atom_to_list(Host)}).
  % ts_launcher:
  gen_fsm:send_event({?MODULE, Node}, {launch, Arrivals, atom_to_list(Host), Seed}).
  







