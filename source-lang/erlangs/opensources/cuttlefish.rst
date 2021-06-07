cuttlefish
############
把erlang的配置文件与sysctl-like相互转换 [1]_

用法::

  ./cuttlefish [-h] [-e [<etc_dir>]] [-d <dest_dir>]
                                    [-f [<dest_file>]] [-s <schema_dir>]
                                    [-i <schema_file>] [-c <conf_file>]
                                    [-a <app_config>] [-l [<log_level>]]
                                    [-p] [-m [<max_history>]]

  -h, --help         Print this usage page
  -e, --etc_dir      etc dir [default: /etc]
  -d, --dest_dir     specifies the directory to write the config file to
  -f, --dest_file    the file name to write [default: app]
  -s, --schema_dir   a directory containing .schema files
  -i, --schema_file  individual schema file, will be processed in command
                     line order, after -s
  -c, --conf_file    a cuttlefish conf file, multiple files allowed
  -a, --app_config   the advanced erlangy app.config
  -l, --log_level    log level for cuttlefish output [default: notice]
  -p, --print        prints schema mappings on stderr
  -m, --max_history  the maximum number of generated config files to keep
                     [default: 3]


命令::

  // 
  cuttlefish -l info -e etc/ -c etc/emq.conf -i priv/emq.schema -d data/


实例
''''''''
etc/test.conf::

  erlang.smp = enable
  nodename = gordon@domain.com

  erlang.distribution.port_range.maximum = 8888

  erlang.distribution.net_ticktime = 60


priv/test.schema::

  %%-*- mode: erlang -*-

  {mapping, "erlang.smp", "vm_args.-smp", [
    {default, enable},
    {datatype, {enum, [enable, auto, disable]}},
    hidden
  ]}.

  {mapping, "nodename", "vm_args.-name", [
    {default, "{{node}}"}
  ]}.


  %% @see erlang.distribution.port_range.minimum
  {mapping, "erlang.distribution.port_range.maximum", "kernel.inet_dist_listen_max", [
    {commented, 7999},
    {datatype, integer},
    hidden
  ]}.

  {mapping, "erlang.distribution.net_ticktime", "vm_args.-kernel net_ticktime", [
    {commented, 60},
    {datatype, integer},
    hidden
  ]}.

执行命令::

  ./cuttlefish -e ./etc -c ./etc/test.conf -i priv/test.schema -d data
  // 执行后会在目录data下生成2个文件app.yyyy.mm.dd.hh.MM.ss.config和vm.xxxxx.args

app.xxx.config::

  [{kernel,[{inet_dist_listen_max,8888}]},
  {riak_kv,[{anti_entropy_build_limit,{1,3600000}}]}].

vm.xxx.args::

  -kernel net_ticktime 60
  -name gordon@domain.com
  -smp enable




.. [1] https://github.com/emqtt/cuttlefish