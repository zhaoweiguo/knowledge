sync-类似reloader [1]_
########################
依赖::

    syntax_tools
    compiler

启动::

    > sync:go().

Successfully recompiling a module::

    08:34:43.255 [info] /Code/Webmachine/src/webmachine_dispatcher.erl:0: Recompiled.
    08:34:43.265 [info] webmachine_dispatcher: Reloaded! (Beam changed.)

Warnings::

    08:35:06.660 [info] /Code/Webmachine/src/webmachine_dispatcher.erl:33: Warning: function dispatch/3 is unused

Errors::

    08:35:16.881 [info] /Code/Webmachine/src/webmachine_dispatcher.erl:196: Error: function reconstitute/1 undefined
    /Code/Webmachine/src/webmachine_dispatcher.erl:250: Error: syntax error before: reconstitute

Stopping and Pausing::

    sync:stop().
    sync:pause().

指定要sync的目录::

    [
        {sync, [
            {src_dirs, {strategy(), [src_dir_descr()]}}
        ]}
    ].

    -type strategy() :: add | replace.
      add:增加指定目录
      replace:只sync指定目录
    -type src_dir_descr() :: { Dir :: file:filename(), [Options :: compile_option()]}.
    实例:
    [
        {sync, [
            {src_dirs, {replace, [{"./priv/plugins", [{outdir,"./priv/plugins_bin"}]}]}}
        ]}
    ].

指定日志等级::

    all: Print all console notifications
    none: Print no console notifications
    [success | warnings | errors]: A list of any combination of the atoms success, warnings, or errors. Example: [warnings, errors] will only show warnings and errors, but suppress success messages.
    true: An alias to all, kept for backwards compatibility
    false: An alias to none, kept for backwards compatibility
    skip_success: An alias to [errors, warnings], kept for backwards compatibility.

    1.Loaded from a .config file
    {log, all}, 
    {log, [success, warnings]},
    2. As an environment variable called from the erlang command line:
    erl -sync log all
    erl -sync log none
    3. From within the Erlang shell:
    sync:log(all);
    sync:log(none);
    sync:log([errors, warnings]);

配置实例::

    [
      {sync, [
        {growl, all},
        {log, all},
        {non_descendants, fix},
        {executable, auto},
        {whitelisted_modules, []},
        {excluded_modules, []}
      ]}
    ].






.. [1] https://github.com/rustyio/sync
