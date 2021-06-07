erlang.mk
==================

安装::

  $ wget https://erlang.mk/erlang.mk


常见操作::

  $ make -f erlang.mk bootstrap
  $ make -f erlang.mk bootstrap-lib
  $ make -f erlang.mk bootstrap-lib bootstrap-rel


其他::

  % 默认warning as error,加上下面参数后就不报警了
  ERLC_OPTS = -W0

::

  
  DEPS = cowboy jsx
  dep_cowboy_commit = 2.5.0
  dep_jsx = git https://github.com/talentdeficit/jsx 2.9.0

  BUILD_DEPS = leveldb
  dep_leveldb = git https://github.com/basho/leveldb 2.1.3

  SHELL_DEPS = tddreloader

  % 查询
  $ make search q=pool 
  $ make search | less





