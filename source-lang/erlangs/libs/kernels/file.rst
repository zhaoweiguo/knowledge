file模块
===================

.. contents::
   :depth: 1
   :local:
   :backlinks: none

.. highlight:: console

consult/1
''''''''''''''
结构::

  % 获取指定文件的内容
  % 只能打开erl文件？
  consult(Filename) -> {ok, Terms} | {error, Reason}
  %Reason = 
  %  posix() |
  %  badarg |
  %  terminated |
  %  system_limit |
  %  {Line :: integer(), Mod :: module(), Term :: term()}

open/2
'''''''''''
结构::

  open(File, Modes) -> {ok, IoDevice} | {error, Reason}
  类型:
  File = Filename | iodata()
    Filename = name_all()
  Modes = [mode() | ram]
  IoDevice = io_device()
  Reason = posix() | badarg | system_limit

mode::

    read |
    write |
    append |
    exclusive |
    raw |         % 1.允许更快的access
                  % 2.只有打开这个文件的erlang进程可用
                  % 3.远程节点不可用(必须有文件系统权限)
    binary |
    {delayed_write, Size, Delay} |  % 数据延时执行write/2操作
                                    % 1.数据大小超过Size bytes
                                    % 2.时间超过Delay milliseconds
    delayed_write |
    {read_ahead, Size} |
    read_ahead |
    compressed |
    {encoding, unicode:encoding()} |
    sync

read_file_info/1/2
'''''''''''''''''''''''''
结构::

  read_file_info(Filename) -> {ok, FileInfo} | {error, Reason}
  read_file_info(Filename, Opts) -> {ok, FileInfo} | {error, Reason}
  类型:
  Filename = name_all()
  Opts = [file_info_option()]
  FileInfo = file_info()    
  Reason = posix() | badarg

Opts类型::

    {time, local} |       % [default]
    {time, universal} | 
    {time, posix} |       % Returns seconds since or before Unix time epoch
    raw                   % 不调用file服务,只有local files的信息

file_info()返回值::

  格式: #file_info{} 
  来源:kernel/include/file.hrl
  结构:
    size  % Size of file in bytes.
    type  % 'device' | 'directory' | 'other' | 'regular' | 'symlink' | 'undefined',
    access % 'read' | 'write' | 'read_write' | 'none' | 'undefined',
    atime  % The local time the file was last read:
           % {{Year, Mon, Day}, {Hour, Min, Sec}}.
    mtime  % The local time the file was last written.
    ctime  % On Unix it is the last time the file or the inode was changed.  
           % On Windows, it is the creation time.
    mode   % File permissions.
    links  % Number of links to the file 
    major_device  % Identifies the file system (Unix),
                  % the drive number (A: = 0, B: = 1) (Windows).
    %% The following are Unix specific.
    %% They are set to 0 on other operating systems.
    minor_device  % Only valid for devices.
    inode    % Inode number for file.
    uid      % uid
    gid      % gid

read/2
'''''''''''''''
结构::

  read(IoDevice, Number) -> {ok, Data} | eof | {error, Reason}
  类型:
  IoDevice = io_device() | atom()
  Number = integer() >= 0
  Data = string() | binary()
  Reason = 
      posix() |
      badarg |
      terminated |
      {no_translation, unicode, latin1}

说明::

  其中Number可用filelib:file_size(FilePath)获取


实例
''''''''''''
打开文件并读取其中内容::

  64> {ok,File}=file:open("fibo.erl",[raw,read]).  
  65> {ok,Data}=file:read(File,filelib:file_size("fibo.erl")).  









