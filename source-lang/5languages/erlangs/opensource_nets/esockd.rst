esockd [1]_
###############


使用::

  %% Start esockd application
  ok = esockd:start().
  Options = [{acceptors, 10}, {max_connections, 1024}, {tcp_options, [binary, {reuseaddr, true}]}].
  MFArgs = {echo_server, start_link, []},
  esockd:open(echo, 5000, Options, MFArgs).











.. [1] https://github.com/emqx/esockd


