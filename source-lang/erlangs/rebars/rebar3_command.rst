rebar3 command
######################

escriptize
''''''''''''''
相关::

  libs/erts/escript

选项::

  escript_main_app:生成escript的应用名,默认为顶层应用名
  escript_name:escript的名称,执行Module:main(_).默认为escript_main_app
  escript_incl_apps:依赖项目列表,默认为[]
  escript_emu_args:字符串
      以%%!开头
      如:"%%! +sbtu +A0\n"
      如:"%%! -escript main cuttlefish_escript +A 0\n"
      默认值:"%%! -escript main MainApp\n"
  escript_shebang:
      作用:Location of escript file to run
      默认:"#!/usr/bin/env escript\n"
  escript_comment:
      默认:%%\n




