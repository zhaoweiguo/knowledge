code模块
##############

mode::

  erl -mode embedded
  1.interactive:默认
  初使只有部分code被加载,剩下code在被使用时动态加载
  2.embedded:
  启动时加载所有modules

说明::

  kernel, stdlib, and compiler
  此3模块默认不可被reload
  可使用-nostick这个flag解除限制

.. function:: load_file/1

结构::

    load_file(Module) -> load_ret()
    Types
    Module = module()
    load_ret() = 
        {error, What :: load_error_rsn()} |
        {module, Module :: module()}

.. function:: add_path/1

::

  add_path(Dir) -> add_path_ret()
  add_pathz(Dir) -> add_path_ret()
  add_patha(Dir) -> add_path_ret()
  add_paths(Dirs) -> ok
  add_pathsz(Dirs) -> ok
  add_pathsa(Dirs) -> ok
  del_path(NameOrDir) -> boolean() | {error, What}

.. function:: get_object_code/1

结构::

  get_object_code(Module) -> {Module, Binary, Filename} | error
  类型:
  Module = module()
  Binary = binary()
  Filename = file:filename()

说明::

  Searches the code path for the object code of module Module.
  成功: {Module, Binary, Filename} 
  失败: error. 
  Binary是二进制的数据对象, 里面contains此模块的object code
  
  此函数用于:在分布式的远程系统中load本地代码
  

实例::

  % 在Node结点上加载Module模块
  {Module, Binary, Filename} = code:get_object_code(Module),
  rpc:call(Node, code, load_binary, [Module, Filename, Binary]),


.. function:: purge/1

::

    purge(Module) -> boolean()
    Types
    Module = module()

说明::

    Purges the code for Module, that is, removes code marked as old. If some processes still linger in the old code, these processes are killed before the code is removed.
    清除Module的代码,即删除标识为旧的代码。
    如某些进程仍然在旧代码中停留,会在删除代码前杀死进程

    Returns true if successful and any process is needed to be killed, otherwise false.

.. note::

    As of ERTS version 9.0, a process is only considered to be lingering in the code if it has direct references to the code. For more information see documentation of erlang:check_process_code/3, which is used in order to determine this.



其他
''''''''
::

  all_loaded() -> [{Module, Loaded}]
  which(Module) -> Which
  is_loaded(Module) -> {file, Loaded} | false
















