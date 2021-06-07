compiler模块
##################

最常用的flag
''''''''''''''''
::

  -debug_info: 调试专用
  -{outdir,Dir}: 设定beam文件生成目录
  -export_all: 测试专用
  -{d,Macro} or {d,Macro,Value}: 宏定义,Value默认为true

实例::

  7> compile:file(useless, [debug_info, export_all]).
  {ok,useless}
  8> c(useless, [debug_info, export_all]).
  {ok,useless}

  % 等同于
  -compile([debug_info, export_all]).

  % 生成native code
  hipe:c(Module,OptionsList).
  or
  c(Module,[native]). 


