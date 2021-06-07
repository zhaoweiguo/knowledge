script模块
##################

Name.script: 用于生成Name.boot

文件语法::

  {script, {Name, Vsn},
   [
      {progress, loading},
      {preLoaded, [Mod1, Mod2, ...]},
      {path, [Dir1,"$ROOT/Dir",...]}.
      {primLoad, [Mod1, Mod2, ...]},
      ...
      {kernel_load_completed},
      {progress, loaded},
      {kernelProcess, Name, {Mod, Func, Args}},
      ...
      {apply, {Mod, Func, Args}},
      ...
      {progress, started}
    ]
  }.








