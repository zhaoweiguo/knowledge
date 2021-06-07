httpd模块
###############

Mandatory Properties::

  % 端口
  {port, integer()}
  % 服务名
  {server_name, string()}
  % 定义服务的home目录
  {server_root, path()}
  % 定义文档的top目录
  {document_root, path()}


Communication Properties::

  {bind_address, ip_address() | hostname() | any}
  {profile, atom()}
  {socket_type, ip_comm | {ip_comm, Config::proplist()} | {essl, Config::proplist()}}
  {ipfamily, inet | inet6}
  {minimum_bytes_per_second, integer()}


Erlang Web Server API Modules::

  % http服务处理请求的模块
  % 默认:[mod_alias, mod_auth, mod_esi, mod_actions, mod_cgi, 
          mod_dir, mod_get, mod_head, mod_log, mod_disk_log].
  % 顺序有依赖关系
  {modules, [atom()]}


Limit properties::

  {customize, atom()}
  {disable_chunked_transfer_encoding_send, boolean()}
  {keep_alive, boolean()}
  {keep_alive_timeout, integer()}
  {max_body_size, integer()}
  {max_clients, integer()}
  {max_header_size, integer()}
  {max_content_length, integer()}
  {max_uri_size, integer()}
  {max_keep_alive_request, integer()}
  {max_client_body_chunk, integer()}

Administrative Properties::

  % 默认:[{"html","text/html"},{"htm","text/html"}].
  {mime_types, [{MimeType, Extension}] | path()}

  {mime_type, string()}
  {server_admin, string()}
  {server_tokens, none|prod|major|minor|minimal|os|full|{private, string()}}
  {log_format, common | combined}
  {error_log_format, pretty | compact}


URL Aliasing Properties - Requires mod_alias::

  {alias, {Alias, RealName}}
  {re_write, {Re, Replacement}}

  % 
  % 如:{directory_index, ["index.html", "welcome.html"]}
  % 当请求: http://your.server.org/docs/时
  % 实际请求:http://your.server.org/docs/index.html
  % 如没有index.html则请求:http://your.server.org/docs/welcome.html
  {directory_index, [string()]}


CGI Properties - Requires mod_cgi::

  {script_alias, {Alias, RealName}}
  {script_re_write, {Re, Replacement}}
  {script_nocache, boolean()}
  {script_timeout, integer()}
  {action, {MimeType, CgiScript}} - requires mod_action
  {script, {Method, CgiScript}} - requires mod_action


ESI Properties - Requires mod_esi::

  % 将请求映射到指定的模块和函数
  % 如:{erl_script_alias, {"/cgi-bin/example", [httpd_example]}}
  % 请求:http://your.server.org/cgi-bin/example/httpd_example:yahoo 
  % 映射到httpd_example:yahoo/3或httpd_example:yahoo/2
  {erl_script_alias, {URLPath, [AllowedModule]}}

  {erl_script_nocache, boolean()}
  {erl_script_timeout, integer()}
  {eval_script_alias, {URLPath, [AllowedModule]}}

Log Properties - Requires mod_log::

  % 指定错误日志
  % 如不是/开头,则是与server_root的相对目录
  {error_log, path()}

  % security events日志
  {security_log, path()}

  % 指定access日志
  {transfer_log, path()}

Disk Log Properties - Requires mod_disk_log::

  {disk_log_format, internal | external}
  {error_disk_log, path()}
  {error_disk_log_size, {MaxBytes, MaxFiles}}
  {security_disk_log, path()}
  {security_disk_log_size, {MaxBytes, MaxFiles}}
  {transfer_disk_log, path()}
  {transfer_disk_log_size, {MaxBytes, MaxFiles}}


Authentication Properties - Requires mod_auth::

  {directory, {path(), [{property(), term()}]}}
  {allow_from, all | [RegxpHostString]}
  {deny_from, all | [RegxpHostString]}
  {auth_type, plain | dets | mnesia}
  {auth_user_file, path()}
  {auth_group_file, path()}
  {auth_name, string()}
  {auth_access_password, string()}
  {require_user, [string()]}
  {require_group, [string()]}

Htaccess Authentication Properties - Requires mod_htaccess::

  {access_files, [path()]}

Security Properties - Requires mod_security::

  {security_directory, {path(), [{property(), term()}]}}
  {data_file, path()}
  {max_retries, integer()}
  {block_time, integer()}
  {fail_expire_time, integer()}
  {auth_timeout, integer()}








