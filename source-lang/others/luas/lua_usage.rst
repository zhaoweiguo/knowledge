lua使用
#################

注释::

  单行注释
  --
  多行注释
  --[[  ]]

依赖::

  -- 依赖abc.lua文件
  require("abc")
  -- 依赖cdf/abc.lua文件
  require("cdf.abc")  -- 以当前目录为主
  默认加载过程:
    1.package.loaded[modname]中存了模块的数据，有则直接返回
    2.顺序遍历package.searchers，获取loader
      2.1:package.preload[modname]
      2.2:Lua Loader, 通过package.searchpath搜索package.path
      2.3:C Loader, 通过package.searchpath搜索package.cpath
      2.4:All-In-One loader


defs.lua::

  function fact(n)
    if n < 2 then
      return 1
    else
      return n * fact(n - 1)
    end
  end

执行::

  > dofile("defs.lua")
  > print(fact(5))
  120

其他::

  > print(math.sin(math.pi / 3))
  0.86602540378444
  > print(math.sqrt(3) / 2)
  0.86602540378444

说明::

  local abc;  // 默认是global
  print no_such_variable;   // 默认值为nil
  print(s .. ", World!")



