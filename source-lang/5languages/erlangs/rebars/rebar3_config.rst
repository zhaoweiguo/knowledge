rebar3配置
=================
实例化配置::

  {erl_opts, [debug_info]}.
  
  {rebar_packages_cdn, "https://hexpm.upyun.com"}.  % package中国镜像
  {deps, []}.

  {relx, [{release, { bbb, "0.1.0" },
           [bbb,
            sasl]},

          {sys_config, "./config/sys.config"},
          {vm_args, "./config/vm.args"},

          {dev_mode, true},
          {include_erts, false},

          {extended_start_script, true}]
  }.

  {profiles, [{prod, [{relx, [{dev_mode, false},
                              {include_erts, true}]}]
              }]
  }.



配置文件::

  {include_erts, false},  // erts
  {system_libs, false},   // 系统库
  // 指定库地址
  {include_erts, "/path/to/erlang"},
  {system_libs, "/path/to/erlang"},
  // 包含相关
  {include_src, false},   // 源码
  {exclude_apps, [app1, app2]},  // 发布时排除
  {exclude_modules, [       // 模块排除
      {app1, [app1_mod1, app1_mod2]},
      {app2, [app2_mod1, app2_mod2]}
  ]}.




实例:


.. literalinclude:: /files/erlangs/rebar_all.config
   :linenos:
   :language: erlang














