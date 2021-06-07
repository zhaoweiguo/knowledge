.. _observer_cli:

observer_cli [1]_
''''''''''''''''''''''

使用方法::

  // 本结点
  $> rebar3 shell
  erl> observer_cli:start().

  // 远程结点
  $> rebar3 shell --name 'observer_cli@127.0.0.1'
  erl> observer_cli:start('demo_erlang@127.0.0.1', 'XEXIWPUHUJTYKXFMMTXEweb').

  // 注意: ❗️ ensure observer_cli application been loaded on target node.

  // Escriptize
  $> cd path/to/observer_cli/
  $> rebar3 escriptize
  $> _build/default/bin/observer_cli TARGETNODE [TARGETCOOKIE]



  erlang:system_flag(scheduler_wall_time, true)


.. [1] https://github.com/zhongwencool/observer_cli