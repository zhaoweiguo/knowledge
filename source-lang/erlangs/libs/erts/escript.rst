escript [1]_
##############

使用::

  script-name script-arg1 script-arg2...
  escript escript-flags script-name script-arg1 script-arg2...

  halt(1).                % halt(ExitCode),成功时返回0
  escript:script_name().  % 脚本名

escript:create/2
''''''''''''''''''''''
结构::

  escript:create(FileOrBin, Sections) -> ok | {ok, binary()} | {error, term()}
  类型:
  FileOrBin = filename() | 'binary'
  Sections = [Header] Body | Body
  Header = shebang | {shebang, Shebang}    | comment 
          | {comment, Comment}    | {emu_args, EmuArgs}

  Body = {source, SourceCode} | {beam, BeamCode} | {archive, ZipArchive}    
          | {archive, ZipFiles, ZipOptions}

说明::

  shebang defaults to "/usr/bin/env escript"
  comment defaults to "This is an -*- erlang -*- file".



实例1::

  > Source = "%% Demo\nmain(_Args) ->\n    io:format(erlang:system_info(smp_support)).\n".
  "%% Demo\nmain(_Args) ->\n    io:format(erlang:system_info(smp_support)).\n"

  > {ok, Bin} = escript:create(binary, [shebang, comment, {emu_args, "-smp disable"},
                                        {source, list_to_binary(Source)}]).
  {ok,<<"#!/usr/bin/env escript\n%% This is an -*- erlang -*- file\n%%!-smp disabl"...>>}
  > file:write_file("demo.escript", Bin).
  ok
  > os:cmd("escript demo.escript").
  "false"
  > escript:extract("demo.escript", []).
  {ok,[{shebang,default}, {comment,default}, {emu_args,"-smp disable"},
       {source,<<"%% Demo\nmain(_Args) ->\n    io:format(erlang:system_info(smp_su"...>>}]}

实例2(without header)::

    > file:write_file("demo.erl",
                    ["%% demo.erl\n-module(demo).\n-export([main/1]).\n\n", Source]).
    ok
    > {ok, _, BeamCode} = compile:file("demo.erl", [binary, debug_info]).
    {ok,demo,
        <<70,79,82,49,0,0,2,208,66,69,65,77,65,116,111,109,0,0,0,
          79,0,0,0,9,4,100,...>>}
    > escript:create("demo.beam", [{beam, BeamCode}]).
    ok
    > escript:extract("demo.beam", []).
    {ok,[{shebang,undefined}, {comment,undefined}, {emu_args,undefined},
         {beam,<<70,79,82,49,0,0,3,68,66,69,65,77,65,116,
                 111,109,0,0,0,83,0,0,0,9,...>>}]}
    > os:cmd("escript demo.beam").
    "true"

实例3(archive script)::

  > {ok, SourceCode} = file:read_file("demo.erl").
  {ok,<<"%% demo.erl\n-module(demo).\n-export([main/1]).\n\n%% Demo\nmain(_Arg"...>>}
  > escript:create("demo.escript",
                   [shebang,
                    {archive, [{"demo.erl", SourceCode},
                               {"demo.beam", BeamCode}], []}]).
  ok
  > {ok, [{shebang,default}, {comment,undefined}, {emu_args,undefined},
       {archive, ArchiveBin}]} = escript:extract("demo.escript", []).
  {ok,[{shebang,default}, {comment,undefined}, {emu_args,undefined},
       {{archive,<<80,75,3,4,20,0,0,0,8,0,118,7,98,60,105,
                  152,61,93,107,0,0,0,118,0,...>>}]}
  > file:write_file("demo.zip", ArchiveBin).
  ok
  > zip:foldl(fun(N, I, B, A) -> [{N, I(), B()} | A] end, [], "demo.zip").
  {ok,[{"demo.beam",
        {file_info,748,regular,read_write,
                   {{2010,3,2},{0,59,22}},
                   {{2010,3,2},{0,59,22}},
                   {{2010,3,2},{0,59,22}},
                   54,1,0,0,0,0,0},
        <<70,79,82,49,0,0,2,228,66,69,65,77,65,116,111,109,0,0,0,
          83,0,0,...>>},
       {"demo.erl",
        {file_info,118,regular,read_write,
                   {{2010,3,2},{0,59,22}},
                   {{2010,3,2},{0,59,22}},
                   {{2010,3,2},{0,59,22}},
                   54,1,0,0,0,0,0},
        <<"%% demo.erl\n-module(demo).\n-export([main/1]).\n\n%% Demo\nmain(_Arg"...>>}]}








.. [1] http://erlang.org/doc/man/escript.html