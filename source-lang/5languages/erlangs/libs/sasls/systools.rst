systools模块
#####################
A Set of Release Handling Tools
This module contains functions to generate boot scripts (.boot, .script), a release upgrade file (relup), and release packages.

描述::

  boot scripts:           .boot, .script
  release upgrade file:   .relup



make_relup/3/4
''''''''''''''''''''''
结构::

  make_relup(Name, UpFrom, DownTo) -> Result
  make_relup(Name, UpFrom, DownTo, [Opt]) -> Result
  类型:
  Name = string()
  UpFrom = DownTo = [Name2 | {Name2,Descr}]
   Descr = term()
  Opt = {path,[Dir]} | restart_emulator | silent | noexec | {outdir,Dir} | warnings_as_errors
   Dir = string()
  Result = ok | error | {ok,Relup,Module,Warnings} | {error,Module,Error}
   Relup, see relup(4)
   Module = atom()
   Warnings = Error = term()

说明::

  生成release upgrade包含升级、降级指令文件relup.
  这些指令会在运行时系统安装新版本被release_handler使用。
  relup文件默认在当前目录，可以使用选项{outdir,Dir}指定

    对比Name.rel文件与UpFrom和DownTo指定的Name2.rel文件对比:
    1.哪个application会被删除（Name.rel有但Name2.rel没有）
    2.哪个application会被增加（Name.rel没有但Name2.rel有）
    3.哪个application会被升降级（都有但版本不同）
    4.如果2个rel文件中的erts版本不同，在升降级后要重启虚拟机


Opt选项::

  {path,[Dir]}: .app文件和.appup文件要在同一目录,此选项指定的目录会被append到当前目录
  restart_emulator: 升降级后重启系统
  silent: 默认error和warning信息会打印到tty，函数返回ok或error。如果指定此选项,函数返回:
      1.{ok,Relup,Module,Warnings}:Relup:是release的upgrade file
      2.{error,Module,Error}说明:Error和Warnings会通过调用
      Module:format_warning(Warnings) or Module:format_error(Error)
      转化为字串
  noexec: 类似silent只是不创建relup文件
  warnings_as_errors: warnings会被当作errors

其他::

  OTP R15应该进行了比较大的更新,更老版本升级到OTP R15以上需要特殊处理




make_script/1/2
'''''''''''''''''''''
结构::

  make_script/(Name) -> Result
  make_script(Name, [Opt]) -> Result
  类型:
  Name = string()
  Opt = src_tests | {path,[Dir]} | local | {variables,[Var]} | exref | {exref,[App]}] | silent | {outdir,Dir} | no_dot_erlang | no_warn_sasl | warnings_as_errors
   Dir = string()
   Var = {VarName,Prefix}
    VarName = Prefix = string()
   App = atom()
  Result = ok | error | {ok,Module,Warnings} | {error,Module,Error}
   Module = atom()
   Warnings = Error = term()

说明::

  输入Name.rel文件生成Name.script和它的二进制版本以及boot文件Name.boot

Opt::

  local: 在boot script中,使用发现应用的目录代替$ROOT/lib($ROOT是installed release的根目录)
  {outdir,Dir}: 生成文件.script和.boot的目录。默认是当前目录，可以改变
  src_tests: 模块源码缺失或比对象源码更新时报警
  no_warn_sasl: 当SASL不是.rel文件中的一个application,会有警告，
      因为这样的release不能用于upgrade，增加这个选项可以关闭警告
  {path,[Dir]}: Dir会被append到当前路径
  {variables,[Var]}: 指定安装目录代替$ROOT/lib
    实例:{variables,[{"TEST","lib"}]}:
      如myapp.app在目录lib/myapp/ebin下: "$TEST/myapp-1/ebin"
      如myapp.app在目录lib/test下: $TEST/test/myapp-1/ebin
  exref | {exref,[App]}: 使用工具Xref检查
  no_dot_erlang: 不包括在boot期间加载.erlang文件

make_tar/1/2
''''''''''''''''''
结构::

  make_tar(Name) -> Result
  make_tar(Name, [Opt]) -> Result
  类型:
  Name = string()
  Opt = {dirs,[IncDir]} | {path,[Dir]} | {variables,[Var]} | {var_tar,VarTar} | {erts,Dir} | src_tests | exref | {exref,[App]} | silent | {outdir,Dir} | | no_warn_sasl | warnings_as_errors
   Dir = string()
   IncDir = src | include | atom()
   Var = {VarName,PreFix}
    VarName = Prefix = string()
   VarTar = include | ownfile | omit
   Machine = atom()
   App = atom()
  Result = ok | error | {ok,Module,Warnings} | {error,Module,Error}
   Module = atom()
   Warning = Error = term()

说明::

  创建release package文件Name.tar.gz.此文件需要使用release_handler解压缩
  读取Name.rel文件确定哪些applications会包含到release中，然后读对应的App.app文件确定version和modules

选项::

  {var_tar,VarTar}: 指定在何处存储单独的包，其他变量VarTar:
    1.include:
    Each separate (variable) package is included in the main ReleaseName.tar.gz file. This is the default.
    2.ownfile
    Each separate (variable) package is generated as a separate file in the same directory as the ReleaseName.tar.gz file.
    3.omit
    No separate (variable) packages are generated. Applications that are found underneath a variable directory are ignored.




script2boot/1
'''''''''''''''''''
结构::

  script2boot(File) -> ok | error
  类型:
  File = string()

说明::

  通过Name.script生成Name.boot文件




