inets模块
############
start/0/1/2/3
'''''''''''''''''
结构::

  start() ->
  start(Type) -> ok | {error, Reason}
  类型
  Type = permanent | transient | temporary

  start(Service, ServiceConfig) -> {ok, Pid} | {error, Reason}
  start(Service, ServiceConfig, How) -> {ok, Pid} | {error, Reason}
  类型
  Service = service()
  ServiceConfig = [{Option, Value}]
  Option = property()
  Value = term()
  How = inets | stand_alone - default is inets.

说明::

  1.How==inets
  实际执行:
  Service:start_service(ServiceConfig).
  2.How==stand_alone
  实际执行:
  Service:start_standalone(ServiceConfig).


实例::

  % tsung中实例
  ServiceConfig =  [{port, 8091},
                    {modules,[mod_esi,
                              mod_dir,
                              mod_alias,
                              mod_get,
                              mod_head,
                              mod_log,
                              mod_disk_log]},
                    {erl_script_alias, {"/es", [ts_web, ts_api]}},
                    {error_log, "inets_error.log"},
                    %% {transfer_log, "inets_access.log"},
                    {directory_index, ["index.html"]},
                    {mime_types,[ {"html","text/html"},
                                  {"css","text/css"},
                                  {"png","image/png"},
                                  {"xml","text/xml"},
                                  {"json","application/json"},
                                  {"js","application/x-javascript"}]},
                    {server_name,"tsung_controller"}, 
                    {server_root,LogDir},
                    {document_root,LogDir}]
  inets:start(httpd, ServiceConfig)
  即执行:
  httpd:start_service(ServiceConfig).





