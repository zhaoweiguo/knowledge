---
title: 看源码前准备工作
date: 2018-09-29 11:46:03
tags:
- erlang
- tsung
- source-analysis
categories:
- source-analysis
---

### tsung start真实执行命令

查看/usr/local/bin/tsung文件:

    此文件是sh文件，tsung start实际执行的是start方法

当我们执行tsung -f fetch_user_key.xml start时,我们实际执行:

    /usr/local/lib/erlang/erts-8.3.5.4/bin/beam.smp -A 8 -K true -P 250000 
    -- -root /usr/local/lib/erlang -progname erl 
    -- -home /root 
    -- -smp auto -rsh ssh -noshell -proto_dist inet_tcp 

    -sname tsung_controller 
    -setcookie tsung 

    -kernel inet_dist_listen_min 64000 
    -kernel inet_dist_listen_max 65500 

    -s tsung_controller

    -pa /usr/local/lib/tsung/tsung-1.7.0/ebin 
    -pa /usr/local/lib/tsung/tsung_controller-1.7.0/ebin 

    -ssl session_cb ts_ssl_session_cache 
    -ssl session_lifetime 600 
    -sasl sasl_error_logger false 

    -tsung_controller web_gui true 
    -tsung_controller keep_web_gui false 
    -tsung_controller smp_disable true 
    -tsung_controller debug_level 5 
    -tsung_controller warm_time 1 
    -tsung_controller exclude_tag "" 
    -tsung_controller config_file "fetch_user_key.xml" 
    -tsung_controller log_dir "/root/.tsung/log/" 
    -tsung_controller mon_file "tsung.log"

<!--more-->

##### 配置选项

tsung_controller.app:

    {debug_level, 6},
    {smp_disable, true}, % disable smp on clients
    {ts_cookie, "humhum"},
    {clients_timeout, 60000},    % timeout for global synchro
    {file_server_timeout, 30000},% timeout for reading file
    {warm_time, 1}, % (seconds) initial waiting time when launching clients

    {thinktime_value, "5"}, % default value = 5sec
    {thinktime_override, "false"},
    {thinktime_random, "false"},

    {global_number, 100},
    {global_ack_timeout, 3600000}, %in msec

    {munin_port, 4949},

    {snmp_port, 161},
    {snmp_version, v2},
    {snmp_community, "public"},

    {mysql_port, 3306},
    {mysql_user, "root"},
    {mysql_password, false},

    {dumpstats_interval, 10000},
    {dump, none},          %% full or light or none
    {stats_backend, none}, %% text|rrdtool

    {nclients, 10},        %% number of clients
    {nclients_deb, 1},     %% beginning of interval
    {nclients_fin, 2000},     %% end of interval
    {config_file, "./tsung.xml"},
    {log_file, "./tsung.log"},
    {match_log_file, "./match.log"},
    {exclude_tag, ""},
    {template_path, beam_relative}

tsung.app:

    {debug_level, 2},
    {snd_size, 32768},      % send buffer size
    {rcv_size, 32768},      % receive buffer size
    {idle_timeout, 600000},  % 10min timeout
    {global_ack_timeout, infinity}, % global ack timeout
    {connect_timeout, 30000},
    {max_warm_delay, 15000},
    {dump, full},           % full or light
    {parse_type, noparse},
    {persistent, true},  % persistent connection: true or false
    {mes_type, dynamic}, % dynamic or static
    {nclients, 10},      % number of client to connect
    {log_file, "./tsung.log"}, % log file name
    %% use for IMS GET :
    {http_modified_since_date, "Fri, 14 Nov 2003 02:43:31 GMT"},
    {client_retry_timeout, 10}, % retry sending (in microsec.)
    {max_retries, 3},        % number of max retries
    {ssl_ciphers, negotiate},
    {ssl_versions, negotiate},

    {jabber_users, 2000000},
    {jabber_username, "c"},
    {jabber_password, "pas"},
    {jabber_domain, "mydomain.com"},

    {websocket_path, "/chat"}

