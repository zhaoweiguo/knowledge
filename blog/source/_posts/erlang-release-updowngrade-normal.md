---
title: 使用Erlang原生方法对release版本升降级
date: 2018-09-04 18:01:11
tags:
- erlang
categories:
- erlang
---

### 创建Target System

创建一个符合OTP架构的项目ch3:

    ├── LICENSE
    ├── README.md
    ├── rebar.config
    ├── rebar.lock
    └── src
        ├── ch3.app.src
        ├── ch3.erl
        ├── ch3_app.erl
        ├── ch3_sup.erl
        └── target_system.er


ch_rel-1.rel文件:

    {release,
       {"ch_rel", "A"},
       {erts, "8.3.5.4"},
       [
          {kernel, "5.2.0.1"},
          {stdlib, "3.3"},
          {sasl, "3.0.3"},
          {ch3, "0.1.0"}
       ]
    }.

<!--more-->

生成Target System:

    os> erl -pa /home/user/target_system/myapps/ch3-0.1.0/ebin

    % 1.这儿的ch_rel-1就是ch_rel-1.rel文件名
    % 2.target_system.erl文件在sasl项目的example中
    % 3.此命令会生成以下几个文件:
    %     plain.rel,plain.script, plain.boot
    %     ch_rel-1.script, ch_rel-1.boot
    %     ch_rel-1.tar.gz
    1> target_system:create("ch_rel-1").

安装Target System:

    % 1.会把ch_rel-1.tar.gz文件解压到目录/usr/local/erl-target中
    % 2.文件releases/start_erl.data中有erts版本
    % 3.文件releases/RELEASES中存放所有的release版本信息
    2> target_system:install("ch3", "/usr/local/erl-target").
  
