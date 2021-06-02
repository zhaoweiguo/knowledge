luerl [1]_
############################
lua插件扩展
实例::

  % execute a string
  {Return, State} = luerl:do("print(\"Hello, Robert(o)!\")"),
  % execute a file
  {Return, State} = luerl:dofile("./hello.lua"),
  % 其中: 
  %   Return: lua运行的返回值
  %   State: lua内容翻译的中间代码

  % separately parse, then execute
  State0 = luerl:init(),
  {ok, Chunk, State1} = luerl:load("print(\"Hello, Chunk!\")", State0),
  {_Ret, _NewState} = luerl:do(Chunk, State1),

  %execute a string, get a result:
  {ok,A} = luerl:eval("return 1 + 1"),
  {ok,A} = luerl:eval(<<"return 1 + 1">>),
  % A:2
  {A, State} = luerl:do("return 1 + 1"),
  {A, State} = luerl:do(<<"return 1 + 1">>),
  % A:2

文件::

  > cat hello2-2.lua
  return 2137 * 42

  % execute a file, get a result
  {ok,B} = luerl:evalfile("./hello2-2.lua"),
  {B, State} = luerl:dofile("./hello2-2.lua"),
  % B:89754

标准函数::

  luerl:call_function([print], [<<"(8) Hello, standard print function!">>]),
  luerl:call_function([print], [<<"(9) Hello, print function!">>], luerl:init())
  {Result1,_} = luerl:call_function([table,pack], [<<"a">>,<<"b">>,42]),
  {Result1,_} = luerl:call_function([table,pack], [<<"a">>,<<"b">>,42], luerl:init()),
  % Result1: [[{1,<<"a">>},{2,<<"b">>},{3,42.0},{<<"n">>,3.0}]]

自定义函数::

  % separately parse, then execute (doubles (12) and Chunk2 as assertion)
  St2A = luerl:init(),
  {ok,Chunk2,St2B} = luerl:load("function chunk2() print(\"(12) Hello\") end", St2A),
  {ok,Chunk2,_} = luerl:load(<<"function chunk2() print(\"(12) Hello\") end">>, St2A),
  % Result2是lua脚本返回值，不返回则值为[]
  {ok,Result2} = luerl:eval(Chunk2, St2B),
  {Result2,St2C} = luerl:do(Chunk2, St2B),

  % do函数内部会先执行load函数
  {Result2,St2D} = luerl:do(<<"function chunk2() print(\"(12) Hello\") end">>, St2A),
  % 函数调用
  luerl:call_function([chunk2], [], St2C),  % (12) Hello
  luerl:call_function([chunk2], [], St2D),  % (12) Hello

文件中的函数::

  % cat hello2-3.lua
  function no() print("(16) No!") end
  print("(15) Maybe ...")
  return "(X) Yes!"

  % separately parse, then execute a file. The file defines a function no()
  St3A = luerl:init(),

  % Chunk3是中间代码
  % St3B是luerl中间代码
  {ok,Chunk3,St3B} = luerl:loadfile("./hello2-3.lua", St3A),
  % 执行脚本
  {ok,Result3} = luerl:eval(Chunk3, St3B),                    % (15) Maybe ...
  {Result3,St3C} = luerl:do(Chunk3, St3B),                    % (15) Maybe ...
  {[],_} = luerl:call_function([no], [], St3C),               % (16) No!


复杂的::

  % create state
  New = luerl:init(),
  {_,_New2} = luerl:do("print '(19) hello generix'", New),  % (19) hello generix
  
  % change state
  {_,State0} = luerl:do("a = 1000", New),
  {_,State01} = luerl:do("a = 1000", New),

  % execute a string, using passed in State0
  luerl:eval("print('(20) ' .. a)", State0),        % (20) 1000
  luerl:eval(<<"print('(21) ' .. a+1)">>, State0),  % (21) 1001
  luerl:do("print('(22) ' .. a+2)", State0),        % (22) 1002
  luerl:do(<<"print('(23) ' .. a+3)">>, State0),    % (23) 1003

赋值::

  % cat hello2-9.lua
  function confirm(p)
    return p .. ' (it really is)'
  end
  return confirm(a)


  % separately parse, then execute a file, get a result. The file defines confirm(p)
  {ok,Chunk14,St8} = luerl:loadfile("./hello2-9.lua", State07),
  {ok,Result14} = luerl:eval(Chunk14, St8),
  {Result14,State14} = luerl:do(Chunk14, St8),
  io:format("(35) And twice: ~s~n", [Result14]),
  {Result14A,_} = luerl:call_function([confirm], [<<"Is it?">>], State14),
  io:format("(36) Well: ~s~n", [Result14A]),


实例
''''''
input1.json::

  {
    "name" : "赵卫国",
    "sex" : "male",
    "age" : 18,
    "company" : "qingdao1024"
  }

plugin.lua::

  function doit(content)
      local json = require("luas.json");
      new = json.decode(content);
      new.name = "simon";
      new.age = 10;
      b = json.encode(new);
      print(b);
  end

server.erl::

  translate()->
    % 1read input1.json
    FileJsonPath = "luas/input1.json",
    {ok, FileJson} = file:open(FileJsonPath, [read]),
    {ok, Json} = file:read(FileJson, filelib:file_size(FileJsonPath)),
    io:format("1param: ~p~n", [Json]),
    BinJson = list_to_binary(Json),
    translate(BinJson),
    ok.

  translate(Json) when is_list(Json)->
    translate(list_to_binary(Json));
  translate(BinJson) when is_binary(BinJson)->

    State0 = luerl:init(),
    % 2.1read do1.lua
    FilePath = "./luas/do1.lua",
    {ok, File} = file:open(FilePath, read),
    {ok, Content} = file:read(File, filelib:file_size(FilePath)),

    % 2.2load do1.lua
    {_Result,State2} = luerl:do(Content, State0),

    %4 call function
    {Result, _} = luerl:call_function([doit], [BinJson], State2),
    io:format("Result: ~p~n", [Result]),
    ok.

开源项目luerl::

  https://github.com/rvirding/luerl
  // add to rebar.conf
  {luerl, {git, "https://github.com/rvirding/luerl.git", {tag, "v0.3"}}}

执行::
  
  server:translate().





.. [1] https://github.com/rvirding/luerl


