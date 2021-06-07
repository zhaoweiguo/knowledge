system_principles [1]_
#########################

Boot Scripts::

  % erl -boot start_all
  默认:
    start_clean.boot 
    start_sasl.boot 
    no_dot_erlang.boot 
  说明:具体是哪个默认值,根据erlang安装时确定
  .boot文件可能通过systools:make_script/1,2生成

  % 调试
  % erl -init_debug


Code Loading Strategy::

  % erl -mode embedded
  % Default: interactive

  初使时,code path包括当前工作目录和$ROOT/lib

  % erl -pa /home/arne/mycode
  % erl -pz /home/arne/mycode

文件类型::

  File Type             File Name/Extension 
  Module                    .erl  
  Include file              .hrl  
  Release resource file     .rel  
  Application resource file .app  
  Boot script               .script
  Binary boot script        .boot 
  Configuration file        .config
  Application upgrade file  .appup 
  Release upgrade file      relup 

Creating and Upgrading a Target System
'''''''''''''''''''''''''''''''''''''''''''''''
说明::

    详见blog










.. [1] http://erlang.org/doc/system_principles/users_guide.html