### 启动Target System

    % 使用interactive方式启动
    os> /usr/local/erl-target/bin/erl -boot /usr/local/erl-target/releases/A/start

    run_erl: 提供日志输出从runtime system到文件系统的封装
    start_erl: 
      需要:
      1.The root directory ("/usr/local/erl-target")
      2.The releases directory ("/usr/local/erl-target/releases"
      3.The location of the file start_erl.data
      4.有文件releases/A/sys.config
      功能:
      1.读文件start_erl.data,取得runtime system version「8.3.5.4」和release version「A」
      2.启动找到的这个runtime system
      3.提供给标识-boot的文件releases/A/start.boot
      4.没有releases/A/sys.config文件，会启动失败
    to_erl: attach到Erlang shell的命令

### 创建Next Version

ch_rel-2.rel文件:

    {release,
     {"ch_rel", "B"},
     {erts, "8.3.5.4"},
     [{kernel, "5.2.0.1"},
      {stdlib, "3.3"},
      {sasl, "3.0.3"},
      {ch3, "0.2.0"}]
    }.

ch3.appup:

    {"0.2.0",
       [{"0.1.0", [{load_module, ch3}]}],
       [{"0.1.0", [{load_module, ch3}]}]
    }.

打包version 2:

    // 在version 2上启动erlang
    os> erl -pa /home/user/target_system/myapps/ch3-2.0/ebin

    % 生成version 2的.boot文件和.script文件
    1> systools:make_relup("ch_rel-2",["ch_rel-1"],["ch_rel-1"],
    [{path,["/home/user/target_system/myapps/ch3-1.0/ebin",
    "/my/old/erlang/lib/*/ebin"]}]).

    // 创建新的release
    2> target_system:create("ch_rel-2").
    % 生成文件:ch_rel-2.tar.gz

### 更新Target System

修改bin/start增加-heart:

    #!/bin/sh
    ROOTDIR=/usr/local/erl-target/

    if [ -z "$RELDIR" ]
    then
       RELDIR=$ROOTDIR/releases
    fi

    START_ERL_DATA=${1:-$RELDIR/start_erl.data}

    $ROOTDIR/bin/run_erl -daemon /tmp/ $ROOTDIR/log "exec $ROOTDIR/bin/start_erl $ROOTDIR\
    $RELDIR $START_ERL_DATA -heart


假设原version 1通过以下命令启动:

    // 启动
    os> /usr/local/erl-target/bin/start
    // attach
    os> /usr/local/erl-target/bin/to_erl /tmp/erlang.pipe.1

copy上面生成的ch_rel-2.tar.gz文件到version 1的releases目录中:

    os> cp ch_rel-2.tar.gz /usr/local/erl-target/releases

解压、安装:
    
    % 解压
    1> {ok,Vsn} = release_handler:unpack_release("ch_rel-2").

    % 安装
    % 因为有-heart选项,结点已经重启
    2> release_handler:install_release(Vsn).
      {continue_after_restart,"A",[]}
      heart: Tue Apr  1 12:15:10 2014: Erlang has closed.
      heart: Tue Apr  1 12:15:11 2014: Executed "/usr/local/erl-target/bin/start /usr/local/erl-target/releases/new_start_erl.data" -> 0. Terminating.
      [End]

重新attach到node:

    os> /usr/local/erl-target/bin/to_erl /tmp/erlang.pipe.2

查看release:

    1> release_handler:which_releases().
    [{"ch_rel","B",
      ["kernel-5.2.0.1","stdlib-3.3","sasl-3.0.3","ch3-0.2.0"],
      current},
     {"ch_rel","A",
      ["kernel-5.2.0.1","stdlib-3.3","sasl-3.0.3","ch3-0.1.0"],
      permanent}]

Make the new release permanent:

    2> release_handler:make_permanent("SECOND").

    3> release_handler:which_releases().
    [{"ch_rel","B",
      ["kernel-5.2.0.1","stdlib-3.3","sasl-3.0.3","ch3-0.2.0"],
      permanent},
     {"ch_rel","A",
      ["kernel-5.2.0.1","stdlib-3.3","sasl-3.0.3","ch3-0.1.0"],
      old}]


### target_system.erl

    -module(target_system).
    -export([create/1, create/2, install/2]).

    %% Note: RelFileName below is the *stem* without trailing .rel,
    %% .script etc.
    %%

    %% create(RelFileName)
    %%
    create(RelFileName) ->
        create(RelFileName,[]).

    create(RelFileName,SystoolsOpts) ->
        RelFile = RelFileName ++ ".rel", 
        Dir = filename:dirname(RelFileName),
        PlainRelFileName = filename:join(Dir,"plain"),
        PlainRelFile = PlainRelFileName ++ ".rel",
        io:fwrite("Reading file: ~tp ...~n", [RelFile]),
        {ok, [RelSpec]} = file:consult(RelFile),
        io:fwrite("Creating file: ~tp from ~tp ...~n",
                  [PlainRelFile, RelFile]),
        {release,
         {RelName, RelVsn},
         {erts, ErtsVsn},
         AppVsns} = RelSpec,
        PlainRelSpec = {release, 
                        {RelName, RelVsn},
                        {erts, ErtsVsn},
                        lists:filter(fun({kernel, _}) -> 
                                             true;
                                        ({stdlib, _}) ->
                                             true;
                                        (_) ->
                                             false
                                     end, AppVsns)
                       },
        {ok, Fd} = file:open(PlainRelFile, [write]),
        io:fwrite(Fd, "~p.~n", [PlainRelSpec]),
        file:close(Fd),

        io:fwrite("Making \"~ts.script\" and \"~ts.boot\" files ...~n",
            [PlainRelFileName,PlainRelFileName]),
        make_script(PlainRelFileName,SystoolsOpts),

        io:fwrite("Making \"~ts.script\" and \"~ts.boot\" files ...~n",
                  [RelFileName, RelFileName]),
        make_script(RelFileName,SystoolsOpts),

        TarFileName = RelFileName ++ ".tar.gz",
        io:fwrite("Creating tar file ~tp ...~n", [TarFileName]),
        make_tar(RelFileName,SystoolsOpts),

        TmpDir = filename:join(Dir,"tmp"),
        io:fwrite("Creating directory ~tp ...~n",[TmpDir]),
        file:make_dir(TmpDir), 

        io:fwrite("Extracting ~tp into directory ~tp ...~n", [TarFileName,TmpDir]),
        extract_tar(TarFileName, TmpDir),

        TmpBinDir = filename:join([TmpDir, "bin"]),
        ErtsBinDir = filename:join([TmpDir, "erts-" ++ ErtsVsn, "bin"]),
        io:fwrite("Deleting \"erl\" and \"start\" in directory ~tp ...~n",
                  [ErtsBinDir]),
        file:delete(filename:join([ErtsBinDir, "erl"])),
        file:delete(filename:join([ErtsBinDir, "start"])),

        io:fwrite("Creating temporary directory ~tp ...~n", [TmpBinDir]),
        file:make_dir(TmpBinDir),

        io:fwrite("Copying file \"~ts.boot\" to ~tp ...~n",
                  [PlainRelFileName, filename:join([TmpBinDir, "start.boot"])]),
        copy_file(PlainRelFileName++".boot",filename:join([TmpBinDir, "start.boot"])),

        io:fwrite("Copying files \"epmd\", \"run_erl\" and \"to_erl\" from \n"
                  "~tp to ~tp ...~n",
                  [ErtsBinDir, TmpBinDir]),
        copy_file(filename:join([ErtsBinDir, "epmd"]), 
                  filename:join([TmpBinDir, "epmd"]), [preserve]),
        copy_file(filename:join([ErtsBinDir, "run_erl"]), 
                  filename:join([TmpBinDir, "run_erl"]), [preserve]),
        copy_file(filename:join([ErtsBinDir, "to_erl"]), 
                  filename:join([TmpBinDir, "to_erl"]), [preserve]),

        %% This is needed if 'start' script created from 'start.src' shall
        %% be used as it points out this directory as log dir for 'run_erl'
        TmpLogDir = filename:join([TmpDir, "log"]),
        io:fwrite("Creating temporary directory ~tp ...~n", [TmpLogDir]),
        ok = file:make_dir(TmpLogDir),

        StartErlDataFile = filename:join([TmpDir, "releases", "start_erl.data"]),
        io:fwrite("Creating ~tp ...~n", [StartErlDataFile]),
        StartErlData = io_lib:fwrite("~s ~s~n", [ErtsVsn, RelVsn]),
        write_file(StartErlDataFile, StartErlData),
        
        io:fwrite("Recreating tar file ~tp from contents in directory ~tp ...~n",
            [TarFileName,TmpDir]),
        {ok, Tar} = erl_tar:open(TarFileName, [write, compressed]),
        %% {ok, Cwd} = file:get_cwd(),
        %% file:set_cwd("tmp"),
        ErtsDir = "erts-"++ErtsVsn,
        erl_tar:add(Tar, filename:join(TmpDir,"bin"), "bin", []),
        erl_tar:add(Tar, filename:join(TmpDir,ErtsDir), ErtsDir, []),
        erl_tar:add(Tar, filename:join(TmpDir,"releases"), "releases", []),
        erl_tar:add(Tar, filename:join(TmpDir,"lib"), "lib", []),
        erl_tar:add(Tar, filename:join(TmpDir,"log"), "log", []),
        erl_tar:close(Tar),
        %% file:set_cwd(Cwd),
        io:fwrite("Removing directory ~tp ...~n",[TmpDir]),
        remove_dir_tree(TmpDir),
        ok.


    install(RelFileName, RootDir) ->
        TarFile = RelFileName ++ ".tar.gz", 
        io:fwrite("Extracting ~tp ...~n", [TarFile]),
        extract_tar(TarFile, RootDir),
        StartErlDataFile = filename:join([RootDir, "releases", "start_erl.data"]),
        {ok, StartErlData} = read_txt_file(StartErlDataFile),
        [ErlVsn, _RelVsn| _] = string:tokens(StartErlData, " \n"),
        ErtsBinDir = filename:join([RootDir, "erts-" ++ ErlVsn, "bin"]),
        BinDir = filename:join([RootDir, "bin"]),
        io:fwrite("Substituting in erl.src, start.src and start_erl.src to "
                  "form erl, start and start_erl ...\n"),
        subst_src_scripts(["erl", "start", "start_erl"], ErtsBinDir, BinDir, 
                          [{"FINAL_ROOTDIR", RootDir}, {"EMU", "beam"}],
                          [preserve]),
        %%! Workaround for pre OTP 17.0: start.src and start_erl.src did
        %%! not have correct permissions, so the above 'preserve' option did not help
        ok = file:change_mode(filename:join(BinDir,"start"),8#0755),
        ok = file:change_mode(filename:join(BinDir,"start_erl"),8#0755),

        io:fwrite("Creating the RELEASES file ...\n"),
        create_RELEASES(RootDir, filename:join([RootDir, "releases",
                  filename:basename(RelFileName)])).

    %% LOCALS 

    %% make_script(RelFileName,Opts)
    %%
    make_script(RelFileName,Opts) ->
        systools:make_script(RelFileName, [no_module_tests,
                   {outdir,filename:dirname(RelFileName)}
                   |Opts]).

    %% make_tar(RelFileName,Opts)
    %%
    make_tar(RelFileName,Opts) ->
        RootDir = code:root_dir(),
        systools:make_tar(RelFileName, [{erts, RootDir},
                {outdir,filename:dirname(RelFileName)}
                |Opts]).

    %% extract_tar(TarFile, DestDir)
    %%
    extract_tar(TarFile, DestDir) ->
        erl_tar:extract(TarFile, [{cwd, DestDir}, compressed]).

    create_RELEASES(DestDir, RelFileName) ->
        release_handler:create_RELEASES(DestDir, RelFileName ++ ".rel").

    subst_src_scripts(Scripts, SrcDir, DestDir, Vars, Opts) -> 
        lists:foreach(fun(Script) ->
                              subst_src_script(Script, SrcDir, DestDir, 
                                               Vars, Opts)
                      end, Scripts).

    subst_src_script(Script, SrcDir, DestDir, Vars, Opts) -> 
        subst_file(filename:join([SrcDir, Script ++ ".src"]),
                   filename:join([DestDir, Script]),
                   Vars, Opts).

    subst_file(Src, Dest, Vars, Opts) ->
        {ok, Conts} = read_txt_file(Src),
        NConts = subst(Conts, Vars),
        write_file(Dest, NConts),
        case lists:member(preserve, Opts) of
            true ->
                {ok, FileInfo} = file:read_file_info(Src),
                file:write_file_info(Dest, FileInfo);
            false ->
                ok
        end.

    %% subst(Str, Vars)
    %% Vars = [{Var, Val}]
    %% Var = Val = string()
    %% Substitute all occurrences of %Var% for Val in Str, using the list
    %% of variables in Vars.
    %%
    subst(Str, Vars) ->
        subst(Str, Vars, []).

    subst([$%, C| Rest], Vars, Result) when $A =< C, C =< $Z ->
        subst_var([C| Rest], Vars, Result, []);
    subst([$%, C| Rest], Vars, Result) when $a =< C, C =< $z ->
        subst_var([C| Rest], Vars, Result, []);
    subst([$%, C| Rest], Vars, Result) when  C == $_ ->
        subst_var([C| Rest], Vars, Result, []);
    subst([C| Rest], Vars, Result) ->
        subst(Rest, Vars, [C| Result]);
    subst([], _Vars, Result) ->
        lists:reverse(Result).

    subst_var([$%| Rest], Vars, Result, VarAcc) ->
        Key = lists:reverse(VarAcc),
        case lists:keysearch(Key, 1, Vars) of
            {value, {Key, Value}} ->
                subst(Rest, Vars, lists:reverse(Value, Result));
            false ->
                subst(Rest, Vars, [$%| VarAcc ++ [$%| Result]])
        end;
    subst_var([C| Rest], Vars, Result, VarAcc) ->
        subst_var(Rest, Vars, Result, [C| VarAcc]);
    subst_var([], Vars, Result, VarAcc) ->
        subst([], Vars, [VarAcc ++ [$%| Result]]).

    copy_file(Src, Dest) ->
        copy_file(Src, Dest, []).

    copy_file(Src, Dest, Opts) ->
        {ok,_} = file:copy(Src, Dest),
        case lists:member(preserve, Opts) of
            true ->
                {ok, FileInfo} = file:read_file_info(Src),
                file:write_file_info(Dest, FileInfo);
            false ->
                ok
        end.
           
    write_file(FName, Conts) ->
        Enc = file:native_name_encoding(),
        {ok, Fd} = file:open(FName, [write]),
        file:write(Fd, unicode:characters_to_binary(Conts,Enc,Enc)),
        file:close(Fd).

    read_txt_file(File) ->
        {ok, Bin} = file:read_file(File),
        {ok, binary_to_list(Bin)}.

    remove_dir_tree(Dir) ->
        remove_all_files(".", [Dir]).

    remove_all_files(Dir, Files) ->
        lists:foreach(fun(File) ->
                              FilePath = filename:join([Dir, File]),
                              case filelib:is_dir(FilePath) of
                                  true ->
                                      {ok, DirFiles} = file:list_dir(FilePath), 
                                      remove_all_files(FilePath, DirFiles),
                                      file:del_dir(FilePath);
                                  _ ->
                                      file:delete(FilePath)
                              end
                      end, Files).