表:

    2> ets:i().
     id              name              type  size   mem      owner
     ----------------------------------------------------------------------------
     1                         code                       set   411    25810    code_server
     4098                      code_names                 set   51     6739     code_server
     8206                      cookies                    set   0      298      auth
     12305                     shell_records              ordered_set 0      88       <0.58.0>
     20499                     ssl_otp_cacertificate_db   set   0      298      ssl_manager
     24596                     ssl_otp_ca_file_ref        set   0      298      ssl_manager
     28693                     ssl_otp_ca_ref_file_mapping set   0      298      ssl_manager
     32790                     ssl_otp_crl_cache          set   0      298      ssl_manager
     36887                     ssl_otp_crl_issuer_mapping bag   0      298      ssl_manager
     40984                     ts_ssl_session_cache       set   0      298      ssl_manager
     45081                     ts_ssl_session_cache       set   0      298      ssl_manager
     49180                     httpc_manager__session_cookie_db bag   0      298      httpc_manager
     53279                     jobs                       set   0      298      <0.116.0>
     57376                     to                         set   0      298      <0.117.0>
     61473                     notify                     bag   0      298      <0.117.0>
     69666                     sessiontable               ordered_set 12     1564     <0.104.0>
     73763                     ign_requests               set   0      298      inet_gethost_native
     77860                     ign_req_index              set   0      298      inet_gethost_native
     81959                     sessiontable               set   4      1087     ts_session_cache
     ac_tab                    ac_tab                     set   98     3859     application_controller
     file_io_servers           file_io_servers            set   5      789      file_server_2
     global_locks              global_locks               set   0      298      global_name_server
     global_names              global_names               set   14     578      global_name_server
     global_names_ext          global_names_ext           set   0      298      global_name_server
     global_pid_ids            global_pid_ids             bag   0      298      global_name_server
     global_pid_names          global_pid_names           bag   28     536      global_name_server
     httpc_manager__handler_db httpc_manager__handler_db  set   0      298      httpc_manager
     httpc_manager__session_db httpc_manager__session_db  set   0      298      httpc_manager
     httpd_conf_8091default    httpd_conf_8091default     bag   11     576      httpd_8091default
     httpd_mime_8091           httpd_mime_8091            set   6      526      httpd_8091default
     inet_cache                inet_cache                 bag   0      298      inet_db
     inet_db                   inet_db                    set   29     595      inet_db
     inet_hosts_byaddr         inet_hosts_byaddr          bag   0      298      inet_db
     inet_hosts_byname         inet_hosts_byname          bag   0      298      inet_db
     inet_hosts_file_byaddr    inet_hosts_file_byaddr     bag   0      298      inet_db
     inet_hosts_file_byname    inet_hosts_file_byname     bag   0      298      inet_db
     ssl_pem_cache             ssl_pem_cache              set   0      298      ssl_pem_cache
     sys_dist                  sys_dist                   set   1      363      net_kernel
     timer_interval_tab        timer_interval_tab         set   1      318      timer_server
     timer_tab                 timer_tab                  ordered_set 2      134      timer_server

表sessiontable::

    [{{1,1},{setdynvars,server,{},[host,port]}},
     {{1,2},{setdynvars,value,{string,"30000000000"},[startnum]}},
     {{1,3},
      {ts_request,parse,true,[],
                  [{jsonpath,userid,"user.user_id"},
                   {jsonpath,sessionid,"user.session_id"}],
                  {http_request,"/v2.0/fetch/user_key","1.1",
                                "idc-iot-pr-server-2:443",undefined,[],post,
                                "application/x-www-form-urlencoded",
                                [{"Content-Type","application/json"}],
                                <<"%%fetch_user_key:getmessage%%">>,0,undefined,undefined,
                                undefined,undefined,undefined,undefined,undefined,...},
                  true,"idc-iot-pr-server-2",443,ts_tcp}},
     {{1,4},
      {change_type,ts_websocket,"%%_host%%","%%_port%%",ts_tcp,
                   true,true,true}},
     {{1,5},
      {ts_request,parse,true,[],[],
                  {websocket_request,"13",connect,
                                     "/client/comet?user_id=%%_userid%%&mac=%%_userid%%&locale=zh&ver=v2.0",
                                     "binary",[],[],"\n"},
                  false,undefined,undefined,undefined}},
     {{1,6},
      {ts_request,parse,true,[],[],
                  {websocket_request,"13",message,"/","text",[],[],
                                     "{\"msg_type\":\"check_sid\",\"version\":\"v1.0.1\",\"qos\":1,\"sequence_id\": \"123445\",\"request\":{\"sid\":\"%%_sessionid%%\"}}"},
                  true,undefined,undefined,undefined}},
     {{1,7},{ctrl_struct,{for_start,1,counter}}},
     {{1,8},
      {ts_request,parse,true,[],[],
                  {websocket_request,"13",message,"/","text",[],[],
                                     "{\"mt\":\"k\"}"},
                  true,undefined,undefined,undefined}},
     {{1,9},{thinktime,30000}},
     {{1,10},{ctrl_struct,{for_end,counter,20000,1,8}}},
     {{http_server,1},{"idc-iot-pr-server-2:443",http}},
     {{http_user_agent,value},
      [{20,
        "Mozilla/5.0 (Windows; U; Windows NT 5.2; fr-FR; rv:1.7.8) Gecko/20050511 Firefox/1.0.4"},
       {80,
        "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Galeon/1.3.21"}]}]




