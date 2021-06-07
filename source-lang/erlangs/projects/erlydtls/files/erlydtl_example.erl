-module(erlydtl_example).

-export([export/0]).

%% 
export() ->
    export("pri_sound_get.php", "Pri_sound_get", "pri_sound_get", "api_sound", "pri_sound_get.tpl", pri_sound_get).

%%
%%例:
%% File: "erlydtl_example.php"
%% Classname:  "Erlydtl_example"
%% InterfaceName:  "Erlydtl_interface"
%% TemplateName: "template.tpl"
export(File, ClassName, InterfaceName, TemplateName, Mod)->
    FileName="./"++File,%要写入的文件名
    %% variable 
    Variable="$sn; $sign;", %要定义的变量名
    Options=[
             {classname, ClassName}, 
             {interface_name, InterfaceName}, 
             {variable, Variable}
            ],
    erlydtl:compile("./template/"++TemplateName, Mod),%模板编译
    {ok, Data}=Mod:render(Options), %使用编译后的模板
    file:write_file(FileName, Data). %把生成的内容写入文件

