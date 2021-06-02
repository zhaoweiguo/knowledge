.. _rebar_config:

rebar配置文件
####################

::

    {app,[erldis]}.
    {erl_opts, [debug_info]}.

    {eunit_compile_opts, [{src_dirs, ["test"]}]}.
    {cover_enabled, true}.    // 为true时会生成.eunit/,存放单元测试过程
    {clean_files, ["ebin/*.beam", "priv/log/*", "rel/*"]}.
    {target, "rel"}.
    {deps_dir, ["deps"]}.

    {deps, [
        //类型 {git, Url}
        {em, ".*", {git, "https://github.com/sheyll/erlymock.git"}},
        //类型 {git, Url, {branch, Branch}}
        {nano_trace, ".*", {git, "https://github.com/sheyll/nano_trace.git", {branch, "feature/rebar-migration"}}},
        //类型 {git, Url, {tag, Tag}}
        {mochiweb, "2.3.2", {git, "https://github.com/mochi/mochiweb.git", {tag, "v2.3.2"}}},
        % Or specify a revision to refer a particular commit, useful if the project has only the master branch
        % {mochiweb, "2.3.2", {git, "https://github.com/mochi/mochiweb.git", "15bc558d8222b011e2588efbd86c01d68ad73e60"},

        % An example of a "raw" dependency: 可以不是标准的otp应用
        {rebar, ".*", {git, "git://github.com/rebar/rebar.git", {branch, "master"}}, [raw]}
    ]}.









