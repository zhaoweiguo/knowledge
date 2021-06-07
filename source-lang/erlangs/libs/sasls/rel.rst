rel
#####
Release resource file

说明::

  The release resource file 指定了哪些应用会被包含在一个基于Erlang/OTP的release系统中
  此文件被systools函数用于生成(.script, .boot)脚本和release升级文件(.relup)

语法::

  {release, {RelName,Vsn}, {erts, EVsn},
    [{Application, AppVsn} |
     {Application, AppVsn, Type} |
     {Application, AppVsn, IncApps} |
     {Application, AppVsn, Type, IncApps}]}.
  Type = permanent | transient | temporary | load | none
    Defaults to permanent
    If Type = load, the application is only loaded.
    If Type = none, the application is not loaded and not started, although the code for its modules is loaded.
  IncApps = [atom()]









